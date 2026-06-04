#!/usr/bin/env python3
"""
Deterministic validation of init_project.sh and initialization documentation.

Checks that template values, file paths, and Makefile targets are consistent
with the actual project state.

Usage:
    python3 validate_init.py --project-root /path/to/project
"""

import argparse
import json
import os
import re
import subprocess
import sys
from dataclasses import dataclass, field, asdict
from pathlib import Path
from typing import Optional


@dataclass
class Finding:
    severity: str  # ERROR or WARNING
    check: str
    file: str
    message: str
    suggestion: str
    line: Optional[int] = None


@dataclass
class ValidationResult:
    errors: int = 0
    warnings: int = 0
    findings: list = field(default_factory=list)

    def add(self, finding: Finding):
        if finding.severity == "ERROR":
            self.errors += 1
        else:
            self.warnings += 1
        self.findings.append(finding)


# Template values that init_project.sh is expected to replace.
# Maps: constant name -> (value, list of files where it MUST appear)
EXPECTED_OLD_VALUES = {
    "OLD_DART_NAME": {
        "value": "surf_standard",
        "files": [
            "apps/main/pubspec.yaml",
            "pubspec.yaml",
        ],
        "pattern_in_file": {
            "apps/main/pubspec.yaml": "name: surf_standard",
            "pubspec.yaml": "surf_standard",
        },
    },
    "OLD_WORKSPACE_NAME": {
        "value": "surf_standard_workspace",
        "files": ["pubspec.yaml"],
        "pattern_in_file": {"pubspec.yaml": "surf_standard_workspace"},
    },
    "OLD_DESCRIPTION": {
        "value": "Surf Standard App for faster start",
        "files": ["apps/main/pubspec.yaml"],
        "pattern_in_file": {
            "apps/main/pubspec.yaml": "Surf Standard App for faster start"
        },
    },
    "OLD_ANDROID_PACKAGE": {
        "value": "dev.surf.surf_skeleton",
        "files": ["apps/main/android/app/build.gradle.kts"],
        "pattern_in_file": {
            "apps/main/android/app/build.gradle.kts": "dev.surf.surf_skeleton"
        },
    },
    "OLD_IOS_BUNDLE_ID": {
        "value": "com.example.surfSkeleton",
        "files": ["apps/main/ios/Runner.xcodeproj/project.pbxproj"],
        "pattern_in_file": {
            "apps/main/ios/Runner.xcodeproj/project.pbxproj": "com.example.surfSkeleton"
        },
    },
    "OLD_IOS_TEAM_ID": {
        "value": "7C678J328W",
        "files": ["apps/main/ios/Runner.xcodeproj/project.pbxproj"],
        "pattern_in_file": {
            "apps/main/ios/Runner.xcodeproj/project.pbxproj": "7C678J328W"
        },
    },
    "OLD_DISPLAY_NAME": {
        "value": "Surf Skeleton",
        "files": [
            "apps/main/android/app/src/main/res/values/strings.xml",
            "apps/main/ios/Runner/Info.plist",
        ],
        "pattern_in_file": {
            "apps/main/android/app/src/main/res/values/strings.xml": "Surf Skeleton",
            "apps/main/ios/Runner/Info.plist": "Surf Skeleton",
        },
    },
    "OLD_BUNDLE_NAME": {
        "value": "surf_skeleton",
        "files": ["apps/main/ios/Runner/Info.plist"],
        "pattern_in_file": {"apps/main/ios/Runner/Info.plist": "surf_skeleton"},
    },
    "OLD_README_TITLE": {
        "value": "# APP_NAME",
        "files": ["README.md"],
        "pattern_in_file": {"README.md": "# APP_NAME"},
    },
}

# Files that the init script is expected to process.
SCRIPT_TARGET_FILES = [
    "pubspec.yaml",
    "apps/main/pubspec.yaml",
    "apps/main/android/app/build.gradle.kts",
    "apps/main/android/app/src/main/res/values/strings.xml",
    "apps/main/ios/Runner.xcodeproj/project.pbxproj",
    "apps/main/ios/Runner/Info.plist",
    "apps/main/ios/prodExportOptions.plist",
    "apps/main/ios/stageExportOptions.plist",
    "README.md",
    "APPROVALRULES.template",
    "CODEOWNERS.template",
]

# Directories where the script does find+replace for Dart imports
SCRIPT_DART_DIRS = [
    "apps/main/lib",
    "apps/main/tools/bricks",
]

SCRIPT_MDC_DIR = ".cursor/rules"

# Android Kotlin source directory (old path)
OLD_KOTLIN_DIR = "apps/main/android/app/src/main/kotlin/dev/surf/surf_skeleton"

# Non-constant placeholder values the script expects to find and replace.
# These are hardcoded in phase functions, not defined as OLD_* constants.
SCRIPT_PLACEHOLDER_VALUES = {
    "export_plist_prod_bundle_id": {
        "pattern": "prod.bundle.id",
        "file": "apps/main/ios/prodExportOptions.plist",
        "script_context": "phase_ios() — prod export plist bundle ID placeholder",
    },
    "export_plist_stage_bundle_id": {
        "pattern": "stage.bundle.id",
        "file": "apps/main/ios/stageExportOptions.plist",
        "script_context": "phase_ios() — stage export plist bundle ID placeholder",
    },
    "export_plist_prod_team_id": {
        "pattern": "TEAM_ID",
        "file": "apps/main/ios/prodExportOptions.plist",
        "script_context": "phase_ios() — prod export plist team ID placeholder",
    },
    "export_plist_stage_team_id": {
        "pattern": "TEAM_ID",
        "file": "apps/main/ios/stageExportOptions.plist",
        "script_context": "phase_ios() — stage export plist team ID placeholder",
    },
    "gradle_flavor_stage": {
        "pattern": 'resValue("string", "app_name", "Stage")',
        "file": "apps/main/android/app/build.gradle.kts",
        "script_context": "phase_android() — stage flavor display name",
    },
    "gradle_flavor_prod": {
        "pattern": 'resValue("string", "app_name", "Prod")',
        "file": "apps/main/android/app/build.gradle.kts",
        "script_context": "phase_android() — prod flavor display name",
    },
}

# App modules the script is known to handle
KNOWN_APP_MODULES = {"main"}

# Template value patterns to scan for in the codebase
TEMPLATE_PATTERNS = [
    "surf_standard",
    "surf_skeleton",
    "surfSkeleton",
    "Surf Skeleton",
    "7C678J328W",
]

# File extensions to scan
SCAN_EXTENSIONS = {
    ".dart", ".yaml", ".yml", ".kts", ".gradle", ".xml",
    ".kt", ".java", ".swift", ".plist", ".pbxproj",
    ".xcscheme", ".mdc", ".md",
}

# Directories/files to exclude from scanning
SCAN_EXCLUDES = {
    ".git", ".fvm", "build", ".idea", "node_modules",
    "init_project.sh", ".dart_tool",
}

# Directories whose files reference template values as documentation/examples
SCAN_EXCLUDE_DIRS = {
    ".claude/skills",
}

DOC_FILE = "docs/guides/008-project-initialization.ru.md"


def file_contains(root: Path, rel_path: str, pattern: str) -> bool:
    full = root / rel_path
    if not full.exists():
        return False
    try:
        content = full.read_text(encoding="utf-8", errors="ignore")
        return pattern in content
    except Exception:
        return False


def check_script_exists(root: Path, result: ValidationResult):
    script = root / "init_project.sh"
    if not script.exists():
        result.add(Finding(
            severity="ERROR",
            check="script_exists",
            file="init_project.sh",
            message="init_project.sh does not exist.",
            suggestion="Create init_project.sh in the project root.",
        ))
        return False

    if not os.access(script, os.X_OK):
        result.add(Finding(
            severity="WARNING",
            check="script_executable",
            file="init_project.sh",
            message="init_project.sh is not executable.",
            suggestion="Run: chmod +x init_project.sh",
        ))
    return True


def check_doc_exists(root: Path, result: ValidationResult):
    doc = root / DOC_FILE
    if not doc.exists():
        result.add(Finding(
            severity="ERROR",
            check="doc_exists",
            file=DOC_FILE,
            message="Initialization documentation does not exist.",
            suggestion=f"Create {DOC_FILE}.",
        ))
        return False
    return True


def check_makefile_targets(root: Path, result: ValidationResult):
    targets_found = {"init-project": False, "init-project-dry": False}

    for mk_file in (root / "make").glob("*.mk"):
        try:
            content = mk_file.read_text(encoding="utf-8")
            for target in targets_found:
                if re.search(rf"^{re.escape(target)}\s*:", content, re.MULTILINE):
                    targets_found[target] = True
        except Exception:
            continue

    # Also check root Makefile
    makefile = root / "Makefile"
    if makefile.exists():
        try:
            content = makefile.read_text(encoding="utf-8")
            for target in targets_found:
                if re.search(rf"^{re.escape(target)}\s*:", content, re.MULTILINE):
                    targets_found[target] = True
        except Exception:
            pass

    for target, found in targets_found.items():
        if not found:
            result.add(Finding(
                severity="ERROR",
                check="makefile_target",
                file="make/project.mk",
                message=f"Makefile target '{target}' not found.",
                suggestion=f"Add '{target}' target to make/project.mk.",
            ))


def check_old_values_exist(root: Path, result: ValidationResult):
    for const_name, info in EXPECTED_OLD_VALUES.items():
        value = info["value"]
        for rel_file in info["files"]:
            full_path = root / rel_file
            if not full_path.exists():
                result.add(Finding(
                    severity="ERROR",
                    check="old_value_target_missing",
                    file=rel_file,
                    message=f"Target file for {const_name} does not exist: {rel_file}",
                    suggestion=f"The init script expects to find '{value}' in {rel_file}, but the file doesn't exist. "
                               f"Update {const_name} in init_project.sh or create the missing file.",
                ))
                continue

            pattern = info["pattern_in_file"].get(rel_file, value)
            if not file_contains(root, rel_file, pattern):
                result.add(Finding(
                    severity="ERROR",
                    check="old_value_not_found",
                    file=rel_file,
                    message=f"{const_name}='{value}' not found in {rel_file}. "
                            f"Searched for: '{pattern}'",
                    suggestion=f"Either update {const_name} in init_project.sh to match the actual value "
                               f"in {rel_file}, or restore the expected template value.",
                ))


def check_target_files_exist(root: Path, result: ValidationResult):
    for rel_path in SCRIPT_TARGET_FILES:
        full = root / rel_path
        # .template files are optional (they may have been renamed already)
        if rel_path.endswith(".template"):
            continue
        if not full.exists():
            result.add(Finding(
                severity="ERROR",
                check="target_file_missing",
                file=rel_path,
                message=f"Script target file does not exist: {rel_path}",
                suggestion=f"The init script expects this file to exist. "
                           f"Restore it or update the script.",
            ))


def check_kotlin_dir(root: Path, result: ValidationResult):
    kotlin_dir = root / OLD_KOTLIN_DIR
    main_activity = kotlin_dir / "MainActivity.kt"
    if not main_activity.exists():
        result.add(Finding(
            severity="WARNING",
            check="kotlin_dir",
            file=OLD_KOTLIN_DIR + "/MainActivity.kt",
            message="MainActivity.kt not found at expected old path. "
                    "It may have been moved already.",
            suggestion="If this is intentional, update OLD_ANDROID_KOTLIN_PATH in init_project.sh.",
        ))


def check_dart_import_dirs(root: Path, result: ValidationResult):
    for dir_path in SCRIPT_DART_DIRS:
        full = root / dir_path
        if not full.exists():
            result.add(Finding(
                severity="ERROR",
                check="dart_dir_missing",
                file=dir_path,
                message=f"Dart source directory for import replacement does not exist: {dir_path}",
                suggestion=f"The init script processes .dart files in this directory. "
                           f"Restore it or update the script.",
            ))


def check_mdc_dir(root: Path, result: ValidationResult):
    mdc_dir = root / SCRIPT_MDC_DIR
    if not mdc_dir.exists():
        result.add(Finding(
            severity="WARNING",
            check="mdc_dir_missing",
            file=SCRIPT_MDC_DIR,
            message=f"Cursor rules directory does not exist: {SCRIPT_MDC_DIR}",
            suggestion="The init script replaces package references in .mdc files. "
                       "Restore the directory or update the script.",
        ))


def check_script_placeholders(root: Path, result: ValidationResult):
    """
    Check that non-constant placeholder values the script expects to find
    actually exist in their target files. These are hardcoded replacement
    patterns in phase functions (not OLD_* constants).
    """
    for name, info in SCRIPT_PLACEHOLDER_VALUES.items():
        rel_file = info["file"]
        pattern = info["pattern"]
        context = info["script_context"]
        full_path = root / rel_file

        if not full_path.exists():
            # Target file missing is caught by check_target_files_exist
            continue

        if not file_contains(root, rel_file, pattern):
            result.add(Finding(
                severity="ERROR",
                check="placeholder_not_found",
                file=rel_file,
                message=f"Script placeholder '{pattern}' not found in {rel_file}. "
                        f"Context: {context}",
                suggestion=f"The init script expects to replace '{pattern}' in this file. "
                           f"Either restore the placeholder or update the script.",
            ))



def check_app_modules(root: Path, result: ValidationResult):
    """Check if new app modules exist that the init script doesn't handle."""
    apps_dir = root / "apps"
    if not apps_dir.exists():
        return

    for child in sorted(apps_dir.iterdir()):
        if not child.is_dir() or child.name in KNOWN_APP_MODULES:
            continue
        # Only flag real app/package modules (have pubspec.yaml)
        if not (child / "pubspec.yaml").exists():
            continue

        has_template = False
        for ext in (".kts", ".pbxproj", ".plist", ".xml", ".yaml"):
            if has_template:
                break
            for f in child.rglob(f"*{ext}"):
                try:
                    content = f.read_text(encoding="utf-8", errors="ignore")
                    if any(p in content for p in TEMPLATE_PATTERNS):
                        has_template = True
                        break
                except Exception:
                    continue

        if has_template:
            result.add(Finding(
                severity="WARNING",
                check="new_app_module",
                file=f"apps/{child.name}",
                message=f"App module 'apps/{child.name}' contains template values "
                        f"but init_project.sh only processes apps/main.",
                suggestion=f"Update init_project.sh to also process apps/{child.name}, "
                           f"or confirm that template values in this module are intentional.",
            ))


def should_exclude(path: Path) -> bool:
    parts = path.parts
    for part in parts:
        if part in SCAN_EXCLUDES:
            return True
    return False


def scan_uncovered_template_values(root: Path, result: ValidationResult):
    """
    Scan the codebase for template values and check if the init script covers them.
    """
    # Directories the script processes (covers via find + sed)
    covered_dirs = set()
    for d in SCRIPT_DART_DIRS:
        covered_dirs.add(root / d)
    covered_dirs.add(root / SCRIPT_MDC_DIR)

    # Individual files the script processes
    covered_files = set()
    for f in SCRIPT_TARGET_FILES:
        covered_files.add((root / f).resolve() if (root / f).exists() else root / f)
    # Kotlin file is also covered (moved, not sed-replaced in place, but still handled)
    covered_files.add(root / OLD_KOTLIN_DIR / "MainActivity.kt")

    def is_covered(file_path: Path) -> bool:
        resolved = file_path.resolve() if file_path.exists() else file_path
        if resolved in covered_files:
            return True
        for cd in covered_dirs:
            try:
                file_path.relative_to(cd)
                return True
            except ValueError:
                continue
        return False

    uncovered = {}

    for ext in SCAN_EXTENSIONS:
        for fpath in root.rglob(f"*{ext}"):
            if should_exclude(fpath.relative_to(root)):
                continue
            if fpath.name == "init_project.sh":
                continue
            # Skip docs/guides (contains old values as examples)
            try:
                fpath.relative_to(root / "docs" / "guides")
                continue
            except ValueError:
                pass
            # Skip skill directories (contain old values as documentation)
            skip = False
            for excl_dir in SCAN_EXCLUDE_DIRS:
                try:
                    fpath.relative_to(root / excl_dir)
                    skip = True
                    break
                except ValueError:
                    continue
            if skip:
                continue

            try:
                content = fpath.read_text(encoding="utf-8", errors="ignore")
            except Exception:
                continue

            for pattern in TEMPLATE_PATTERNS:
                if pattern in content:
                    rel = str(fpath.relative_to(root))
                    if not is_covered(fpath):
                        if rel not in uncovered:
                            uncovered[rel] = []
                        if pattern not in uncovered[rel]:
                            uncovered[rel].append(pattern)

    for rel_file, patterns in uncovered.items():
        patterns_str = ", ".join(f"'{p}'" for p in patterns)
        result.add(Finding(
            severity="WARNING",
            check="uncovered_template_value",
            file=rel_file,
            message=f"File contains template value(s) {patterns_str} "
                    f"but is not in init script's replacement scope.",
            suggestion="Either add this file to the init script's processing, "
                       "or confirm this is expected (e.g., generated file, example code).",
        ))


def check_doc_paths(root: Path, result: ValidationResult):
    """Check that file paths mentioned in the documentation actually exist."""
    doc_path = root / DOC_FILE
    if not doc_path.exists():
        return

    try:
        content = doc_path.read_text(encoding="utf-8")
    except Exception:
        return

    # Extract paths that look like project-relative file paths
    # Match patterns like `apps/main/...`, `pubspec.yaml`, `.cursor/...`, `infra/...`, `make/...`
    path_pattern = re.compile(
        r'`((?:apps|modules|pubspec|\.cursor|infra|make|docs|README|INIT|APPROVALRULES|CODEOWNERS)'
        r'[a-zA-Z0-9_./{}\-]*)`'
    )

    # Files that are expected to not exist (referenced as post-init state or examples)
    doc_expected_missing = {
        "APPROVALRULES", "CODEOWNERS", "INIT.md",
    }

    found_paths = set()
    for match in path_pattern.finditer(content):
        p = match.group(1)
        # Skip paths with template placeholders
        if "{{" in p or "<" in p or ">" in p:
            continue
        # Skip placeholder example paths (yourcompany, your_project, etc.)
        if "yourcompany" in p or "your_project" in p or "your-project" in p:
            continue
        found_paths.add(p)

    for p in found_paths:
        full = root / p
        # Template files and expected-missing files are OK
        if p.endswith(".template") or p in doc_expected_missing:
            continue
        if not full.exists():
            result.add(Finding(
                severity="WARNING",
                check="doc_path_invalid",
                file=DOC_FILE,
                message=f"Documentation references non-existent path: {p}",
                suggestion=f"Update the documentation to use the correct path, "
                           f"or create the missing file.",
            ))


def check_script_old_values_sync(root: Path, result: ValidationResult):
    """
    Parse init_project.sh to extract OLD_* constants and verify they match
    EXPECTED_OLD_VALUES. If someone edits the script but not this validator
    (or vice versa), we want to catch the drift.
    """
    script_path = root / "init_project.sh"
    if not script_path.exists():
        return

    try:
        content = script_path.read_text(encoding="utf-8")
    except Exception:
        return

    # Extract OLD_* assignments
    old_pattern = re.compile(r'^(OLD_\w+)="([^"]*)"', re.MULTILINE)
    script_values = {}
    for match in old_pattern.finditer(content):
        script_values[match.group(1)] = match.group(2)

    # Check that all expected constants are present in the script
    for const_name, info in EXPECTED_OLD_VALUES.items():
        if const_name not in script_values:
            result.add(Finding(
                severity="ERROR",
                check="script_constant_missing",
                file="init_project.sh",
                message=f"Expected constant {const_name} not found in init_project.sh.",
                suggestion=f"Add {const_name}=\"{info['value']}\" to the script header.",
            ))
        elif script_values[const_name] != info["value"]:
            result.add(Finding(
                severity="ERROR",
                check="script_constant_mismatch",
                file="init_project.sh",
                message=f"{const_name} in script is '{script_values[const_name]}' "
                        f"but validator expects '{info['value']}'.",
                suggestion="Update either the script or this validator to match. "
                           "Check the actual value in the target file.",
            ))

    # Reverse check: constants in the script but not tracked by the validator.
    # Some OLD_* constants are path-based (validated by dedicated checks like
    # check_kotlin_dir), not content patterns in files.
    path_constants = {"OLD_ANDROID_KOTLIN_PATH"}
    for const_name, value in script_values.items():
        if const_name in path_constants:
            continue
        if const_name not in EXPECTED_OLD_VALUES:
            result.add(Finding(
                severity="WARNING",
                check="script_constant_unknown",
                file="init_project.sh",
                message=f"Script contains {const_name}=\"{value}\" which is not "
                        f"tracked by the validator.",
                suggestion=f"Add {const_name} to EXPECTED_OLD_VALUES in "
                           f"validate_init.py, or remove it from the script if unused.",
            ))


def main():
    parser = argparse.ArgumentParser(
        description="Validate init_project.sh and initialization documentation."
    )
    parser.add_argument(
        "--project-root",
        required=True,
        help="Path to the project root directory.",
    )
    args = parser.parse_args()

    root = Path(args.project_root).resolve()
    if not root.exists():
        print(json.dumps({"error": f"Project root does not exist: {root}"}))
        sys.exit(1)

    result = ValidationResult()

    script_ok = check_script_exists(root, result)
    doc_ok = check_doc_exists(root, result)
    check_makefile_targets(root, result)

    if script_ok:
        check_script_old_values_sync(root, result)
        check_script_placeholders(root, result)

    check_old_values_exist(root, result)
    check_target_files_exist(root, result)
    check_kotlin_dir(root, result)
    check_dart_import_dirs(root, result)
    check_mdc_dir(root, result)
    check_app_modules(root, result)
    scan_uncovered_template_values(root, result)

    if doc_ok:
        check_doc_paths(root, result)

    output = {
        "summary": {
            "script_exists": script_ok,
            "doc_exists": doc_ok,
            "errors": result.errors,
            "warnings": result.warnings,
        },
        "findings": [asdict(f) for f in result.findings],
    }

    print(json.dumps(output, indent=2, ensure_ascii=False))


if __name__ == "__main__":
    main()

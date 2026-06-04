#!/usr/bin/env python3
"""Deterministic validation of .cursor/rules and .claude/skills files.

Checks cross-references, frontmatter, and structural issues.
Outputs JSON to stdout for consumption by the validate-ai-setup skill.

Usage:
    python3 validate.py --project-root /path/to/project
"""

import argparse
import hashlib
import json
import re
import sys
from pathlib import Path

MDC_LINK_PATTERN = re.compile(r'\[([^\]]*)\]\(mdc:([^)]+)\)')
FRONTMATTER_DELIM = re.compile(r'^---\s*$', re.MULTILINE)
BAD_EXAMPLE_MARKERS = re.compile(
    r'\b(BAD|incorrect|wrong|don\'t|avoid)\b', re.IGNORECASE,
)
PROHIBITED_TOOLS = ('fvm', 'flutter', 'dart', 'melos', 'mason', 'dcm', 'fastlane', 'bundle')

AI_REVIEW_RULES_FILE = 'AI_CODE_REVIEW_RULES.md'
AI_REVIEW_SOURCE_COMMENT = re.compile(
    r'<!--\s*source:\s*(?P<path>[^\s|]+)\s*\|\s*sha256:\s*(?P<hash>[a-f0-9]{64})\s*-->'
)
# Rules excluded from AI review document (developer workflow, not code review criteria)
AI_REVIEW_EXCLUDED_RULES = {'fvm-usage.mdc', 'use-makefile.mdc'}


def parse_frontmatter(content: str) -> tuple[dict[str, str] | None, str]:
    """Parse YAML frontmatter from file content.

    Returns (frontmatter_dict, body) or (None, full_content) if no frontmatter.
    """
    parts = FRONTMATTER_DELIM.split(content, maxsplit=2)
    if len(parts) < 3:
        return None, content

    raw_fm = parts[1]
    body = parts[2]

    fm = {}
    for line in raw_fm.strip().splitlines():
        line = line.strip()
        if not line or line.startswith('#'):
            continue
        if ':' in line:
            key, _, value = line.partition(':')
            fm[key.strip()] = value.strip()

    return fm, body


def extract_mdc_links(content: str) -> list[tuple[int, str, str]]:
    """Extract all mdc: links from content.

    Returns list of (line_number, display_text, target_path).
    """
    links = []
    for i, line in enumerate(content.splitlines(), start=1):
        for match in MDC_LINK_PATTERN.finditer(line):
            links.append((i, match.group(1), match.group(2)))
    return links


def check_rule_files(project_root: Path, findings: list[dict]) -> list[Path]:
    """Validate all .cursor/rules/*.mdc files. Returns list of rule paths."""
    rules_dir = project_root / '.cursor' / 'rules'
    if not rules_dir.is_dir():
        findings.append({
            'severity': 'ERROR',
            'check': 'missing_directory',
            'file': '.cursor/rules/',
            'line': 0,
            'message': 'Rules directory does not exist',
            'suggestion': 'Create .cursor/rules/ directory',
        })
        return []

    rule_files = sorted(rules_dir.glob('*.mdc'))
    for rule_path in rule_files:
        rel_path = str(rule_path.relative_to(project_root))
        content = rule_path.read_text(encoding='utf-8')

        fm, body = parse_frontmatter(content)
        validate_rule_frontmatter(rel_path, fm, findings)
        validate_body(rel_path, body, findings)
        validate_mdc_links(project_root, rel_path, content, findings)

    return rule_files


def check_skill_files(project_root: Path, findings: list[dict]) -> list[Path]:
    """Validate all .claude/skills/*/SKILL.md files. Returns list of skill paths."""
    skills_dir = project_root / '.claude' / 'skills'
    if not skills_dir.is_dir():
        findings.append({
            'severity': 'ERROR',
            'check': 'missing_directory',
            'file': '.claude/skills/',
            'line': 0,
            'message': 'Skills directory does not exist',
            'suggestion': 'Create .claude/skills/ directory',
        })
        return []

    skill_files = []
    for skill_dir in sorted(skills_dir.iterdir()):
        if not skill_dir.is_dir():
            continue
        skill_path = skill_dir / 'SKILL.md'
        if not skill_path.is_file():
            continue

        skill_files.append(skill_path)
        rel_path = str(skill_path.relative_to(project_root))
        content = skill_path.read_text(encoding='utf-8')

        fm, body = parse_frontmatter(content)
        validate_skill_frontmatter(rel_path, skill_dir.name, fm, findings)
        validate_body(rel_path, body, findings)
        validate_mdc_links(project_root, rel_path, content, findings)

    return skill_files


def validate_rule_frontmatter(
    rel_path: str, fm: dict[str, str] | None, findings: list[dict]
) -> None:
    """Validate frontmatter of a .mdc rule file."""
    if fm is None:
        findings.append({
            'severity': 'ERROR',
            'check': 'missing_frontmatter',
            'file': rel_path,
            'line': 1,
            'message': 'File has no YAML frontmatter',
            'suggestion': 'Add frontmatter with at least a description field',
        })
        return

    desc = fm.get('description', '').strip()
    if not desc:
        findings.append({
            'severity': 'WARNING',
            'check': 'missing_description',
            'file': rel_path,
            'line': 1,
            'message': 'Frontmatter has no description or description is empty',
            'suggestion': 'Add a meaningful description field',
        })

    always_apply = fm.get('alwaysApply', '').strip().lower()
    globs = fm.get('globs', '').strip()

    if always_apply == 'true' and globs:
        findings.append({
            'severity': 'WARNING',
            'check': 'invalid_frontmatter_combo',
            'file': rel_path,
            'line': 1,
            'message': f'alwaysApply is true but globs is also set to "{globs}"',
            'suggestion': (
                'If this rule applies to all files, remove globs. '
                'If it applies to specific globs, set alwaysApply: false.'
            ),
        })


def validate_skill_frontmatter(
    rel_path: str,
    dir_name: str,
    fm: dict[str, str] | None,
    findings: list[dict],
) -> None:
    """Validate frontmatter of a SKILL.md file."""
    if fm is None:
        findings.append({
            'severity': 'ERROR',
            'check': 'missing_frontmatter',
            'file': rel_path,
            'line': 1,
            'message': 'Skill file has no YAML frontmatter',
            'suggestion': 'Add frontmatter with name and description fields',
        })
        return

    name = fm.get('name', '').strip()
    if not name:
        findings.append({
            'severity': 'WARNING',
            'check': 'missing_skill_name',
            'file': rel_path,
            'line': 1,
            'message': 'Skill frontmatter has no name field',
            'suggestion': f'Add name: {dir_name}',
        })
    elif name != dir_name:
        findings.append({
            'severity': 'WARNING',
            'check': 'skill_name_mismatch',
            'file': rel_path,
            'line': 1,
            'message': f'Skill name "{name}" does not match directory name "{dir_name}"',
            'suggestion': f'Rename to name: {dir_name} or rename the directory to {name}/',
        })

    desc = fm.get('description', '').strip()
    if not desc:
        findings.append({
            'severity': 'WARNING',
            'check': 'missing_description',
            'file': rel_path,
            'line': 1,
            'message': 'Skill frontmatter has no description',
            'suggestion': 'Add a description explaining what the skill does and when to use it',
        })


def validate_body(rel_path: str, body: str, findings: list[dict]) -> None:
    """Check that file body has meaningful content."""
    stripped = body.strip()
    if len(stripped) < 50:
        findings.append({
            'severity': 'WARNING',
            'check': 'empty_body',
            'file': rel_path,
            'line': 1,
            'message': f'File body is very short ({len(stripped)} chars)',
            'suggestion': 'Add meaningful content or remove the file if no longer needed',
        })


def validate_mdc_links(
    project_root: Path, rel_path: str, content: str, findings: list[dict]
) -> None:
    """Validate all mdc: links in a file."""
    links = extract_mdc_links(content)

    for line_num, display_text, target in links:
        target_path = project_root / target

        if not target_path.exists():
            is_rule_ref = target.endswith('.mdc')
            findings.append({
                'severity': 'ERROR',
                'check': 'broken_rule_reference' if is_rule_ref else 'broken_project_reference',
                'file': rel_path,
                'line': line_num,
                'message': f'mdc: link target does not exist: {target}',
                'suggestion': 'Update the path to point to the correct file or remove the reference',
            })


def extract_section(content: str, heading: str) -> str:
    """Extract content of a markdown section by heading.

    Returns text between the given heading and the next heading of equal or
    higher level, or end of file.
    """
    lines = content.splitlines()
    level = 0
    start = -1

    for i, line in enumerate(lines):
        stripped = line.strip()
        if stripped.startswith('#'):
            hashes = len(stripped) - len(stripped.lstrip('#'))
            title = stripped.lstrip('#').strip()
            if title == heading:
                level = hashes
                start = i + 1
            elif start >= 0 and hashes <= level:
                return '\n'.join(lines[start:i])

    if start >= 0:
        return '\n'.join(lines[start:])
    return ''


def check_claude_md_index(project_root: Path, findings: list[dict]) -> None:
    """Validate CLAUDE.md index against actual rule/skill files on disk."""
    claude_md = project_root / 'CLAUDE.md'
    if not claude_md.is_file():
        findings.append({
            'severity': 'ERROR',
            'check': 'claude_md_missing',
            'file': 'CLAUDE.md',
            'line': 0,
            'message': 'CLAUDE.md does not exist',
            'suggestion': 'Create CLAUDE.md with rules and skills index',
        })
        return

    content = claude_md.read_text(encoding='utf-8')

    # Forward validation: check all mdc: links point to existing files
    validate_mdc_links(project_root, 'CLAUDE.md', content, findings)

    # Extract links from specific sections for reverse checks
    rules_index_section = extract_section(content, 'Rules Index')
    skills_index_section = extract_section(content, 'Skills Index')

    rules_index_paths = {
        target for (_, _, target) in extract_mdc_links(rules_index_section)
    }
    skills_index_paths = {
        target for (_, _, target) in extract_mdc_links(skills_index_section)
    }

    # Reverse check: rules on disk not linked from Rules Index section
    rules_dir = project_root / '.cursor' / 'rules'
    if rules_dir.is_dir():
        for rule_path in sorted(rules_dir.glob('*.mdc')):
            rel = str(rule_path.relative_to(project_root))
            if rel not in rules_index_paths:
                findings.append({
                    'severity': 'WARNING',
                    'check': 'claude_md_rule_missing_from_index',
                    'file': rel,
                    'line': 0,
                    'message': f'Rule file exists but is not in the Rules Index: {rel}',
                    'suggestion': f'Add [name](mdc:{rel}) to the Rules Index in CLAUDE.md',
                })

    # Reverse check: skills on disk not linked from Skills Index section
    skills_dir = project_root / '.claude' / 'skills'
    if skills_dir.is_dir():
        for skill_dir in sorted(skills_dir.iterdir()):
            if not skill_dir.is_dir():
                continue
            skill_path = skill_dir / 'SKILL.md'
            if not skill_path.is_file():
                continue
            rel = str(skill_path.relative_to(project_root))
            if rel not in skills_index_paths:
                findings.append({
                    'severity': 'WARNING',
                    'check': 'claude_md_skill_missing_from_index',
                    'file': rel,
                    'line': 0,
                    'message': f'Skill file exists but is not in the Skills Index: {rel}',
                    'suggestion': f'Add [name](mdc:{rel}) to the Skills Index in CLAUDE.md',
                })


def parse_makefile_targets(project_root: Path) -> set[str]:
    """Extract all make target names from Makefile and make/*.mk includes."""
    targets: set[str] = set()
    makefile_paths = [project_root / 'Makefile']
    make_dir = project_root / 'make'
    if make_dir.is_dir():
        makefile_paths.extend(sorted(make_dir.glob('*.mk')))

    target_re = re.compile(r'^([a-zA-Z][a-zA-Z0-9_-]*)\s*:')

    for mf_path in makefile_paths:
        if not mf_path.is_file():
            continue
        for line in mf_path.read_text(encoding='utf-8').splitlines():
            # Skip variable assignments
            if ':=' in line or '?=' in line or '+=' in line:
                continue
            m = target_re.match(line)
            if m:
                targets.add(m.group(1))

    return targets


def extract_bash_blocks(content: str) -> list[tuple[int, str, bool]]:
    """Extract bash code blocks from markdown content.

    Returns list of (start_line, block_content, is_bad_example).
    """
    blocks = []
    lines = content.splitlines()
    inside = False
    start_line = 0
    block_lines: list[str] = []
    is_bad = False

    for i, line in enumerate(lines):
        stripped = line.strip()
        if stripped == '```bash' and not inside:
            inside = True
            start_line = i + 1  # 1-based
            block_lines = []
            # Check preceding lines for BAD-example markers
            is_bad = False
            for j in range(max(0, i - 3), i):
                if BAD_EXAMPLE_MARKERS.search(lines[j]):
                    is_bad = True
                    break
        elif stripped == '```' and inside:
            inside = False
            blocks.append((start_line, '\n'.join(block_lines), is_bad))
        elif inside:
            block_lines.append(line)

    return blocks


def check_makefile_commands(
    project_root: Path, findings: list[dict],
) -> None:
    """Validate that bash blocks in rules/skills use make targets, not direct tool calls."""
    targets = parse_makefile_targets(project_root)
    if not targets:
        return  # No Makefile found, skip check

    # Gather all rule and skill files
    files_to_check: list[tuple[str, str]] = []  # (rel_path, content)

    rules_dir = project_root / '.cursor' / 'rules'
    if rules_dir.is_dir():
        for p in sorted(rules_dir.glob('*.mdc')):
            files_to_check.append((
                str(p.relative_to(project_root)),
                p.read_text(encoding='utf-8'),
            ))

    skills_dir = project_root / '.claude' / 'skills'
    if skills_dir.is_dir():
        for skill_dir in sorted(skills_dir.iterdir()):
            if not skill_dir.is_dir():
                continue
            skill_path = skill_dir / 'SKILL.md'
            if skill_path.is_file():
                files_to_check.append((
                    str(skill_path.relative_to(project_root)),
                    skill_path.read_text(encoding='utf-8'),
                ))

    for rel_path, content in files_to_check:
        for start_line, block, is_bad in extract_bash_blocks(content):
            if is_bad:
                continue

            # Join continued lines
            block = block.replace('\\\n', ' ')

            # Track BAD/GOOD sections within a block
            in_bad_section = False
            for line_offset, raw_line in enumerate(block.splitlines()):
                stripped_line = raw_line.strip()
                # Detect section markers inside block
                if stripped_line.startswith('#'):
                    if BAD_EXAMPLE_MARKERS.search(stripped_line):
                        in_bad_section = True
                        continue
                    if re.search(r'\bGOOD\b', stripped_line, re.IGNORECASE):
                        in_bad_section = False
                        continue

                if in_bad_section:
                    continue

                # Split on command separators
                for segment in re.split(r'&&|;|\|', raw_line):
                    cmd = segment.strip()
                    if not cmd:
                        continue
                    # Skip comments, skill-internal, python, variable assignments
                    if cmd.startswith('#'):
                        continue
                    if '${CLAUDE_SKILL_DIR}' in cmd:
                        continue
                    if cmd.startswith('python3') or cmd.startswith('python '):
                        continue
                    if re.match(r'^[A-Za-z_][A-Za-z0-9_]*=', cmd):
                        continue
                    # Skip echo/source/cd/sh/@ prefixed lines
                    if cmd.startswith(('@', 'echo ', 'source ', 'cd ', 'sh ', 'if ', 'fi',
                                       'for ', 'done', 'then', 'else', 'fi;')):
                        continue

                    line_num = start_line + line_offset

                    # Check for direct tool calls
                    first_word = cmd.split()[0] if cmd.split() else ''
                    if first_word in PROHIBITED_TOOLS:
                        findings.append({
                            'severity': 'WARNING',
                            'check': 'makefile_direct_tool_call',
                            'file': rel_path,
                            'line': line_num,
                            'message': f'Direct tool call "{first_word}" — use a make target instead',
                            'suggestion': 'Replace with the corresponding make target (run `make help` to see available targets)',
                        })

                    # Check for unknown make targets
                    if cmd.startswith('make '):
                        parts = cmd.split()
                        if len(parts) >= 2:
                            target = parts[1]
                            # Skip variable overrides like VAR=val passed as first arg
                            if '=' in target:
                                continue
                            # Skip template placeholders like gen-<brick>
                            if '<' in target and '>' in target:
                                continue
                            if target not in targets:
                                findings.append({
                                    'severity': 'WARNING',
                                    'check': 'makefile_unknown_target',
                                    'file': rel_path,
                                    'line': line_num,
                                    'message': f'Unknown make target: {target}',
                                    'suggestion': f'Check available targets with `make help`. Did you mean one of: {", ".join(sorted(targets))}?',
                                })


def check_ai_review_rules(
    project_root: Path, findings: list[dict],
) -> None:
    """Validate AI_CODE_REVIEW_RULES.md against current rule files."""
    review_file = project_root / AI_REVIEW_RULES_FILE
    if not review_file.is_file():
        findings.append({
            'severity': 'ERROR',
            'check': 'ai_review_rules_missing',
            'file': AI_REVIEW_RULES_FILE,
            'line': 0,
            'message': f'{AI_REVIEW_RULES_FILE} does not exist',
            'suggestion': 'Run /sync-review-rules to generate the file',
        })
        return

    content = review_file.read_text(encoding='utf-8')

    # Parse source comments from the document
    doc_sources: dict[str, str] = {}  # path -> sha256
    for match in AI_REVIEW_SOURCE_COMMENT.finditer(content):
        doc_sources[match.group('path')] = match.group('hash')

    # Compute current hashes and check for drift
    rules_dir = project_root / '.cursor' / 'rules'
    if not rules_dir.is_dir():
        return

    for rule_path in sorted(rules_dir.glob('*.mdc')):
        rel = str(rule_path.relative_to(project_root))
        rule_name = rule_path.name

        # Skip excluded rules
        if rule_name in AI_REVIEW_EXCLUDED_RULES:
            continue

        current_hash = hashlib.sha256(
            rule_path.read_bytes()
        ).hexdigest()

        if rel not in doc_sources:
            findings.append({
                'severity': 'WARNING',
                'check': 'ai_review_rules_missing_rule',
                'file': AI_REVIEW_RULES_FILE,
                'line': 0,
                'message': f'Rule {rel} is not represented in {AI_REVIEW_RULES_FILE}',
                'suggestion': 'Run /sync-review-rules to regenerate the file',
            })
        elif doc_sources[rel] != current_hash:
            findings.append({
                'severity': 'WARNING',
                'check': 'ai_review_rules_stale',
                'file': AI_REVIEW_RULES_FILE,
                'line': 0,
                'message': f'Rule {rel} has changed since {AI_REVIEW_RULES_FILE} was generated',
                'suggestion': 'Run /sync-review-rules to regenerate the file',
            })

    # Check for removed rules (referenced in doc but no longer on disk)
    for doc_path in doc_sources:
        full_path = project_root / doc_path
        if not full_path.exists():
            findings.append({
                'severity': 'WARNING',
                'check': 'ai_review_rules_removed_rule',
                'file': AI_REVIEW_RULES_FILE,
                'line': 0,
                'message': f'Rule {doc_path} is referenced in {AI_REVIEW_RULES_FILE} but no longer exists',
                'suggestion': 'Run /sync-review-rules to regenerate the file',
            })


def main() -> None:
    parser = argparse.ArgumentParser(description='Validate rules and skills files')
    parser.add_argument(
        '--project-root',
        type=Path,
        default=Path('.'),
        help='Project root directory (default: current directory)',
    )
    args = parser.parse_args()

    project_root = args.project_root.resolve()
    if not project_root.is_dir():
        print(json.dumps({
            'summary': {'rules_checked': 0, 'skills_checked': 0, 'errors': 1, 'warnings': 0},
            'findings': [{
                'severity': 'ERROR',
                'check': 'invalid_project_root',
                'file': str(args.project_root),
                'line': 0,
                'message': f'Project root does not exist: {project_root}',
                'suggestion': 'Provide a valid --project-root path',
            }],
        }))
        sys.exit(1)

    findings: list[dict] = []

    rule_files = check_rule_files(project_root, findings)
    skill_files = check_skill_files(project_root, findings)
    check_claude_md_index(project_root, findings)
    check_makefile_commands(project_root, findings)
    check_ai_review_rules(project_root, findings)

    errors = sum(1 for f in findings if f['severity'] == 'ERROR')
    warnings = sum(1 for f in findings if f['severity'] == 'WARNING')

    result = {
        'summary': {
            'rules_checked': len(rule_files),
            'skills_checked': len(skill_files),
            'errors': errors,
            'warnings': warnings,
        },
        'findings': findings,
    }

    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()

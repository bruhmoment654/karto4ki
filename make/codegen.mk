.PHONY: gen-all gen-l10n

gen-all: ## Generate code from all modules
	fvm dart run build_runner build --delete-conflicting-outputs

gen-l10n: ## Generate localization files
	fvm flutter gen-l10n

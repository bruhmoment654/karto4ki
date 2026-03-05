.PHONY: build-dev build-prod

build-dev: ## Build iOS debug
	@echo "iOS debug build started"
	fvm flutter build ios --debug --no-codesign

build-prod: ## Build iOS release
	@echo "iOS release build started"
	fvm flutter build ios --release --no-codesign

.PHONY: build-dev build-prod

build-dev: ## Build Android debug APK
	@echo "Android debug build started"
	fvm flutter build apk --debug --split-per-abi

build-prod: ## Build Android release APK
	@echo "Android release build started"
	fvm flutter build apk --release --split-per-abi

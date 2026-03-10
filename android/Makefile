.PHONY: build-dev build-prod build-qa deploy-firebase

build-dev: ## Build Android debug APK
	@echo "Android debug build started"
	fvm flutter build apk --debug --split-per-abi

build-prod: ## Build Android release APK
	@echo "Android release build started"
	fvm flutter build apk --release --split-per-abi

build-qa: ## Build Android release APK for QA
	@echo "Android QA build started"
	fvm flutter build apk --release

deploy-firebase: ## Deploy Android APK to Firebase App Distribution
	@echo "Android Firebase deploy started"
	cd fastlane && bundle exec fastlane firebase

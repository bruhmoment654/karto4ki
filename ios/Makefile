.PHONY: build-dev build-prod build-qa deploy-firebase

build-dev: ## Build iOS debug
	@echo "iOS debug build started"
	fvm flutter build ios --debug --no-codesign

build-prod: ## Build iOS release
	@echo "iOS release build started"
	fvm flutter build ios --release --no-codesign

build-qa: ## Build iOS IPA for QA
	@echo "iOS QA build started"
	fvm flutter build ipa --release --export-options-plist=ExportOptions.plist

deploy-firebase: ## Deploy iOS IPA to Firebase App Distribution
	@echo "iOS Firebase deploy started"
	cd fastlane && bundle exec fastlane firebase

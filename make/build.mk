# Commands for building and deploying the application.
#
# ATTENTION! EDIT CAREFULLY! COMMANDS ARE CALLED ON CI/CD!

SHELL := /bin/bash

.PHONY: build-android-no-sign, build-ios-no-sign

build-android-no-sign: ## Build Android APK without code signing
	@echo "🐄 Android no-sign build started"
	fvm flutter build apk -t lib/main_dev.dart --flavor dev --split-per-abi --release 

build-ios-no-sign: ## Build iOS without code signing
	@echo "🐄 iOS no-sign build started"
	fvm flutter build ios -t lib/main_dev.dart --flavor dev --release --no-codesign

build:
	@echo "🐄 Build started"
	fvm flutter build apk --split-per-abi --release 
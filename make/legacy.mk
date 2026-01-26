include .env

.PHONY: help init pod-install clean-ios init-flutter-version codegen l10n reset-goldens spider-build format build-qa-android build-qa-ios bump-major bump-minor bump-patch set-version


pod-install:
	cd ios && rm -rf .symlinks/ && rm -rf Pods && rm -rf Podfile.lock && rm -rf Flutter/Flutter.podspec
	cd ios && pod deintegrate && sudo gem uninstall cocoapods && sudo gem uninstall cocoapods-core && sudo gem uninstall cocoapods-downloader
	cd ios && brew reinstall cocoapods && pod setup && flutter precache --ios && pod install --repo-update && pod cache clean --all && pod update
	fvm flutter clean && fvm flutter pub get

clean-ios:
	fvm flutter clean
	cd ios/ && pod cache clean --all && xcodebuild clean && rm -rf .symlinks/ && rm -rf Pods && rm -rf Podfile.lock

init-flutter-version:
	fvm install $(FLUTTER_VERSION) && fvm use $(FLUTTER_VERSION)
	fvm flutter doctor
	fvm flutter clean
	fvm flutter pub get

codegen:
	fvm flutter pub get && fvm flutter pub run build_runner build --delete-conflicting-outputs && make format

l10n:
	fvm flutter gen-l10n

reset-goldens:
	(cd test && find . -type d -name goldens -prune -exec rm -rf {} \;)
	fvm flutter test --update-goldens

spider-build:
	fvm dart run spider build && make format

# Быстрый бамп версии для локальной сборки.
bump-version: 
	sh ./scripts/bump.sh minor

bump-major:
	sh ./scripts/bump.sh major

bump-minor:
	sh ./scripts/bump.sh minor

bump-patch:
	sh ./scripts/bump.sh patch

# Вызываем так: make set-version v=2.1.3
set-version:
	sh ./scripts/version.sh $(v)

ez-qa-deploy:
	@echo "Обновление версии"
	$(MAKE) bump-version

	@echo "Билд Android"
	cd android && $(MAKE) build-qa

	@echo "Деплой Android"
	cd android && $(MAKE) deploy-firebase

	@echo "Билд iOS"
	cd ios && $(MAKE) build-qa

	@echo "Деплой iOS"
	cd ios && $(MAKE) deploy-firebase

firebase-init-dev:
	sh ./scripts/firebase.sh dev

firebase-init-prod:
	sh ./scripts/firebase.sh prod

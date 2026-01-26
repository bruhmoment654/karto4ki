# Commands for working with the project.
#
# ATTENTION! EDIT CAREFULLY! COMMANDS ARE CALLED ON CI/CD!

.PHONY: init, get, clean, format, format-soft, analyze

init: ## Initialize project with FVM, dependencies and code generation  
	fvm use --force
	yes | fvm flutter doctor --android-licenses || true
	make get
	make format-soft

get: ## Get Flutter dependencies
	fvm flutter pub get

clean: ## Clean project
	fvm flutter clean

format: ## Format code and exit with error if changes needed
	fvm dart format -l 80 --set-exit-if-changed lib test

format-soft: ## Format code without exit codes
	fvm dart format -l 80 lib test

analyze: ## Analyze code with DCM and Dart analyzer. 
	make analyze-dart && make analyze-dcm

analyze-dart: ## Analyze code with Dart analyzer
	fvm dart analyze lib test

analyze-dcm: ## Analyze code with DCM. Usage: make analyze-dcm [DCM_CI_KEY=key] [DCM_EMAIL=email]
	dcm analyze $(if $(DCM_CI_KEY),--ci-key=$(DCM_CI_KEY)) $(if $(DCM_EMAIL),--email=$(DCM_EMAIL)) lib test

run-tests: ## Run tests
	fvm flutter test

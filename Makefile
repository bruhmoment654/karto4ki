.PHONY: help

help: ## Show help for all commands
	@echo "Available commands:"; \
	echo ""; \
	echo "Main:"; \
	grep -h -E '^[a-zA-Z0-9_.-]+:.*?## ' Makefile | \
	sort | \
	awk 'BEGIN {FS=":.*?## "}; {printf "  \033[36m%-25s\033[0m %s\n", $$1, $$2}'; \
	echo ""; \
	for file in $(MAKEFILES); do \
		name=$$(basename $$file .mk | awk '{print toupper(substr($$0, 1, 1)) substr($$0, 2)}'); \
		echo "$$name:"; \
		grep -h -E '^[a-zA-Z0-9_.-]+:.*?## ' $$file | \
		sort | \
		awk 'BEGIN {FS=":.*?## "}; {printf "  \033[36m%-25s\033[0m %s\n", $$1, $$2}'; \
		echo ""; \
	done

MAKEFILES := $(wildcard make/*.mk)
include $(MAKEFILES)

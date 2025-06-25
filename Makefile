# Makefile for managing sculptor Homebrew formula

# GitHub repository details
OWNER := sequring
REPO := sculptor
FORMULA := Formula/sculptor.rb
UPDATE_SCRIPT := update_sculptor_formula.rb

# Get the latest release version from GitHub API
LATEST_VERSION := $(shell curl -s https://api.github.com/repos/$(OWNER)/$(REPO)/releases/latest | jq -r '.tag_name | sub("^v"; "")')

# URLs for checksums
CHECKSUMS_URL := https://github.com/$(OWNER)/$(REPO)/releases/download/v$(LATEST_VERSION)/checksums.txt

# Platform and architecture combinations
PLATFORMS := darwin linux
ARCHS := amd64 arm64

.PHONY: sculptor update-formula clean help

# Default target - update the sculptor formula
sculptor: update-formula
	@echo "Sculptor formula update completed successfully"

# Download the checksums file
download-checksums:
	@echo "Downloading checksums for v$(LATEST_VERSION)..."
	@curl -sL -o checksums.txt $(CHECKSUMS_URL) || (echo "Failed to download checksums"; exit 1)

# Extract checksum for a specific platform and architecture
get-checksum:
	@if [ -f checksums.txt ]; then \
		grep "_$(PLATFORM)_$(ARCH).tar.gz$$" checksums.txt | awk '{print $$1}'; \
	else \
		curl -sL $(CHECKSUMS_URL) | grep "_$(PLATFORM)_$(ARCH).tar.gz$$" | awk '{print $$1}'; \
	fi

# Update the Homebrew formula using Ruby script
update-formula: download-checksums
	@if [ ! -f "$(UPDATE_SCRIPT)" ]; then \
		echo "Error: $(UPDATE_SCRIPT) not found"; \
		exit 1; \
	fi
	@if ! command -v ruby >/dev/null 2>&1; then \
		echo "Error: Ruby is required but not installed"; \
		exit 1; \
	fi
	@echo "Updating $(FORMULA) to the latest version..."
	@ruby $(UPDATE_SCRIPT) $(LATEST_VERSION)

# Clean up generated files
clean:
	@rm -f checksums.txt $(FORMULA).bak

# Show help
help:
	@echo "Available targets:"
	@echo "  update-formula - Update the Homebrew formula with latest version and checksums"
	@echo "  download-checksums - Download the checksums file from the latest release"
	@echo "  clean - Remove downloaded files and backups"
	@echo "  help - Show this help message"

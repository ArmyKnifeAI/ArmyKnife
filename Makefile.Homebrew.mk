# Define the default target when you run `make` without arguments
.DEFAULT_GOAL := help

# Define the path to the local projects directory
LOCALPROJECT := ~/localprojects/python_test_project
ARMYKNIFE := ~/localprojects/ArmyKnife

# Define the packages to be installed via Homebrew
COMMON_PACKAGES := wget curl jq
KUBERNETES_TOOLS := kubectl kustomize helm
GITHUB_TOOLS := gh git-lfs git-secrets git-crypt git-extras git-flow git-gui
DOTFILE_MANAGER := stow
CLOUD_TOOLS := azure-cli awscli
DEVOPS_TOOLS := devbox

.PHONY: setup-homebrew-tools setup-homebrew install-common-packages install-kubernetes-tools install-github-cli setup-dotfile-manager install-cloud-tools install-essential-dev-tools install-packages

# Full setup chain with proper environment handling
setup-homebrew-tools: setup-homebrew setup-homebrew-shell 

setup-homebrew:
	@if ! which brew >/dev/null 2>&1; then \
		echo "Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	fi
	@echo 'eval "$$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
	@/bin/bash -c "source ~/.bashrc; $(MAKE) update-shell-config"

setup-homebrew-shell:
	@/bin/bash -c "source ~/.bashrc; $(MAKE) continue-install"

continue-install: install-common-packages install-kubernetes-tools install-github-cli setup-dotfile-manager install-cloud-tools install-essential-dev-tools source-bashrc developer-support-tools


install-common-packages:
	@echo "Installing common packages..."
	@brew install $(COMMON_PACKAGES) || echo "Failed to install common packages."

install-kubernetes-tools:
	@echo "Installing Kubernetes tools..."
	@brew install $(KUBERNETES_TOOLS) || echo "Failed to install Kubernetes tools."

install-github-cli:
	@echo "Installing GitHub tools..."
	@brew install $(GITHUB_TOOLS) || echo "Failed to install GitHub tools."

setup-dotfile-manager:
	@echo "Setting up dotfile manager..."
	@brew install $(DOTFILE_MANAGER) || echo "Failed to install dotfile manager."

install-cloud-tools:
	@echo "Installing cloud tools..."
	@brew install $(CLOUD_TOOLS) || echo "Failed to install cloud tools."

install-essential-dev-tools:
	@echo "Checking and installing essential development tools..."
	@which cargo >/dev/null 2>&1 || (echo "Cargo not found. Installing..." && brew install rust && echo "Rust installed.") || echo "Failed to install Rust."; \
	@which go >/dev/null 2>&1 || (echo "Go not found. Installing..." && brew install golang && echo "Go installed.") || echo "Failed to install Go."; \
	/bin/bash -c "source ~/.bashrc"; \



# Define the target to update .bashrc and .zshrc files with tool-specific settings
update-shell-config:
	@echo "Updating shell configuration..."
	@if [ "$(shell uname)" = "Darwin" ]; then \
		echo 'export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"' >> ~/.bashrc; \
		echo 'export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"' >> ~/.zshrc; \
		echo 'eval "$$(/usr/local/bin/brew shellenv)"' >> ~/.bashrc; \
		echo 'eval "$$(/usr/local/bin/brew shellenv)"' >> ~/.zshrc; \
	fi
	@if [ -f "/home/$(USER)/.bashrc" ]; then \
		sudo echo 'eval "$$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc; \
	fi
	@if [ -f "/home/$(USER)/.zshrc" ]; then \
		sudo echo 'eval "$$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zshrc; \
	fi
	@if [ ! -d "/home/linuxbrew/.linuxbrew/bin/go" ] && [ ! -d "/home/linuxbrew/.linuxbrew/bin/cargo" ]; then \
		echo 'export GOPATH=$$HOME/go' >> ~/.bashrc; \
		echo 'export GOPATH=$$HOME/go' >> ~/.zshrc; \
		echo 'export GOBIN=$$GOPATH/bin' >> ~/.bashrc; \
		echo 'export GOBIN=$$GOPATH/bin' >> ~/.zshrc; \
		echo 'export GOROOT="$$(brew --prefix golang)/libexec"' >> ~/.bashrc; \
		echo 'export GOROOT="$$(brew --prefix golang)/libexec"' >> ~/.zshrc; \
		echo 'export PATH=$$PATH:$$GOPATH/bin' >> ~/.bashrc; \
		echo 'export PATH=$$PATH:$$GOPATH/bin' >> ~/.zshrc; \
		echo 'export PATH=$$PATH:$$GOROOT/bin' >> ~/.bashrc; \
		echo 'export PATH=$$PATH:$$GOROOT/bin' >> ~/.zshrc; \
		echo 'export PATH="$$HOME/.cargo/bin:$$PATH"' >> ~/.bashrc; \
		echo 'export PATH="$$HOME/.cargo/bin:$$PATH"' >> ~/.zshrc; \
	fi

source-bashrc:
	@/bin/bash -c "source ~/.bashrc"; \
	

developer-support-tools:
	/home/linuxbrew/.linuxbrew/bin/cargo install ytop; \
	/home/linuxbrew/.linuxbrew/bin/cargo install exa; \
	/home/linuxbrew/.linuxbrew/bin/cargo install bat; \
	/home/linuxbrew/.linuxbrew/bin/cargo install ripgrep; \
	/home/linuxbrew/.linuxbrew/bin/cargo install fd-find; \
	/home/linuxbrew/.linuxbrew/bin/cargo install tokei; \
	/home/linuxbrew/.linuxbrew/bin/cargo install procs; \
	/home/linuxbrew/.linuxbrew/bin/cargo install git-delta; \
	/home/linuxbrew/.linuxbrew/bin/cargo install git-absorb; \
	/home/linuxbrew/.linuxbrew/bin/cargo install git-interactive-rebase-tool; \
	/home/linuxbrew/.linuxbrew/bin/cargo install git-branchless; \
	/home/linuxbrew/.linuxbrew/bin/cargo install git-quick-stats; \
	/home/linuxbrew/.linuxbrew/bin/cargo install git-standup; \
	/home/linuxbrew/.linuxbrew/bin/cargo install git-journal; \
	/home/linuxbrew/.linuxbrew/bin/cargo install git-undo; \
	/home/linuxbrew/.linuxbrew/bin/cargo install git-quick-stats; \
	/home/linuxbrew/.linuxbrew/bin/cargo install cargo-edit ; \
	figlet "Rust Developer Tools Installed"; \

	

	

	
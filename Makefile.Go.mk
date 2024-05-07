# Define the target to install support tools for Go
install-go-support-tools:
	go install github.com/goreleaser/goreleaser@latest
	echo "Installing Go support tools..."



# Define the target to update .bashrc and .zshrc files with tool-specific settings
# update-shell-config:
# 	@echo "Updating shell configuration..."
# 	@if [ "$(shell uname)" = "Darwin" ]; then \
# 		echo 'export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"' >> ~/.bashrc; \
# 		echo 'export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"' >> ~/.zshrc; \
# 		echo 'eval "$$(/usr/local/bin/brew shellenv)"' >> ~/.bashrc; \
# 		echo 'eval "$$(/usr/local/bin/brew shellenv)"' >> ~/.zshrc; \
# 	fi
# 	@if [ -f "/home/$(USER)/.bashrc" ]; then \
# 		sudo echo 'eval "$$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc; \
# 	fi
# 	@if [ -f "/home/$(USER)/.zshrc" ]; then \
# 		sudo echo 'eval "$$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zshrc; \
# 	fi
# 	@if [ ! -d "/usr/local/opt/go/bin" ]; then \
# 		echo 'export PATH="/usr/local/opt/go/bin:$${PATH}"' >> ~/.bashrc; \
# 		echo 'export PATH="/usr/local/opt/go/bin:$${PATH}"' >> ~/.zshrc; \
# 	fi
# 	@if [ ! -d "/usr/local/opt/rust/bin" ]; then \
# 		echo 'export PATH="/usr/local/opt/rust/bin:$${PATH}"' >> ~/.bashrc; \
# 		echo 'export PATH="/usr/local/opt/rust/bin:$${PATH}"' >> ~/.zshrc; \
# 	fi
# 	# Additions for GOPATH, GOBIN, and GOROOT
# 	@if [ ! -d "/usr/local/opt/go/bin" ]; then \
# 		echo 'export GOPATH=$$HOME/go' >> ~/.bashrc; \
# 		echo 'export GOPATH=$$HOME/go' >> ~/.zshrc; \
# 		echo 'export GOBIN=$$GOPATH/bin' >> ~/.bashrc; \
# 		echo 'export GOBIN=$$GOPATH/bin' >> ~/.zshrc; \
# 		echo 'export GOROOT="$$(brew --prefix golang)/libexec"' >> ~/.bashrc; \
# 		echo 'export GOROOT="$$(brew --prefix golang)/libexec"' >> ~/.zshrc; \
# 		echo 'export PATH=$$PATH:$$GOPATH/bin' >> ~/.bashrc; \
# 		echo 'export PATH=$$PATH:$$GOPATH/bin' >> ~/.zshrc; \
# 		echo 'export PATH=$$PATH:$$GOROOT/bin' >> ~/.bashrc; \
# 		echo 'export PATH=$$PATH:$$GOROOT/bin' >> ~/.zshrc; \
# 		echo 'export PATH=$$PATH:/usr/local/opt/go/bin' >> ~/.bashrc; \
# 		echo 'export PATH=$$PATH:/usr/local/opt/go/bin' >> ~/.zshrc; \
# 	fi
# 	@echo 'source ~/.bashrc' >> ~/.zshrc
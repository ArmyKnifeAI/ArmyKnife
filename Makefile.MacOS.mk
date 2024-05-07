.PHONY: setup-macos


setup-macos: setup-macos-homebrew

# Define the target to install Oh My Zsh
install-oh-my-zsh:
	if [ "`uname`" = "Darwin" ]; then \
        if [ ! -d "/Users/$(USER)/.oh-my-zsh" ]; then \
            sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; \
        fi \
    else \
        if [ ! -d "/home/$(USER)/.oh-my-bash" ]; then \
            bash -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"; \
        fi \
    fi
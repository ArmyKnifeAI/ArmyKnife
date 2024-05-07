.PHONY: create-ssh-keys install-oh-my install-amix-vimrc install-conda anaconda_download anaconda_install

setup-common-tools: install-oh-my create-ssh-keys install-amix-vimrc anaconda-install

# Make sure you update the keys in vagrant and virtualbox cloud-init files
create-ssh-keys:
	mkdir -p keys
	ssh-keygen -t rsa -b 4096 -f keys/armyknife -C "$$(cat .env | grep EMAIL_ADDRESS | cut -d '=' -f2)"
	echo "Look in ArmyKnife/keys"
	figlet "SSH Keys Created"


# Define the target to install Oh My Zsh
install-oh-my:
	if [ "`uname`" = "Darwin" ]; then \
        if [ ! -d "/Users/$(USER)/.oh-my-zsh" ]; then \
            sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; \
        fi \
    else \
        if [ ! -d "/home/$(USER)/.oh-my-bash" ]; then \
            bash -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"; \
        fi \
    fi

# Define the target to install amix/vimrc configuration for Vim
install-amix-vimrc:
	if [ -d "/home/$$USER/.vim_runtime" ]; then \
		echo "amix/vimrc already installed. Skipping..."; \
	else \
		echo "Installing amix/vimrc..."; \
		git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime; \
		sh ~/.vim_runtime/install_awesome_vimrc.sh; \
	fi
	figlet "Awesome VIM Setup"

OS := $(shell uname)

anaconda-download:
	@echo "Detecting OS and downloading the appropriate Anaconda installer..."
	@OS=$$(uname); \
	if [ "$$OS" = "Linux" ]; then \
		echo "Fetching the latest Anaconda version for Linux..."; \
		wget -O - https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh -O anaconda.sh; \
	elif [ "$$OS" = "Darwin" ]; then \
		echo "Fetching the latest Anaconda version for macOS..."; \
		VERSION=$$(curl -s https://repo.anaconda.com/archive/ | grep -oP 'Anaconda3-\K\d{4}-\d{2}-\d{2}-MacOSX-x86_64.sh' | sort -r | head -n 1); \
		echo "Found version: $$VERSION"; \
		if [ -z "$$VERSION" ]; then \
			echo "Failed to find a valid version, please check the regex and the URL"; \
			exit 1; \
		fi; \
		wget https://repo.anaconda.com/archive/Anaconda3-$$VERSION -O anaconda.sh; \
	else \
		echo "Unsupported OS: $$OS"; \
		exit 1; \
	fi

anaconda-install: anaconda_download
	bash anaconda.sh -b -p $(HOME)/anaconda3
	echo 'export PATH="~/anaconda3/bin:$PATH"' >> ~/.bashrc
	@/bin/bash -c "source ~/.bashrc; $(MAKE) conda-setup"


conda-setup:
	conda update -n base -c defaults conda; \
	conda init bash; \




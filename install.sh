#!/bin/bash

# Function to check and install missing packages
install_package() {
    local package=$1
    local install_command=$2

    if ! command -v $package &>/dev/null; then
        echo "$package is not installed. Installing..."
        eval $install_command
        if [[ $? -ne 0 ]]; then
            echo "Failed to install $package. Please install it manually."
            exit 1
        fi
    fi
}

# OS-specific installation commands
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    install_package make "sudo apt-get install -y make || sudo yum install -y make"
    install_package git "sudo apt-get install -y git || sudo yum install -y git"
    install_package wget "sudo apt-get install -y wget || sudo yum install -y wget"
    install_package curl "sudo apt-get install -y curl || sudo yum install -y curl"
    install_package jq "sudo apt-get install -y jq || sudo yum install -y jq"
    # Check for Python 3.12 and install if not available
    if ! python3.12 --version &>/dev/null; then
        echo "Python 3.12 is not installed. Installing..."
        sudo apt-get install -y python3.12-venv || sudo yum install -y python3.12-venv
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    install_package make "brew install make"
    install_package git "brew install git"
    install_package wget "brew install wget"
    install_package curl "brew install curl"
    install_package jq "brew install jq"
    # Check for Python 3.12 and install if not available
    if ! python3.12 --version &>/dev/null; then
        echo "Python 3.12 is not installed. Installing..."
        brew install python@3.12
        # Setting up the python3.12 symlink if not set
        ln -s /usr/local/bin/python3.12 /usr/local/bin/python3.12
    fi
else
    echo "Unsupported OS. Please install the packages manually."
    exit 1
fi


# Copy over .bashrc or .zshrc if it doesn't exist depending on if MacOS or Linux.
# if [ "`uname`" = "Darwin" ]; then \
#     cp support/.zshrc ~/.zshrc; \
# else \
#     cp support/.bashrc ~/.bashrc; \
# fi



# Copy env_sample.txt to .env if it doesn't exist
if [ ! -f .env ]; then
    if [ -f env_sample.txt ]; then
        cp env_sample.txt .env
        echo ".env file created from env_sample.txt. Now is a good time to fill out username and email for Git Settings"
    else
        echo "env_sample.txt does not exist. Please ensure env_sample.txt is in the current directory."
        exit 1
    fi
else
    echo ".env file already exists. Now is a good time to fill out username and email for Git Settings"
fi

# Function to run a Make target
run_make_target() {
    target=$1
    echo "Running make target: $target . You may be prompted for your password. You may need to run it multiple times until you see a Success message."
    make $target
    if [ $? -ne 0 ]; then
        echo "Failed to execute make target: $target"
        exit 1
    fi
}

# Run necessary Make targets

run_make_target setup-noble
run_make_target setup-ubuntu-repos
run_make_target setup-common-tools
run_make_target setup-homebrew-tools


echo "Setup completed successfully."


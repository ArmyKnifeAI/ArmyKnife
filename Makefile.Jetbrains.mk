# Makefile.Jetbrains.mk
# Makefile to download and install JetBrains IDEs

# Define the installation directory
INSTALL_DIR := $(HOME)/JetBrains

# Tool versions
INTELLIJ_VERSION := 2021.3
PYCHARM_VERSION := 2021.3

# Download URLs
INTELLIJ_URL := https://download.jetbrains.com/idea/ideaIC-$(INTELLIJ_VERSION).tar.gz
PYCHARM_URL := https://download.jetbrains.com/python/pycharm-professional-$(PYCHARM_VERSION).tar.gz

.PHONY: setup-jetbrains-toolbox install_intellij install_pycharm

setup-jetbrains-toolbox:
	@echo "Downloading JetBrains Toolbox..."
	@curl -L "https://data.services.jetbrains.com/products/download?code=TBA&platform=linux" -o /tmp/jetbrains-toolbox.tar.gz
	@echo "Extracting Toolbox..."
	@mkdir -p /home/$$USER/jetbrains-toolbox
	@tar -xzf /tmp/jetbrains-toolbox.tar.gz -C /home/$$USER/jetbrains-toolbox/
	@echo "Installing Toolbox..."
	@sh -c '/home/$$USER/jetbrains-toolbox/jetbrains-toolbox-*/jetbrains-toolbox'
	@echo "Installation complete. You can now use JetBrains Toolbox to install and manage JetBrains applications."
	@figlet -f slant "JetBrains Toolbox Installed"


$(INSTALL_DIR):
	mkdir -p $@

# IntelliJ IDEA Community Edition
install_intellij: | $(INSTALL_DIR)
	wget -O - $(INTELLIJ_URL) | tar xz -C $(INSTALL_DIR)

# PyCharm Professional Edition
install_pycharm: | $(INSTALL_DIR)
	wget -O - $(PYCHARM_URL) | tar xz -C $(INSTALL_DIR)




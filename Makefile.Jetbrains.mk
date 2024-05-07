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

.PHONY: all install_intellij install_pycharm

all: install_intellij install_pycharm

$(INSTALL_DIR):
	mkdir -p $@

# IntelliJ IDEA Community Edition
install_intellij: | $(INSTALL_DIR)
	wget -O - $(INTELLIJ_URL) | tar xz -C $(INSTALL_DIR)

# PyCharm Professional Edition
install_pycharm: | $(INSTALL_DIR)
	wget -O - $(PYCHARM_URL) | tar xz -C $(INSTALL_DIR)

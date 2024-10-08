.PHONY: setup-jammy setup-jammy-packages

DIDYOUKNOW = 'DevOps Tip: Infrastructure as Code tools like Terraform let you manage servers with plain text!' \
    'Did you know? Git\'s distributed nature makes collaboration a breeze.' \
    'Htop: Because sometimes you need to see what\'s REALLY going on with your system.'

PACKAGES = make wget curl jq qemu-system-x86 qemu-utils cloud-guest-utils cloud-init cloud-utils build-essential libvirt-daemon-system libvirt-clients libvirt-daemon bridge-utils virt-manager libguestfs-tools libosinfo-bin libguestfs-tools virt-top virtinst libvirt-doc libz-dev gnome-terminal python3.11-venv vim vim-gtk3 figlet unzip fail2ban clamav libpng-dev libjpeg-dev default-jdk

setup-jammy:
ifeq ($(shell uname),Darwin)
	@echo "Running MacOS setup"
	@$(MAKE) -f Makefile.MacOS.mk setup-macos
else
	@echo "Running Ubuntu Noble setup"
	@$(MAKE) -f Makefile.Jammy.mk setup-jammy-packages
endif

setup-jammy-packages:
	sudo apt remove -y minidlna
	sudo apt autoremove -y
	sudo apt install python3.11-venv
	python3.11 -m venv env  
	/bin/bash -c "source env/bin/activate; python3 -m pip install tqdm requests; python3 install_script.py '$(PACKAGES)' '$(DIDYOUKNOW)'"
	@figlet "Install Complete"

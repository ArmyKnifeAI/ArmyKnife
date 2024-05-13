.PHONY: setup-bookworm setup-bookworm-packages

DIDYOUKNOW = 'DevOps Tip: Infrastructure as Code tools like Terraform let you manage servers with plain text!' \
    'Did you know? Git\'s distributed nature makes collaboration a breeze.' \
    'Htop: Because sometimes you need to see what\'s REALLY going on with your system.'

PACKAGES = make wget curl cgroupfs-mount qemu-system-x86 qemu-utils cloud-guest-utils cloud-init virtualbox cloud-utils build-essential virtualbox libvirt-daemon-system libvirt-clients libvirt-daemon bridge-utils virt-manager libguestfs-tools libosinfo-bin libguestfs-tools virt-top virtinst libvirt-doc libz-dev gnome-terminal python3.11-venv vim vim-gtk3 figlet unzip fail2ban clamav libpng-dev libjpeg-dev default-jdk libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2t64 libxi6 libxtst6

setup-bookworm:
ifeq ($(shell uname),Darwin)
	@echo "Running MacOS setup"
	@$(MAKE) -f Makefile.MacOS.mk setup-macos
else
	@echo "Running Ubuntu Noble setup"
	@$(MAKE) -f Makefile.Bookworm.mk setup-bookworm-packages
endif

setup-bookworm-packages:
	sudo apt remove -y minidlna
	sudo apt autoremove -y
	python3 -m venv .venv  
	/bin/bash -c "source .venv/bin/activate; python3 -m pip install tqdm requests; python3 install_script.py '$(PACKAGES)' '$(DIDYOUKNOW)'"
	@figlet "Install Complete"

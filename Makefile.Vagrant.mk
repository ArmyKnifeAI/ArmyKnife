# Variables
VAGRANT := vagrant
VAGRANT_FILE := tools/vagrant/Vagrantfile
BOXES := $(wildcard $(VAGRANT_FILE).*)
LOCATION := tools/vagrant
K8S_LOCATION := tools/kubespray
BOX := jammy

# Phony Targets
.PHONY: all help up-vagrant destroy-vagrant ssh-vagrant status-vagrant

# Default Target
all: up-vagrant ssh-vagrant status-vagrant

# Target to launch Vagrant boxes
up-vagrant:
ifdef BOX
	cd $(LOCATION) && $(VAGRANT) plugin install vagrant-vbguest && $(VAGRANT) plugin install vagrant-hostmanager
	cd $(LOCATION) && $(VAGRANT) up --provider=virtualbox $(BOX)
else
	cd $(LOCATION) && $(foreach box,$(BOXES),$(VAGRANT) up --provider=virtualbox -f $(box);)
endif

# Target to destroy Vagrant boxes
destroy-vagrant:
ifdef BOX
	cd $(LOCATION) && $(VAGRANT) destroy -f $(BOX)
else
	cd $(LOCATION) && $(foreach box,$(BOXES),$(VAGRANT) global-status;)
endif

# Target to SSH into a specific Vagrant box
ssh-vagrant:
ifdef BOX
	cd $(LOCATION) && $(VAGRANT) ssh $(BOX)
else
	@echo "Please specify the box name to SSH into. Example: make ssh BOX=mybox"
endif

# Target to show status of Vagrant boxes
status-vagrant:
	cd $(LOCATION) && $(VAGRANT) status
	
################################################################################################################
# Setup Vagrant Boxes
################################################################################################################
# Vagrant Commands Need to add the rest of the vagrant commands.
vagrant-up:
	@echo "Launching Vagrant boxes"
	@$(MAKE) -d -f Makefile.Vagrant.mk up-vagrant
	@echo "Vagrant boxes launched."

vagrant-ssh:	
	@echo "SSH into Vagrant box"
	@$(MAKE) -d -f Makefile.Vagrant.mk ssh-vagrant

vagrant-destroy-all:
	@echo "Destroying Vagrant boxes"
	@$(MAKE) -d -f Makefile.Vagrant.mk destroy-vagrant

ova-import:
	@echo "Importing OVA files"
	@$(MAKE) -d -f Makefile.VBox.mk import-ovas

k8s-smoke-test:
	@echo "Running smoke test..."
	@$(MAKE) -f Makefile.K8s.mk kubespray-up
	@$(MAKE) -f Makefile.K8s-Admin.mk smoke-test
	@echo "Smoke test completed."

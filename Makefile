# Parent Makefile for ArmyKnife DevOps CI/CD Framework Development Environment



include Makefile.Libs.mk 
include Makefile.Vault.mk 
include Makefile.Git.mk 
include Makefile.K8s.mk 
include Makefile.VBox.mk 
include Makefile.Vagrant.mk 
include Makefile.Geodesic.mk 
include Makefile.Docker.mk 
include Makefile.Python.mk 
include Makefile.Ansible.mk 
include Makefile.Terraform.mk 
include Makefile.Packer.mk 
include Makefile.CICD.mk 
include Makefile.Common.mk 
include Makefile.K8s-Admin.mk 
include Makefile.ELK.mk 
include Makefile.Security.mk 
include Makefile.BashLib.mk 
include Makefile.Registry.mk 
include Makefile.Postgres.mk 
include Makefile.Terraform2.mk 
include Makefile.Jammy.mk
include Makefile.Noble.mk
include Makefile.Homebrew.mk
include Makefile.Go.mk
include Makefile.Rust.mk
include Makefile.MacOS.mk
include Makefile.Ubuntu.mk
include Makefile.Jetbrains.mk



################################################################################################################
# Show the user a menu of options to run make commands
################################################################################################################

# Help target needs updated last when finsihed with project development
.PHONY: help
help:
	@echo ":::'###::::'########::'##::::'##:'##:::'##:'##:::'##:'##::: ##:'####:'########:'########:"
	@echo "::'## ##::: ##.... ##: ###::'###:. ##:'##:: ##::'##:: ###:: ##:. ##:: ##.....:: ##.....::"
	@echo ":'##:. ##:: ##:::: ##: ####'####::. ####::: ##:'##::: ####: ##:: ##:: ##::::::: ##:::::::"
	@echo "'##:::. ##: ########:: ## ### ##:::. ##:::: #####:::: ## ## ##:: ##:: ######::: ######:::"
	@echo "'#########: ##.. ##::: ##. #: ##:::: ##:::: ##. ##::: ##. ####:: ##:: ##...:::: ##...::::"
	@echo "'##.... ##: ##::. ##:: ##:.:: ##:::: ##:::: ##:. ##:: ##:. ###:: ##:: ##::::::: ##:::::::"
	@echo "'##:::: ##: ##:::. ##: ##:::: ##:::: ##:::: ##::. ##: ##::. ##:'####: ##::::::: ########:"
	@echo "..:::::..::..:::::..::..:::::..:::::..:::::..::::..::..::::..::....::..::::::::........::"
	@echo "                  Armyknife Help Menu                  "
	@echo "--------------------------------------------------------"
	@echo "setup-vbox-ansible      - Create a custom virtualbox VM (Linux Only)"
	@echo "setup-kubespray         - Install Kubernetes Cluster complete with Masters/Etcd and Workers"
	@echo "install-minikube        - Setup Kubernetes Test Environment"
	@echo "connect-to-geodesic     - Connect to Geodesic ToolBox Shell"
	@echo "setup-geodesic          - Build Geodesic Docker Image with Kali plugin"
	@echo "setup-git               - Setup Git Configuration"
	@echo "setup-vagrant-ansible   - Launch Vagrant Box Jammy (Ansible)"
	@echo "setup-jammy             - Install OS Packages and Tools for Jammy Ubuntu OS"
	@echo "setup-noble             - Install OS Packages and Tools for Noble Ubuntu OS"
	@echo "setup-macos             - Install OS Packages and Tools for MacOS"
	@echo "setup-vault             - Create Vault Server for Development"
	@echo "setup-ubuntu-repos      - Setup APT Repositories"
	@echo "setup-common-tools      - Setup Common Tools"
	@echo "setup-homebrew-tools    - Setup Homebrew Tools"
	@echo "setup-registry          - Setup Docker Registry"
	@echo "setup-bashlibs          - Setup Bash libraries"
	@echo "setup-postgres          - Setup Postgres Database"
	@echo "setup-jetbrains-toolbox - Setup JetBrains Toolbox"
	@echo "--------------------------------------------------------"
	@echo "Use \"make <target>\" to run a specific command."




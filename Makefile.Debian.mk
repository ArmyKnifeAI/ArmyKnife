.PHONY: install-gcloud-cli install-docker-ubuntu install-vagrant setup-debian-repos 

setup-debian-repos: install-gcloud-cli install-docker-ubuntu install-vagrant setup-vscode  

install-vagrant:
	@which vagrant || (sudo apt update && sudo apt install -y gpg wget apt-transport-https; \
	sudo wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg; \
	sudo gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint | grep -q "798A EC65 4E5C 1542 8C8E 42EE AA16 FCBC A621 E701"; \
	echo "deb [arch=$$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com jammy main" | sudo tee /etc/apt/sources.list.d/hashicorp.list; \
	sudo apt update && sudo apt install -y vagrant vault terraform)
	@figlet "Hashicorp Tools Installed"

# Define the target to install Docker on Ubuntu
install-docker-ubuntu:
	# If docker is not installed then install it
	@if ! command -v docker &>/dev/null; then \
		echo "Adding Docker's official GPG key..."; \
		sudo apt-get update && \
		sudo apt-get install -y ca-certificates curl gnupg; \
		sudo install -m 0755 -d /etc/apt/keyrings && \
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg; \
		sudo chmod a+r /etc/apt/keyrings/docker.gpg; \
		echo "Adding the Docker repository to Apt sources..."; \
		echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" | sudo tee /etc/apt/sources.list.d/docker.list; \
		sudo apt-get update; \
		echo "Installing Docker..."; \
		sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose; \
		sudo usermod -aG docker $$USER; \
		echo "Please log out and back in to apply the necessary Docker group changes."; \
		figlet "Docker Installed" ; \
	else \
		echo "Docker is already installed."; \
		figlet "Docker Installed" ; \
	fi

# Example 
setup-vscode:
	@echo "Installing Visual Studio Code..."
	@wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	@sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
	@sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	@sudo apt install -y apt-transport-https
	@sudo apt update
	@sudo apt install -y code
	@echo "--------------------------------------------------------------------------------"
	@figlet "VSCode Installed"

install-gcloud-cli:
	@echo "Updating system and installing required packages..."
	@sudo apt-get update && sudo apt-get install --yes --no-install-recommends \
	  apt-transport-https \
	  ca-certificates \
	  gnupg \
	&& sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*
	@echo "Adding Google Cloud package source..."
	@echo 'deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main' | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
	@echo "Importing Google Cloud public key..."
	@curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
	@echo "Updating package sources and installing Google Cloud CLI..."
	@sudo apt-get update && sudo apt-get install --yes --no-install-recommends google-cloud-cli
	@echo "Google Cloud CLI installation completed."
	@figlet "GCloud SDK Installed"




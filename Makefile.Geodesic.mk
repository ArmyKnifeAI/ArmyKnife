# Variables
IMAGE_NAME := localhost:5000/frisbee
TAG := latest
DOCKERFILE_DIR := tools/geodesic
ORG_IMAGE_NAME := cloudposse/geodesic
ORGTAG := dev
DOCKERFILE_DIR := tools/geodesic

# Commands
#BUILD_CMD := docker build -t $(IMAGE_NAME):$(TAG) -f $(DOCKERFILE_DIR)/Dockerfile.debian .
BUILD_CMD := make all
#TAG_CMD := docker tag $(ORG_IMAGE_NAME):$(ORGTAG) $(IMAGE_NAME):$(TAG)
TAG_CMD := docker tag cloudposse/geodesic:dev localhost:5000/frisbee:latest
PUSH_CMD := docker push $(IMAGE_NAME):$(TAG)

# Default target
.PHONY: all connect-to-geodesic build-geodesic
all: build-geodesic connect-to-geodesic
	@echo "All targets completed."

# Build the Docker image
build-geodesic:
	@echo "Building Geodesic"
	cd $(DOCKERFILE_DIR) && make build && $(TAG_CMD) && $(PUSH_CMD)
	@echo "Geodesic build completed."


connect-to-geodesic:
ifeq ($(shell uname), Darwin)
	osascript -e 'tell application "Terminal" to activate' -e 'tell application "Terminal" to do script "~/localprojects/ArmyKnife/community/bash/frisbee.sh"'
else
	./community/bash/frisbee.sh
endif


################################################################################################################
# Geodesic is a toolbox for cloud automation and devops. It's a cloud shell with Terraform, Packer, Docker, kubectl and other tools installed.
################################################################################################################
# Yes we have some duplication here. We will fix this later. LOL

# Main target for building Geodesic
setup-geodesic:
	@echo "Building Geodesic"
	@$(MAKE) -d -f Makefile.Geodesic.mk build-geodesic
	@echo "Geodesic build completed."
	@figlet "Geodesic Setup Complete"
	@$(MAKE) -f Makefile.Geodesic.mk connect-to-geodesic


connect-to-my-geodesic:
ifeq ($(shell uname), Darwin)
	@echo "Connecting to Geodesic"
	@$(MAKE) -d -f Makefile.Geodesic.mk connect-to-geodesic
else
	@echo "Connecting to Geodesic"
	@$(MAKE) -d -f Makefile.Geodesic.mk connect-to-geodesic
endif

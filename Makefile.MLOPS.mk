# Variables
ENV_NAME := mlops
PROJECT_NAME := mlops
PYTHON_VERSION := 3.9
PRECOMMIT_CONFIG := .pre-commit-config.yaml
JUPYTER_NOTEBOOK := mlops.ipynb
KERNEL_NAME := $(PROJECT_NAME)
CONDA_BIN := $(shell which conda)
CONDA_BASE := $(shell $(CONDA_BIN) info --base)

.ONESHELL:

SHELL = /bin/bash
CONDA_ACTIVATE = source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate

# Create conda env from env.yml and compile and install exact pip packages
setup-conda-pip:
	conda env update --prune -f env.yml
	$(CONDA_ACTIVATE) $(ENV_NAME)
	pip-compile requirements/req.in
	pip-sync requirements/req.txt

# Create and activate conda environment
create_conda_env:
	@echo "Creating conda environment: $(ENV_NAME)"
	@conda create -n $(ENV_NAME) python=$(PYTHON_VERSION) -y 

# Install Poetry
install_poetry:
	@echo "Installing Poetry"
	curl -sSL https://install.python-poetry.org | python3 -

# Install dependencies with Poetry
install_dependencies:
	@echo "Installing dependencies with Poetry"
	. $(CONDA_BASE)/etc/profile.d/conda.sh && conda activate $(ENV_NAME) && poetry install

# Initialize new project with Poetry
init_poetry_project:
	@echo "Initializing new Poetry project: $(PROJECT_NAME)"
	. $(CONDA_BASE)/etc/profile.d/conda.sh && conda activate $(ENV_NAME) && poetry new $(PROJECT_NAME)
	cd $(PROJECT_NAME) && . $(CONDA_BASE)/etc/profile.d/conda.sh && conda activate $(ENV_NAME) && poetry add hydra-core jupyter
	cd $(PROJECT_NAME) && . $(CONDA_BASE)/etc/profile.d/conda.sh && conda activate $(ENV_NAME) && poetry add --dev pdoc3 pre-commit flake8 black

# Configure pre-commit
setup_precommit:
	@echo "Setting up pre-commit hooks"
	cd $(PROJECT_NAME) && . $(CONDA_BASE)/etc/profile.d/conda.sh && conda activate $(ENV_NAME) && poetry run pre-commit install
	cp $(PRECOMMIT_CONFIG) $(PROJECT_NAME)/

# Generate documentation with pdoc
generate_docs:
	@echo "Generating documentation with pdoc"
	cd $(PROJECT_NAME) && . $(CONDA_BASE)/etc/profile.d/conda.sh && conda activate $(ENV_NAME) && poetry run pdoc --html $(PROJECT_NAME) --output-dir docs

# Run pre-commit hooks
run_precommit:
	@echo "Running pre-commit hooks"
	cd $(PROJECT_NAME) && . $(CONDA_BASE)/etc/profile.d/conda.sh && conda activate $(ENV_NAME) && poetry run pre-commit run --all-files

# Copy Jupyter Notebook
copy_jupyter_notebook:
	@echo "Copying Jupyter Notebook into the project directory"
	cp $(JUPYTER_NOTEBOOK) $(PROJECT_NAME)/

# Install Jupyter Kernel
install_jupyter_kernel:
	@echo "Installing Jupyter Kernel"
	. $(CONDA_BASE)/etc/profile.d/conda.sh && conda activate $(ENV_NAME) && python -m ipykernel install --user --name $(KERNEL_NAME) --display-name "Python ($(KERNEL_NAME))"

# Run Jupyter Notebook
run_jupyter_notebook:
	@echo "Running Jupyter Notebook"
	. $(CONDA_BASE)/etc/profile.d/conda.sh && conda activate $(ENV_NAME) && jupyter notebook $(PROJECT_NAME)/$(JUPYTER_NOTEBOOK)

# Full setup
setup: create_conda_env install_poetry init_poetry_project install_dependencies setup_precommit copy_jupyter_notebook install_jupyter_kernel

.PHONY: create_conda_env install_poetry install_dependencies init_poetry_project setup_precommit generate_docs run_precommit copy_jupyter_notebook install_jupyter_kernel run_jupyter_notebook setup setup-conda-pip

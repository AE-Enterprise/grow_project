# grow_project

A repo for experimenting with DevOps technology aswell as Python Django!

### Technology's used
*DevOps*
- GitHub Action runners(rke2 hosted)
- SonarQube (Code test coverage checking + static analysis)
- Terraform
- Ansible

*APIs*
- Python Django DRF
- PostgresSQL integration
- Doocker for container creation



# To build Docker Container and push to repo:

### Step 1 - login to docker repo

It is recommended to create and use a PAT for this step!
docker login ghcr.io -u <GitHubUsername>


# Python Development Setup

## Step 1: Create a Python Virtual Environment

It is recommended to use a virtual environment for Python development. Run the following commands from the project root:

```bash
python3 -m venv src/venv
source src/venv/bin/activate
```

## Step 2: Install All Required Packages

Install all required packages (for all apps and development tools) using:

```bash
pip install -r packages.txt
```

This will install Django, type stubs, pre-commit, and other dependencies needed for all apps.

## Step 3: (Optional) Install App-Specific Requirements

If any app has its own `requirements.txt`, install them as needed. For example:

```bash
pip install -r src/API/Plants/packages.txt
```

Repeat for other apps if they have their own requirements files.

navigate to app you want to build such as 'src/API/Plants' and run build_push.sh

# Pre-commit messages and checks
## Setting Up Pre-commit

Pre-commit helps automate code quality checks before you commit changes.

### Step 1: Install Pre-commit

If you haven't already, install pre-commit in your virtual environment:

```bash
pip install pre-commit
```

### Step 2: Install Pre-commit Hooks

From the project root, run:

```bash
pre-commit install
```

This sets up the git hooks so checks run automatically on `git commit`.

### Step 3: Run Pre-commit Checks Manually

To run all pre-commit checks on all files:

```bash
pre-commit run --all-files
```

This is useful to check your codebase before pushing or after updating hooks.

For more information, see the [pre-commit documentation](https://pre-commit.com/).

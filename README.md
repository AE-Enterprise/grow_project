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

navigate to app you want to build such as 'src/API/Plants' and run build_push.sh

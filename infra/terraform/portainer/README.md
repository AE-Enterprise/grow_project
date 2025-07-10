# Portainer Terraform Module

## Proxmox Token as Environment Variable

For security, do not store your `proxmox_token` directly in `terraform.tfvars` or in version control. Instead, set it as an environment variable before running Terraform:

```sh
export TF_VAR_proxmox_token="your-proxmox-token-here"
```

Terraform will automatically use this value for the `proxmox_token` variable.

terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.78.0"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_host_api_url
  api_token = var.proxmox_token
  insecure  = true
}


data "local_file" "ssh_public_key" {
  filename = var.ssh_public_key_path
}

locals {
  hosts     = yamldecode(file("${path.module}/../../hosts.yaml"))
  portainer = lookup(local.hosts, "portainer", [])
}

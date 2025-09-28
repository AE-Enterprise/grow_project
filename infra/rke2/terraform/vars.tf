# Proxmox Vars
variable "proxmox_host_api_url" {
  description = "Proxmox API endpoint URL"
  type        = string
}

variable "proxmox_token" {
  description = "Proxmox API token"
  type        = string
}

variable "template_vm_id" {
  description = "The VM ID of the Proxmox template to clone (e.g., 100)."
  type        = number
}

variable "proxmox_host_name" {
  description = "Proxmox node name"
  type        = string
}

# New VM Vars

variable "ssh_public_key_path" {
  description = "Path to the SSH public key file to use for VM provisioning."
  type        = string
}

variable "ssh_private_key_path" {
  description = "Path to the SSH private key for Ansible to connect to the VM."
  type        = string
}

variable "ipv4_address" {
  description = "The IPv4 address to assign to the VM."
  type        = string
  default     = "192.168.10.12/24"
}

variable "ipv4_subnet" {
  description = "The subnet for the VMs, e.g. 192.168.10.0/24"
  type        = string
}

variable "gateway" {
  description = "The gateway for the VM's network."
  type        = string
  default     = "192.168.10.1"
}

variable "controller_ip_address" {
  description = "The IP address of the controller VM."
  type        = string
}

variable "k3s_tls_san_domain" {
  description = "Domain name to use for K3s TLS SAN (e.g., rancher.yourdomain.com)"
  type        = string
}

# Ubuntu Server Noble (24.04.x)
# ---
# Packer Template to create an Ubuntu Server (Noble 24.04.x) on Proxmox

# Packer Block to define required Proxmox Plugin
packer {
    required_plugins {
        proxmox = { # key must be the plugin name
            version = "~> 1"
            source  = "github.com/hashicorp/proxmox"
        }
    }
}


# Variable Definitions
variable "proxmox_api_url" {
    type = string
}

variable "proxmox_api_token_id" {
    type = string
}

variable "proxmox_api_token_secret" {
    type      = string
    sensitive = true
}

variable "proxmox_insecure_skip_tls_verify" {
    type        = bool
    description = "Set true to skip TLS certificate verification against Proxmox API (use only for lab/self-signed)."
    default     = false
}

# Ubuntu ISO acquisition variables (simple pattern)
variable "ubuntu_iso_url" {
    type        = string
    description = "Direct URL to Ubuntu ISO"
    default     = "https://releases.ubuntu.com/24.04.3/ubuntu-24.04.3-live-server-amd64.iso"
}

variable "ubuntu_iso_checksum" {
    type        = string
    description = "Exact sha256:<hash> checksum for ubuntu_iso_url (preferred) or file: URL."
    # Example for 24.04.3 live-server:
    default     = "sha256:c3514bf0056180d09376462a7a1b4f213c1d6e8ea67fae5c25099c6fd3d8274b"
}

locals {
    disk_storage = "local-lvm"
}

# Resource Definiation for the VM Template
source "proxmox-iso" "ubuntu-server-noble" {
    # Proxmox Connection Settings
    # HCL2: variables can be referenced directly without string interpolation
    proxmox_url = var.proxmox_api_url
    username    = var.proxmox_api_token_id
    token       = var.proxmox_api_token_secret
    # TLS Verification Control

    # VM General Settings
    node                 = "zeus"
    # vm_id                = "100"
    vm_name              = "ubuntu-server-noble"
    template_description = "Ubuntu Server Noble Image"

    # VM OS Settings
    # Boot ISO configuration (download)
    boot_iso {
        type             = "scsi"
        iso_url          = var.ubuntu_iso_url
        unmount          = true
        iso_storage_pool = "local"
        iso_checksum     = var.ubuntu_iso_checksum
    }

    # To use a previously uploaded local ISO instead, comment the block above and use:
    # boot_iso {
    #   type         = "scsi"
    #   iso_file     = "local:iso/ubuntu-24.04-live-server-amd64.iso" # storage:iso/path
    #   unmount      = true
    #   iso_checksum = "sha256:<hash>" # or leave blank to skip (not recommended)
    # }

    # VM System Settings
    qemu_agent = true

    # VM Hard Disk Settings
    scsi_controller = "virtio-scsi-pci"

    disks {
        disk_size    = "25G"
        format       = "qcow2"
        storage_pool = local.disk_storage
        type         = "virtio"
    }

    # VM CPU Settings
    cores = "1"

    # VM Memory Settings
    memory = "2048"

    # VM Network Settings
    network_adapters {
        model    = "virtio"
        bridge   = "vmbr0"
        firewall = "false"
    }

    # VM Cloud-Init Settings
    cloud_init              = true
    cloud_init_storage_pool = local.disk_storage

    # PACKER Boot Commands
    boot         = "c"
    boot_wait    = "10s"
    communicator = "ssh"
    boot_command = [
        "<esc><wait>",
        "e<wait>",
        "<down><down><down><end>",
        "<bs><bs><bs><bs><wait>",
        "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
        "<f10><wait>"
    ]
    # Useful for debugging
    # Sometimes lag will require this
    # boot_key_interval = "500ms"


    # PACKER Autoinstall Settings
    http_directory          = "http"

    # (Optional) Bind IP Address and Port
    # http_bind_address       = "0.0.0.0"
    # http_port_min           = 8802
    # http_port_max           = 8802

    ssh_username            = "admin"

    # (Option 1) Add your Password here
    # ssh_password        = "your-password"
    # - or -
    # (Option 2) Add your Private SSH KEY file here
    ssh_private_key_file    = "/Users/alexelwell/Documents/SSH/zeus_template_ssh"

    # Raise the timeout, when installation takes longer
    ssh_timeout             = "30m"
    ssh_pty                 = true
}

# Build Definition to create the VM Template
build {

    name    = "ubuntu-server-noble"
    sources = ["source.proxmox-iso.ubuntu-server-noble"]

    # Provisioning the VM Template for Cloud-Init Integration in Proxmox #1
    provisioner "shell" {
        inline = [
            "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
            "sudo rm /etc/ssh/ssh_host_*",
            "sudo truncate -s 0 /etc/machine-id",
            "sudo apt -y autoremove --purge",
            "sudo apt -y clean",
            "sudo apt -y autoclean",
            "sudo cloud-init clean",
            "sudo rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg",
            "sudo rm -f /etc/netplan/00-installer-config.yaml",
            "sudo sync"
        ]
    }

    # Provisioning the VM Template for Cloud-Init Integration in Proxmox #2
    provisioner "file" {
        source      = "files/99-pve.cfg"
        destination = "/tmp/99-pve.cfg"
    }

    # Provisioning the VM Template for Cloud-Init Integration in Proxmox #3
    provisioner "shell" {
        inline = [ "sudo cp /tmp/99-pve.cfg /etc/cloud/cloud.cfg.d/99-pve.cfg" ]
    }

    # Add additional provisioning scripts here
    # ...
}

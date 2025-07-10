resource "proxmox_virtual_environment_vm" "sonarQube" {
  for_each  = { for server in local.sonarQube : server.name => server }
  name      = each.value.name
  node_name = var.proxmox_host_name
  clone {
    vm_id = var.template_vm_id
  }
  initialization {
    ip_config {
      ipv4 {
        address = "${each.value.ip}/24"
        gateway = each.value.gateway
      }
    }
    dns {
      servers = [
        each.value.dns,
        "1.1.1.1",
      ]
    }
    user_account {
      username = each.value.username
      keys     = [trimspace(data.local_file.ssh_public_key.content)]
    }
  }
  cpu {
    cores = lookup(each.value, "vcpu", 2)
  }
  memory {
    dedicated = lookup(each.value, "memory", 2048)
  }
  disk {
    datastore_id = "local-lvm"
    size         = lookup(each.value, "disk_size", 32)
    interface    = lookup(each.value, "disk_device", "scsi0")
  }
  network_device {
    bridge  = "vmbr0"
    vlan_id = lookup(each.value, "vlan_tag", null)
  }
  # Prevent accidental destruction of the VM
  # lifecycle {
  #   prevent_destroy = true
  # }
}

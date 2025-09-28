resource "proxmox_virtual_environment_vm" "k3s_worker" {
  for_each  = { for server in local.workers : server.name => server }
  name      = each.value.name
  node_name = var.proxmox_host_name
  tags      = each.value.tags
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
    user_account {
      username = each.value.username
      keys     = [trimspace(data.local_file.ssh_public_key.content)]
    }
    dns {
      servers = [
        each.value.dns,
        "1.1.1.1",
      ]
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
}

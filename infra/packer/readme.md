

packer build -var-file=vars.pkrvars.hcl -var proxmox_insecure_skip_tls_verify=true ubuntu-server-noble.pkr.hcl

provider_auth_token = "<auth-token>"
provider_cloud_id   = "<cloud-id>"
provider_folder_id  = "<folder-id>"

vm_name        = "future-dev-vm"
cpu_cores      = 2
ram_mb         = 4096
disk_size_gb   = 20
disk_type      = "network-hdd"
subnet_id      = "subnet-dev-0001"
ssh_public_key = "ssh-ed25519 <key> dev-key"
ssh_user       = "ubuntu"
zone           = "ru-central1-a"

labels = {
  env     = "dev"
  project = "future-2.0"
}

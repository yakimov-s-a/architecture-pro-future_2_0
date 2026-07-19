provider_auth_token = "<auth-token>"
provider_cloud_id   = "<cloud-id>"
provider_folder_id  = "<folder-id>"

vm_name        = "future-prod-vm"
cpu_cores      = 8
ram_mb         = 32768
disk_size_gb   = 200
disk_type      = "network-ssd"
subnet_id      = "subnet-prod-0001"
ssh_public_key = "ssh-ed25519 <key> prod-key"
ssh_user       = "ubuntu"
zone           = "ru-central1-a"

labels = {
  env     = "prod"
  project = "future-2.0"
}

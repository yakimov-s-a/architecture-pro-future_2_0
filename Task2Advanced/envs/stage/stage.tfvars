provider_auth_token = "<auth-token>"
provider_cloud_id   = "<cloud-id>"
provider_folder_id  = "<folder-id>"

vm_name        = "future-stage-vm"
cpu_cores      = 4
ram_mb         = 8192
disk_size_gb   = 50
disk_type      = "network-ssd"
subnet_id      = "subnet-stage-0001"
ssh_public_key = "ssh-ed25519 <key> stage-key"
ssh_user       = "ubuntu"
zone           = "ru-central1-a"

labels = {
  env     = "stage"
  project = "future-2.0"
}

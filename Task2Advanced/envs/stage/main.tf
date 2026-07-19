terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.217.0"
    }
  }
}

provider "yandex" {
  token     = var.provider_auth_token
  cloud_id  = var.provider_cloud_id
  folder_id = var.provider_folder_id
  zone      = var.zone
}

module "vm" {
  source = "../../modules/vm"

  vm_name        = var.vm_name
  cpu_cores      = var.cpu_cores
  ram_mb         = var.ram_mb
  disk_size_gb   = var.disk_size_gb
  disk_type      = var.disk_type
  subnet_id      = var.subnet_id
  ssh_public_key = var.ssh_public_key
  ssh_user       = var.ssh_user
  zone           = var.zone
  labels         = var.labels
}

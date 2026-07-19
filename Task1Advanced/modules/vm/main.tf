terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.217.0"
    }
  }
}

resource "yandex_compute_disk" "vm_disk" {
  name     = "${var.vm_name}-disk"
  size     = var.disk_size_gb
  type     = var.disk_type
  zone     = var.zone
  image_id = var.image_family
  labels   = var.labels
}

resource "yandex_compute_instance" "vm" {
  name        = var.vm_name
  platform_id = "standard-v3"
  zone        = var.zone
  labels      = var.labels

  resources {
    cores  = var.cpu_cores
    memory = var.ram_mb / 1024
  }

  boot_disk {
    disk_id = yandex_compute_disk.vm_disk.id
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${var.ssh_public_key}"
  }
}

output "vm_id" {
  description = "ID созданной ВМ"
  value       = yandex_compute_instance.vm.id
}

output "vm_name" {
  description = "Имя ВМ"
  value       = yandex_compute_instance.vm.name
}

output "vm_internal_ip" {
  description = "Внутренний IP-адрес ВМ"
  value       = yandex_compute_instance.vm.network_interface[0].ip_address
}

output "vm_external_ip" {
  description = "Внешний (NAT) IP-адрес ВМ"
  value       = yandex_compute_instance.vm.network_interface[0].nat_ip_address
}

output "disk_id" {
  description = "ID подключаемого диска"
  value       = yandex_compute_disk.vm_disk.id
}

output "disk_size_gb" {
  description = "Размер диска в ГБ"
  value       = yandex_compute_disk.vm_disk.size
}

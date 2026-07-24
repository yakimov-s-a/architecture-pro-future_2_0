variable "provider_auth_token" {
  type        = string
  description = "Yandex Cloud Auth Token"
}

variable "provider_cloud_id" {
  type        = string
  description = "Yandex Cloud cloud ID"
}

variable "provider_folder_id" {
  type        = string
  description = "Yandex Cloud folder ID"
}

variable "vm_name" {
  type        = string
  description = "Имя ВМ"
}

variable "cpu_cores" {
  type        = number
  description = "Количество ядер vCPU"
}

variable "ram_mb" {
  type        = number
  description = "Объем RAM в мегабайтах"
}

variable "disk_size_gb" {
  type        = number
  description = "Размер подключаемого диска в ГБ"
}

variable "disk_type" {
  type        = string
  description = "Тип диска"
  default     = "network-ssd"
}

variable "subnet_id" {
  type        = string
  description = "ID подсети"
}

variable "ssh_public_key" {
  type        = string
  description = "Публичный SSH-ключ"
}

variable "ssh_user" {
  type        = string
  description = "Пользователь SSH"
  default     = "ubuntu"
}

variable "zone" {
  type        = string
  description = "Зона размещения"
  default     = "ru-central1-a"
}

variable "labels" {
  type        = map(string)
  description = "Метки окружения"
  default     = {}
}

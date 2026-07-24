variable "vm_name" {
  description = "Имя ВМ"
  type        = string
}

variable "cpu_cores" {
  description = "Количество ядер vCPU"
  type        = number
}

variable "ram_mb" {
  description = "Объем RAM в мегабайтах"
  type        = number
}

variable "disk_size_gb" {
  description = "Размер подключаемого диска в ГБ"
  type        = number
}

variable "disk_type" {
  description = "Тип диска"
  type        = string
  default     = "network-ssd"
}

variable "subnet_id" {
  description = "ID подсети, к которой подключается ВМ"
  type        = string
}

variable "ssh_public_key" {
  description = "Публичный SSH-ключ для доступа к ВМ"
  type        = string
}

variable "ssh_user" {
  description = "Имя пользователя для SSH-доступа"
  type        = string
  default     = "ubuntu"
}

variable "image_family" {
  description = "Семейство образа ОС для ВМ"
  type        = string
  default     = "ubuntu-2604-lts"
}

variable "zone" {
  description = "Зона размещения ресурсов"
  type        = string
  default     = "ru-central1-a"
}

variable "labels" {
  description = "Произвольные метки / теги окружения"
  type        = map(string)
  default     = {}
}

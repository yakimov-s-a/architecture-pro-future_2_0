# Модульная инфраструктура для нескольких сред

Переиспользуемый Terraform-модуль для создания виртуальной машины с подключаемым диском, сетевым интерфейсом и
SSH-доступом. Модуль параметризован под три окружения: `dev`, `stage` и `prod`.

## Модуль

### Переменные ([variables.tf](modules/vm/variables.tf))

| Переменная       | Тип         | Обязательный                         | Описание                        |
|------------------|-------------|--------------------------------------|---------------------------------|
| `vm_name`        | string      | да                                   | Имя виртуальной машины          |
| `cpu_cores`      | number      | да                                   | Количество ядер vCPU            |
| `ram_mb`         | number      | да                                   | Объем RAM в МБ                  |
| `disk_size_gb`   | number      | да                                   | Размер подключаемого диска в ГБ |
| `disk_type`      | string      | нет (по умолчанию `network-ssd`)     | Тип диска                       |
| `subnet_id`      | string      | да                                   | ID подсети для подключения ВМ   |
| `ssh_public_key` | string      | да                                   | Публичный SSH-ключ для доступа  |
| `ssh_user`       | string      | нет (по умолчанию `ubuntu`)          | Пользователь для SSH            |
| `image_family`   | string      | нет (по умолчанию `ubuntu-2204-lts`) | Семейство образа ОС             |
| `zone`           | string      | нет (по умолчанию `ru-central1-a`)   | Зона размещения                 |
| `labels`         | map(string) | нет (по умолчанию `{}`)              | Метки ресурсов                  |

### Выходные значения ([outputs.tf](modules/vm/outputs.tf))

| Output           | Описание                  |
|------------------|---------------------------|
| `vm_id`          | ID созданной ВМ           |
| `vm_name`        | Имя ВМ                    |
| `vm_internal_ip` | Внутренний IP-адрес ВМ    |
| `vm_external_ip` | Внешний (NAT) IP-адрес ВМ |
| `disk_id`        | ID подключаемого диска    |
| `disk_size_gb`   | Размер диска в ГБ         |

## Запуск для различных окружений

### Dev

```bash
cd envs/dev
terraform init
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"
```

### Stage

```bash
cd envs/stage
terraform init
terraform plan -var-file="stage.tfvars"
terraform apply -var-file="stage.tfvars"
```

### Prod

```bash
cd envs/prod
terraform init
terraform plan -var-file="prod.tfvars"
terraform apply -var-file="prod.tfvars"
```

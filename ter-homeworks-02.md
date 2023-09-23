### Задание 0
<details>
<summary>Получить preview-доступ к функционалу security-groups</summary>
</br>1. Ознакомьтесь с [документацией к security-groups в Yandex Cloud](https://cloud.yandex.ru/docs/vpc/concepts/security-groups?from=int-console-help-center-or-nav).
2. Запросите preview-доступ к этому функционалу в личном кабинете Yandex Cloud. Обычно его выдают в течение 24-х часов.https://console.cloud.yandex.ru/folders/<ваш cloud_id>/vpc/security-groups.<br/>Этот функционал понадобится к следующей лекции.
</details>
  
![terraform_task_0_hw_02](https://github.com/zrusakov/devops-netology/assets/89297920/947b6716-4e74-43c1-b5cf-5c556cae7ecb)

### Задание 1
<details>
<summary>Поправить/дозаполнить проект, запустить VM, подключиться по SSH, ответить на вопросы</summary>
</br>В качестве ответа всегда полностью прикладывайте ваш terraform-код в git.

1. Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.
2. Переименуйте файл personal.auto.tfvars_example в personal.auto.tfvars. Заполните переменные: идентификаторы облака, токен доступа. Благодаря .gitignore этот файл не попадёт в публичный репозиторий. Вы можете выбрать иной способ безопасно передать секретные данные в terraform.
3. Сгенерируйте или используйте свой текущий ssh-ключ. Запишите его открытую часть в переменную vms_ssh_root_key.
4. Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.
5. Ответьте, как в процессе обучения могут пригодиться параметры preemptible = true и core_fraction=5 в параметрах ВМ. Ответ в документации Yandex Cloud.
В качестве решения приложите:

- скриншот ЛК Yandex Cloud с созданной ВМ;
- скриншот успешного подключения к консоли ВМ через ssh. К OS ubuntu необходимо подключаться под пользователем ubuntu: "ssh ubuntu@vm_ip_address";
- ответы на вопросы.
</details>

- Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.
```
main.tf
- platform_id изменил на "standard-v1"
standart-v4 - 4-ой версии не существует + ошибка в слове standard 
- поправил блок resource. минимальная конфигурация vCPU - 2
https://cloud.yandex.ru/docs/compute/concepts/performance-levels
resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
```
Платформы https://cloud.yandex.ru/docs/compute/concepts/vm-platforms <br/>
Уровни производительности vCPU https://cloud.yandex.ru/docs/compute/concepts/performance-levels

- скриншот ЛК Yandex Cloud с созданной ВМ
![ter_hw_02_vm_part_1](https://github.com/zrusakov/devops-netology/assets/89297920/7b1a49c2-a3db-4128-bad8-8f6d624809ac)

- скриншот успешного подключения к консоли ВМ через ssh.
![ter_hw_02_ssh_connection](https://github.com/zrusakov/devops-netology/assets/89297920/eebc8a6e-5db7-4e5a-a4ba-90a087f585b4)

- ответы на вопросы.

Уровни производительности vCPU  </br>  https://cloud.yandex.ru/docs/compute/concepts/performance-levels
```
core_fraction - Гарантированная доля vCPU

Виртуальные машины с уровнем производительности меньше 100% имеют доступ к вычислительной мощности
физических ядер как минимум на протяжении указанного процента от единицы времени.
При уровне производительности 20% ВМ будет иметь доступ к физическим ядрам как минимум 20% времени
— 200 миллисекунд в течение каждой секунды. Тактовая частота процессора в это время не ограничивается
и соответствует выбранной платформе, например, 2 ГГц для платформы Intel Ice Lake (standard-v3).
ВМ с уровнем производительности меньше 100% предназначены для запуска приложений, не требующих
высокой производительности и не чувствительных к задержкам.
Такие машины обойдутся дешевле.

Виртуальные машины с уровнем производительности 100% имеют непрерывный доступ (100% времени)
к вычислительной мощности физических ядер.
Такие ВМ предназначены для запуска приложений, требующих высокой производительности на протяжении
всего времени работы.
```
Сделать виртуальную машину прерываемой </br> https://cloud.yandex.ru/docs/compute/operations/vm-create/create-preemptible-vm </br> Прерываемые виртуальные машины </br> https://cloud.yandex.ru/docs/compute/concepts/preemptible-vm#work-with-preemptible-vm </br>
```
preemptible = true - создает прерываемые виртуальные машины

Прерываемые виртуальные машины — это виртуальные машины, которые могут быть принудительно остановлены
в любой момент. Это может произойти в двух случаях:
Если с момента запуска виртуальной машины прошло 24 часа.
Если возникнет нехватка ресурсов для запуска обычной виртуальной машины в той же зоне доступности.
Вероятность такого события низкая, но может меняться изо дня в день.
```

### Задание 2
<details>
<summary>Замена хардкод-значений</summary>
</br>1. Изучите файлы проекта. </br> 2. Замените все хардкод-значения для ресурсов yandex_compute_image и yandex_compute_instance на отдельные переменные. К названиям переменных ВМ добавьте в начало префикс vm_web_ . Пример: vm_web_name. </br> 3. Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их default прежними значениями из main.tf. </br> 4. Проверьте terraform plan. Изменений быть не должно. 
</details>

- дополнение variables.tf
```
###vm_web_vars

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "example vm_web_ prefix"
}

variable "vm_web_preemptible" {
  type        = string
  default     = "true"
  description = "preemptible VM https://cloud.yandex.ru/docs/compute/concepts/preemptible-vm#work-with-preemptible-vm"
}

variable "vm_web_nat" {
  type        = string
  default     = "true"
  description = "NAT status"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "type of vm_web_ CPU platform https://cloud.yandex.ru/docs/compute/concepts/vm-platforms"
}

variable "vm_web_cores" {
  type        = number
  default     = "2"
  description = "number of vm_web_ cores https://cloud.yandex.ru/docs/compute/concepts/performance-levels"
}

variable "vm_web_memory" {
  type        = number
  default     = "1"
  description = "size of vm_web_ memory"
}

variable "vm_web_core_fraction" {
  type        = number
  default     = "5"
  description = "number of vm_web_ core fraction https://cloud.yandex.ru/docs/compute/concepts/performance-levels"
}

variable "image_name" {
  type = string
  default = "ubuntu-2004-lts"
  description = "ubuntu release name"

}

variable "metadata" {
type = map(any)
        default = {
                spe = "1"
                key = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINiFCb8W4biGF2NZpeR3gAy18yOBfpL0uozhmngmWDdu vagrant@server1"
        }
}
```

- изменения в main.tf
```  
data "yandex_compute_image" "ubuntu" {
  family = var.image_name
}
resource "yandex_compute_instance" "platform" {
  name        = var.vm_web_name
  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.vm_web_cores
    memory        = var.vm_web_memory
    core_fraction = var.vm_web_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_nat
  }

  metadata = {
    serial-port-enable = var.metadata.spe
    ssh-keys           = var.metadata.key
  }

}
```
- снимкок экрана после внесения изменений </br>

![ter_hw_02_part_2](https://github.com/zrusakov/devops-netology/assets/89297920/9045439f-0914-41c9-91c5-423f0bc8108d)

### Задание 3 
<details>
<summary>Перенос переменных VM в отдельный файл + VM db</summary>
</br>1. Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ. </br> 2. Скопируйте блок ресурса и создайте с его помощью вторую ВМ в файле main.tf: "netology-develop-platform-db" , cores = 2, memory = 2, core_fraction = 20. Объявите её переменные с префиксом vm_db_ в том же файле ('vms_platform.tf'). </br> 3. Примените изменения. 
</details>

- содержимое файла vms_platform.tf </br>
```
###vm_web_vars

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "example vm_web_ prefix"
}

variable "vm_web_preemptible" {
  type        = string
  default     = "true"
  description = "preemptible VM https://cloud.yandex.ru/docs/compute/concepts/preemptible-vm#work-with-preemptible-vm"
}

variable "vm_web_nat" {
  type        = string
  default     = "true"
  description = "NAT status"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "type of vm_web_ CPU platform https://cloud.yandex.ru/docs/compute/concepts/vm-platforms"
}

variable "vm_web_cores" {
  type        = number
  default     = "2"
  description = "number of vm_web_ cores https://cloud.yandex.ru/docs/compute/concepts/performance-levels"
}

variable "vm_web_memory" {
  type        = number
  default     = "1"
  description = "size of vm_web_ memory"
}

variable "vm_web_core_fraction" {
  type        = number
  default     = "5"
  description = "number of vm_web_ core fraction https://cloud.yandex.ru/docs/compute/concepts/performance-levels"
}

variable "image_name" {
  type = string
  default = "ubuntu-2004-lts"
  description = "ubuntu release name"

}

variable "metadata" {
type = map(any)
        default = {
                spe = "1"
                key = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINiFCb8W4biGF2NZpeR3gAy18yOBfpL0uozhmngmWDdu vagrant@server1"
        }
}

###vm_db_vars

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "example vm_db_ prefix"
}

variable "vm_db_preemptible" {
  type        = string
  default     = "true"
  description = "preemptible VM https://cloud.yandex.ru/docs/compute/concepts/preemptible-vm#work-with-preemptible-vm"
}

variable "vm_db_nat" {
  type        = string
  default     = "true"
  description = "NAT status"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "type of vm_db_ CPU platform https://cloud.yandex.ru/docs/compute/concepts/vm-platforms"
}

variable "vm_db_cores" {
  type        = number
  default     = "2"
  description = "number of vm_db_ cores https://cloud.yandex.ru/docs/compute/concepts/performance-levels"
}

variable "vm_db_memory" {
  type        = number
  default     = "2"
  description = "size of vm_db_ memory"
}

variable "vm_db_core_fraction" {
  type        = number
  default     = "20"
  description = "number of vm_db_ core fraction https://cloud.yandex.ru/docs/compute/concepts/performance-levels"
}
```
- дополнение в main.tf </br>
```
resource "yandex_compute_instance" "db" {
  name        = var.vm_db_name
  platform_id = var.vm_db_platform_id
  resources {
    cores         = var.vm_db_cores
    memory        = var.vm_db_memory
    core_fraction = var.vm_db_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_db_nat
  }

  metadata = {
    serial-port-enable = var.metadata.spe
    ssh-keys           = var.metadata.key
  }
}
```
- снимкок экрана VM db </br>
![ter_hw_02_db_part_3](https://github.com/zrusakov/devops-netology/assets/89297920/98ca645a-e1e4-4dee-8bb0-d9d9a7703e86)

### Задание 4
<details>
<summary>Вывод значений ip-адресов команды terraform output</summary>
1. Объявите в файле outputs.tf output типа map, содержащий { instance_name = external_ip } для каждой из ВМ.
2. Примените изменения. </br>
В качестве решения приложите вывод значений ip-адресов команды terraform output.
</details>

- содержимое файла outputs.tf </br>
Call to function "map" failed: the "map" function was deprecated in Terraform v0.12 and is no longer available; use tomap({ ... }) syntax to write a literal map.
Использовал tomap({ ... }) 
```
output "external_ip" {
  value = tomap({
        (yandex_compute_instance.platform.name) = yandex_compute_instance.platform.network_interface[0].nat_ip_address,
        (yandex_compute_instance.db.name) = yandex_compute_instance.db.network_interface[0].nat_ip_address
  })
}
```
- снимкок экрана terraform output </br>

![ter_hw_02_output_part_4](https://github.com/zrusakov/devops-netology/assets/89297920/6613c333-6ddc-438b-b93c-87b3acfe6536)

### Задание 5
<details>
<summary>Вывод значений ip-адресов команды terraform output</summary>
1. В файле locals.tf опишите в одном local-блоке имя каждой ВМ, используйте интерполяцию ${..} с несколькими переменными по примеру из лекции.
2. Замените переменные с именами ВМ из файла variables.tf на созданные вами local-переменные. </br>
Примените изменения.
</details>

- содержимое файла local.tf </br>
```
locals {
web = "${var.org}-${var.env}-${var.gen}-${var.type1}"
db = "${var.org}-${var.env }-${var.gen}-${var.type2}"
}

```
- изменения файла variables.tf </br>
```
###hostname vars

variable "org" {
  type        = string
  default     = "netology"
  description = "Organization name"
}

variable "env" {
  type        = string
  default     = "develop"
  description = "Enviroment"
}

variable "gen" {
  type        = string
  default     = "platform"
  description = "Generation"
}

variable "type1" {
  type        = string
  default     = "web"
  description = "type for web"
}


variable "type2" {
  type        = string
  default     = "db"
  description = "type for db"
}
```


- изменения файла main.tf </br>
```
resource "yandex_compute_instance" "platform" {
  name        = local.web

resource "yandex_compute_instance" "db" {
  name        = local.db
```

- снимкок экрана terraform plan </br>
![ter_hw_02_local_task_5](https://github.com/zrusakov/devops-netology/assets/89297920/8aaf1a56-7d35-42db-8399-da4714e3ffd7)

### Задание 6
<details>
  <summary>".._cores",".._memory",".._core_fraction" в блоке resources {...}, объединить в переменные типа map</summary>
1. Вместо использования трёх переменных ".._cores",".._memory",".._core_fraction" в блоке resources {...}, объедините их в переменные типа map с именами "vm_web_resources" и "vm_db_resources". В качестве продвинутой практики попробуйте создать одну map-переменную vms_resources и уже внутри неё конфиги обеих ВМ — вложенный map. </br>
2. Также поступите с блоком metadata {serial-port-enable, ssh-keys}, эта переменная должна быть общая для всех ваших ВМ. </br>
3. Найдите и удалите все более не используемые переменные проекта. </br>
4. Проверьте terraform plan. Изменений быть не должно.  </br>
</details>

- изменения файла vms_platform.tf </br>
```
variable "web_config" {
type = map(number)
        default = {
                cores = "2"
                memory = "1"
                core_fraction = "5"
        }
}

variable "db_config" {
type = map(number)
        default = {
                cores = "2"
                memory = "2"
                core_fraction = "20"
        }
}
variable "metadata" {
type = map(any)
        default = {
                spe = "1"
                key = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINiFCb8W4biGF2NZpeR3gAy18yOBfpL0uozhmngmWDdu vagrant@server1"
        }
}
```
- изменения файла main.tf </br>
```
resource "yandex_compute_instance" "platform" {
  name        = local.web
  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.web_config.cores
    memory        = var.web_config.memory
    core_fraction = var.web_config.core_fraction
  }
resource "yandex_compute_instance" "db" {
  name        = local.db
  platform_id = var.vm_db_platform_id
  resources {
    cores         = var.db_config.cores
    memory        = var.db_config.memory
    core_fraction = var.db_config.core_fraction
  }

```
- снимкок экрана terraform plan </br>
![ter_hw_02_map_part_6](https://github.com/zrusakov/devops-netology/assets/89297920/a57cf4f3-38df-4f28-9ed4-a3322e6f47cf)


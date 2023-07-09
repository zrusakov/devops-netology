## Задача 1

<details>
<summary>Создайте собственный образ</summary>

Создайте собственный образ любой операционной системы (например ubuntu-20.04) с помощью Packer.
Чтобы получить зачёт, вам нужно предоставить скриншот страницы с созданным образом из личного кабинета YandexCloud..

</details>

![disk_image_docker_copmpose](https://github.com/zrusakov/devops-netology/assets/89297920/27e11b60-be68-40c5-84ea-bc7a4865d560)


## Задача 2

<details>
<summary>2.1 Первая VM в облаке</summary>

Создайте вашу первую виртуальную машину в YandexCloud с помощью web-интерфейса YandexCloud.

</details>

![yandex_vm](https://github.com/zrusakov/devops-netology/assets/89297920/6554a988-ed0a-4bdf-82df-3faace091cc7)

<details>
<summary>2.2 Первая VM в облаке с помощью Terraform  </summary>

2.2.* (Необязательное задание)
Создайте вашу первую виртуальную машину в YandexCloud с помощью Terraform (вместо использования веб-интерфейса YandexCloud). Используйте Terraform-код в директории (src/terraform).

Чтобы получить зачёт, вам нужно предоставить вывод команды terraform apply и страницы свойств, созданной ВМ из личного кабинета YandexCloud.

</details>

<details>
<summary>terraform apply</summary>

vagrant@server1:~/terraform/config$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.node01 will be created
  + resource "yandex_compute_instance" "node01" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = "node01.netology.cloud"
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                centos:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDYGOrdDn3eAoRCl9GqK2w7RzyD8Em7Y+UdKgWIiKrUHLt6Q2h8ae20yL3EA2X2qbb7tJQ3WHiHDBa8KpKsxL9ucfskgd0izxqI6M63OvO4kWWkzFSdKcRYUZitL6jsh8yb9S+KaivoH+6eAyU0V0G1mCWSWPeu9g66979DQ2hu8Yj5/ps+jDGP6SNEcaf23fTPG11fTvVNi2qyHQUKV/2D7cpTXa5s1QZMlNEMYEyIT5p8aq25laZJacky9uaTTBC4g/9nmxp//XY3OZpRCXuszhO6dPPWOadqqp/GvAmH9G7PC1jVhtsHVMs9Mu56IilfHyG8aPGhAfk1XddgvMlA1hUh+2uilKcajtAYDbaeYBikpSGjLbrdiQKwlzosjCA7qE0DVNn442Dlkb6JDHtGveDlF4lmmdIJnNTutDLpbZcM0M+hX7uuNJNu97SzqD+oQpE+fg5u2t0Mf8hwIMZA7gxBDZlHHwl77oK/IkLtstpcX0QkbCXkWUR/louaXi8= vagrant@server1
            EOT
        }
      + name                      = "node01"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd80i7f2q4l8507sbteu"
              + name        = "root-node01"
              + size        = 50
              + snapshot_id = (known after apply)
              + type        = "network-nvme"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 8
          + memory        = 8
        }
    }

  # yandex_vpc_network.default will be created
  + resource "yandex_vpc_network" "default" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "net"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_subnet.default will be created
  + resource "yandex_vpc_subnet" "default" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "192.168.101.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + external_ip_address_node01_yandex_cloud = (known after apply)
  + internal_ip_address_node01_yandex_cloud = (known after apply)

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

yandex_vpc_network.default: Creating...
yandex_vpc_network.default: Creation complete after 1s [id=enpk6pbsbuofvbgubppd]
yandex_vpc_subnet.default: Creating...
yandex_vpc_subnet.default: Creation complete after 1s [id=e9bc34sre5bff3hjt2rv]
yandex_compute_instance.node01: Creating...
yandex_compute_instance.node01: Still creating... [10s elapsed]
yandex_compute_instance.node01: Still creating... [20s elapsed]
yandex_compute_instance.node01: Still creating... [30s elapsed]
yandex_compute_instance.node01: Still creating... [40s elapsed]
yandex_compute_instance.node01: Still creating... [50s elapsed]
yandex_compute_instance.node01: Creation complete after 57s [id=fhm84tfk2eug1a2t65le]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

external_ip_address_node01_yandex_cloud = "158.160.101.128"
internal_ip_address_node01_yandex_cloud = "192.168.101.28"


</details>

![yandex_vm_terraform](https://github.com/zrusakov/devops-netology/assets/89297920/f0bc2da9-2efa-4b16-bcc8-e81ab27fce2a)

## Задача 3

<details>
<summary>Prometheus/Grafana</summary>

С помощью Ansible и Docker Compose разверните на виртуальной машине из предыдущего задания систему мониторинга на основе Prometheus/Grafana. Используйте Ansible-код в директории (src/ansible).
Чтобы получить зачёт, вам нужно предоставить вывод команды "docker ps" , все контейнеры, описанные в docker-compose, должны быть в статусе "Up".

</details>

```
[root@node01 centos]# docker ps
CONTAINER ID   IMAGE                              COMMAND                  CREATED             STATUS                       PORTS                                                                              NAMES
a32ec8e55c4d   gcr.io/cadvisor/cadvisor:v0.47.0   "/usr/bin/cadvisor -…"   About an hour ago   Up About an hour (healthy)   8080/tcp                                                                           cadvisor
3f17a4eb9e42   prom/pushgateway:v1.2.0            "/bin/pushgateway"       About an hour ago   Up About an hour             9091/tcp                                                                           pushgateway
8295884670ce   prom/alertmanager:v0.20.0          "/bin/alertmanager -…"   About an hour ago   Up About an hour             9093/tcp                                                                           alertmanager
2ae122eb7f10   prom/prometheus:v2.17.1            "/bin/prometheus --c…"   About an hour ago   Up About an hour             9090/tcp                                                                           prometheus
ccb901f6e5de   prom/node-exporter:v0.18.1         "/bin/node_exporter …"   About an hour ago   Up About an hour             9100/tcp                                                                           nodeexporter
face3a38fdd8   grafana/grafana:7.4.2              "/run.sh"                About an hour ago   Up About an hour             3000/tcp                                                                           grafana
a2f8ff87601b   stefanprodan/caddy                 "/sbin/tini -- caddy…"   About an hour ago   Up About an hour             0.0.0.0:3000->3000/tcp, 0.0.0.0:9090-9091->9090-9091/tcp, 0.0.0.0:9093->9093/tcp   caddy
[root@node01 centos]#
```

## Задача 4

<details>
<summary>Grafana с текущими метриками</summary>

Откройте веб-браузер, зайдите на страницу http://<внешний_ip_адрес_вашей_ВМ>:3000.
Используйте для авторизации логин и пароль из .env-file.
Изучите доступный интерфейс, найдите в интерфейсе автоматически созданные docker-compose-панели с графиками(dashboards).
Подождите 5-10 минут, чтобы система мониторинга успела накопить данные.
Чтобы получить зачёт, предоставьте:

скриншот работающего веб-интерфейса Grafana с текущими метриками, как на примере ниже.

</details>

![add_node_cloud](https://github.com/zrusakov/devops-netology/assets/89297920/d89f81fb-e214-496b-9e9a-83edb82da952)

![docker_compose_grafana](https://github.com/zrusakov/devops-netology/assets/89297920/8a949551-7ce2-405c-977b-cbccd2d5fdce)


## Задача 5

<details>
<summary>Подключить VM к мониторингу</summary>

Создайте вторую ВМ и подключите её к мониторингу, развёрнутому на первом сервере.

Чтобы получить зачёт, предоставьте:

скриншот из Grafana, на котором будут отображаться метрики добавленного вами сервера.

</details>

![add_node](https://github.com/zrusakov/devops-netology/assets/89297920/966ff61b-805f-4a87-a8e9-1c576464fe95)

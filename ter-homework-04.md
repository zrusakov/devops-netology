### Задание 1
<details>
<summary>Использование remote модуля, cloud-init.yml</summary>
1. Возьмите из [демонстрации к лекции готовый код](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1) для создания ВМ с помощью remote-модуля.
2. Создайте одну ВМ, используя этот модуль. В файле cloud-init.yml необходимо использовать переменную для ssh-ключа вместо хардкода. Передайте ssh-ключ в функцию template_file в блоке vars ={} .
Воспользуйтесь [**примером**](https://grantorchard.com/dynamic-cloudinit-content-with-terraform-file-templates/). Обратите внимание, что ssh-authorized-keys принимает в себя список, а не строку.
3. Добавьте в файл cloud-init.yml установку nginx.
4. Предоставьте скриншот подключения к консоли и вывод команды ```sudo nginx -t```.
</details>

cloud-init.yml https://github.com/zrusakov/devops-netology/blob/terraform-04/cloud-init.yml </br>
config.tf https://github.com/zrusakov/devops-netology/blob/terraform-04/config.tf

![ter_hw_04_nginx](https://github.com/zrusakov/devops-netology/assets/89297920/f98dc5b9-3f1a-43b6-a0cb-f07baeb94083)

### Задание 2

<details>
<summary>Локальный модуль, документация terraform-docs</summary>
1. Напишите локальный модуль vpc, который будет создавать 2 ресурса: **одну** сеть и **одну** подсеть в зоне, объявленной при вызове модуля, например: ```ru-central1-a```.
2. Вы должны передать в модуль переменные с названием сети, zone и v4_cidr_blocks.
3. Модуль должен возвращать в root module с помощью output информацию о yandex_vpc_subnet. Пришлите скриншот информации из terraform console о своем модуле. Пример: > module.vpc_dev  
4. Замените ресурсы yandex_vpc_network и yandex_vpc_subnet созданным модулем. Не забудьте передать необходимые параметры сети из модуля vpc в модуль с виртуальной машиной.
5. Откройте terraform console и предоставьте скриншот содержимого модуля. Пример: > module.vpc_dev.
6. Сгенерируйте документацию к модулю с помощью terraform-docs.    
</details>

![ter_hw_04_console_module](https://github.com/zrusakov/devops-netology/assets/89297920/5a070b7e-6eb6-492f-a868-b16b1038af85)

vpc_dev readme - https://github.com/zrusakov/devops-netology/blob/terraform-04/vpc/README.md

### Задание 3

<details>
<summary>Работа со state-ом</summary>
1. Выведите список ресурсов в стейте.
2. Полностью удалите из стейта модуль vpc.
3. Полностью удалите из стейта модуль vm.
4. Импортируйте всё обратно. Проверьте terraform plan. Изменений быть не должно.
Приложите список выполненных команд и скриншоты процессы. 
</details>

```
terraform state list
terraform state rm 'module.vpc_dev'
terraform state rm 'module.test-vm'
terraform import 'module.vpc_dev.yandex_vpc_subnet.dev' e9bv0lj5lb7enruimpnq
terraform import 'module.vpc_dev.yandex_vpc_network.dev' enp8dnkr63k6et9po23e
terraform import 'module.test-vm.data.yandex_compute_image.my_image' fd8o6khjbdv3f1suqf69
terraform import 'module.test-vm.yandex_compute_instance.vm[1]' fhmsn01ih8p8dobtgi1e
terraform import 'module.test-vm.yandex_compute_instance.vm[0]' fhm8grirr7ndue1mlddi
```
![ter_hw_04_rm_from_state_modules](https://github.com/zrusakov/devops-netology/assets/89297920/130f1c8b-8418-441b-9275-0dde1ce5792b)

![ter_hw_04_import_to_state](https://github.com/zrusakov/devops-netology/assets/89297920/aa23ee29-f164-4b54-a9cb-f3c404caa27c)

![ter_hw_04_import_to_state_final_condition](https://github.com/zrusakov/devops-netology/assets/89297920/5f481f0f-c2ec-4b8b-abef-3f83908db3ec)

![ter_hw_04_VM_in_place_upgrade](https://github.com/zrusakov/devops-netology/assets/89297920/9a0eb82f-1591-459a-afce-a0385d88b321)


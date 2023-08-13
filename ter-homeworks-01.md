## Чек-лист готовности к домашнему заданию

1.Скачайте и установите актуальную версию Terraform >=1.4.X . Приложите скриншот вывода команды terraform --version

![terraform_version](https://github.com/zrusakov/devops-netology/assets/89297920/2215d670-c5a1-4780-b442-4bf256f9ca9c)

2. Скачайте на свой ПК этот git-репозиторий. Исходный код для выполнения задания расположен в директории 01/src.

```
vagrant@server1:~/ter_hw_01/ter-homeworks/01/src$ cat main.tf
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
  required_version = ">=0.13" /*Многострочный комментарий.
 Требуемая версия terraform */
}
provider "docker" {}
....
```

3. Убедитесь, что в вашей ОС установлен docker.   
```
vagrant@server1:~/ter_hw_01/ter-homeworks/01/src$ docker --version
Docker version 24.0.2, build cb74dfc
```

4. Зарегистрируйте аккаунт на сайте https://hub.docker.com/, выполните команду docker login и введите логин, пароль.
```
vagrant@server1:~/ter_hw_01/ter-homeworks/01/src$ docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: zvrusakov
Password:
WARNING! Your password will be stored unencrypted in /home/vagrant/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
```
## Задание 1

1. Перейдите в каталог src. Скачайте все необходимые зависимости, использованные в проекте.

![ter_dependencies](https://github.com/zrusakov/devops-netology/assets/89297920/be6bb273-4489-4a48-bbb9-b7959c95d885)

2. Изучите файл .gitignore. В каком terraform-файле, согласно этому .gitignore, допустимо сохранить личную, секретную информацию?
```
# own secret vars store.
personal.auto.tfvars
```

3. Выполните код проекта. Найдите в state-файле секретное содержимое созданного ресурса random_password, пришлите в качестве ответа конкретный ключ и его значение.
```
 "result": "mYmLLeofZ9nk7lIC"
```

4. Раскомментируйте блок кода, примерно расположенный на строчках 29–42 файла main.tf. Выполните команду terraform validate. Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их.
```
vagrant@server1:~/ter_hw_01/ter-homeworks/01/src$ terraform validate
╷
│ Error: Missing name for resource
│
│   on main.tf line 24, in resource "docker_image":
│   24: resource "docker_image" {
│
│ All resource blocks must have 2 labels (type, name).
╵
╷
│ Error: Invalid resource name
│
│   on main.tf line 29, in resource "docker_container" "1nginx":
│   29: resource "docker_container" "1nginx" {
│
│ A name must start with a letter or underscore and may contain only letters, digits, underscores, and dashes.

Имя должно начинаться с буквы или символа подчеркивания и может содержать только буквы, цифры, символы подчеркивания и дефисы.
исправил resource "docker_container" "nginx_01" 

Все блоки ресурсов должны иметь 2 метки (тип, имя).

добавил имя resource "docker_image" "nginx"

╷
│ Error: Reference to undeclared resource
│
│   on main.tf line 30, in resource "docker_container" "nginx_01":
│   30:   name  = "example_${random_password.random_string_FAKE.resulT}"
│
│ A managed resource "random_password" "random_string_FAKE" has not been declared in the root module.

исправил  ${random_password.random_string.result}
```
итоговый листинг исправленных блоков main.tf
```
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "example_${random_password.random_string.result}"

  ports {
    internal = 80
    external = 8000
  }
}
```

5. Выполните код. В качестве ответа приложите вывод команды docker ps.
```
vagrant@server1:~/ter_hw_01/ter-homeworks/01/src$ docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES
77a277653ed9   89da1fb6dcb9   "/docker-entrypoint.…"   20 seconds ago   Up 19 seconds   0.0.0.0:8000->80/tcp   example_mYmLLeofZ9nk7lIC
```

6. Замените имя docker-контейнера в блоке кода на hello_world. Не перепутайте имя контейнера и имя образа. Мы всё ещё продолжаем использовать name = "nginx:latest". Выполните команду terraform apply -auto-approve. Объясните своими словами, в чём может быть опасность применения ключа -auto-approve. В качестве ответа дополнительно приложите вывод команды docker ps.
```
vagrant@server1:~/ter_hw_01/ter-homeworks/01/src$ docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
8f6a79a9e585   89da1fb6dcb9   "/docker-entrypoint.…"   6 seconds ago   Up 5 seconds   0.0.0.0:8000->80/tcp   hello_world
```
```
Опция -auto-approve позволяет применить новую конфигурацию без этапа планирования
минуя подтверждение вносимых изменений. Опасность применения ключа -auto-approve
при чел факе - ошибка в конфигурации, будут внесены незапланированные изменения.
```

7. Уничтожьте созданные ресурсы с помощью terraform. Убедитесь, что все ресурсы удалены. Приложите содержимое файла terraform.tfstate.
```
Destroy complete! Resources: 3 destroyed.
vagrant@server1:~/ter_hw_01/ter-homeworks/01/src$ cat terraform.tfstate
{
  "version": 4,
  "terraform_version": "1.5.2",
  "serial": 20,
  "lineage": "7d5c10fe-f9ea-1736-8a36-9d949e036fc1",
  "outputs": {},
  "resources": [],
  "check_results": null
}
```

8. Объясните, почему при этом не был удалён docker-образ nginx:latest. Ответ подкрепите выдержкой из документации провайдера docker.
```
Используется параметр keep_locally со значением true

keep_locally (Boolean) If true, then the Docker image won't be deleted
on destroy operation. If this is false, it will delete the image from
the docker local storage on destroy operation.
```

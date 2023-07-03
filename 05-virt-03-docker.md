**Задача 1**

```
https://hub.docker.com/repository/docker/zvrusakov/nginx/general
```
**Задача 2**

высоконагруженное монолитное java веб-приложение;
```
Высоконагруженное и монолитное - разделить нельзя, высокие требования к ресурсам.
Подойдет физический сервер или VM.
```

Nodejs веб-приложение;
```
Контенеризация для веб приложений - отличный вариант. Оптимально будет использование Docker.
Позволяет быстро развернуть приложение, проще обслуживать и выпускать релизы
```

мобильное приложение c версиями для Android и iOS;
```
Мобильное приложение - значит нужен GUI. Оптимально использовать VM
```

шина данных на базе Apache Kafka;
```
В условиях нет информации о нагрузке и типу среды на которой развертываем Kafka.
Если среда ПРОД, то оптимально использать VM, а если среда тестовая/RnD, можно использовать Docker.
```

Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
```
Оптимально Elasticsearch на VM, logstash и kibana на docker.
Обеспечиваем отказоустойчивость, эффективнее в части ресурсов и проще обслуживать.
```

мониторинг-стек на базе Prometheus и Grafana
```
Уместно использовать Docker. Контейнер с Prometheus, контейнер с Grafana
и подключенным внешним хранилищем для данных мониторинга.
```

MongoDB, как основное хранилище данных для java-приложения
```
В условиях нет информации о нагрузке и типу среды на которой развертываем MongoDB.
Если нагрузка высокая, то физический сервер, если нет – VM. RnD - уместно и Docker
```

Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.
```
Оптимально развернуть на VM. 
```

**Задача 3**

Запустите первый контейнер из образа centos c любым тегом в фоновом режиме, подключив папку /data из текущей рабочей директории на хостовой машине в /data контейнера.
```
vagrant@server1:/$ docker run -it --rm -d --name centos -v $(pwd)/data:/data centos:latest
Unable to find image 'centos:latest' locally
latest: Pulling from library/centos
a1d0c7532777: Pull complete
Digest: sha256:a27fd8080b517143cbbbab9dfb7c8571c40d67d534bbdee55bd6c473f432b177
Status: Downloaded newer image for centos:latest
5c54128f3ea91bcaf907434c9fd5e9141e76503f08d83ae2dbe21fb30a2801af
```
Запустите второй контейнер из образа debian в фоновом режиме, подключив папку /data из текущей рабочей директории на хостовой машине в /data контейнера.
```
vagrant@server1:/$ docker run -it --rm -d --name debian -v $(pwd)/data:/data debian:latest
Unable to find image 'debian:latest' locally
latest: Pulling from library/debian
bba7bb10d5ba: Pull complete
Digest: sha256:d568e251e460295a8743e9d5ef7de673c5a8f9027db11f4e666e96fb5bed708e
Status: Downloaded newer image for debian:latest
8a7b328348c6b5d50d5ebd9284de8dd0b807268a6cc8167dd299c55fb8fb7050
```
Подключитесь к первому контейнеру с помощью docker exec и создайте текстовый файл любого содержания в /data.
```
vagrant@server1:/$ docker exec -it centos /bin/bash
[root@5c54128f3ea9 /]# echo "CentOS" > /data/centos.txt
[root@5c54128f3ea9 /]# exit
exit
```
Добавьте ещё один файл в папку /data на хостовой машине.
```
vagrant@server1:/$ sudo su
[sudo] password for vagrant:
root@server1:/# echo "host" > /data/host.txt
```
Подключитесь во второй контейнер и отобразите листинг и содержание файлов в /data контейнера.
```
root@server1:/# docker attach debian
root@8a7b328348c6:/# ls data/
centos.txt  host.txt
```
**Задача 4**

```
https://hub.docker.com/repository/docker/zvrusakov/ansible/general
```

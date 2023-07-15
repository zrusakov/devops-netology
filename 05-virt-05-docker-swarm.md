## Задача 1

Дайте письменые ответы на вопросы:

В чём отличие режимов работы сервисов в Docker Swarm-кластере: replication и global?
```
В режиме global сервисы запускаются на всех нодах кластера
В режиме replication сервисы запускаются на указанном количестве нод.
```
Какой алгоритм выбора лидера используется в Docker Swarm-кластере?
```
Raft (алгоритм поддержания распределенного консенсуса )

https://habr.com/ru/companies/redmadrobot/articles/318866/

Отказоустойчивость сервиса гарантируется самим Docker.
Это достигается в том числе за счет того, что в кластере
могут одновременно работать несколько управляющих нод,
которые могут в любой момент заменить вышедшего из строя лидера.
```
Что такое Overlay Network?
```
https://habr.com/ru/articles/334004/#overlay

Overlay-сеть создает подсеть, которую могут использовать контейнеры
в разных хостах swarm-кластера. Контейнеры на разных физических
хостах могут обмениваться данными по overlay-сети
(если все они прикреплены к одной сети).
Overlay-сеть использует технологию vxlan, которая инкапсулирует
layer 2 фреймы в layer 4 пакеты (UDP/IP).
```

## Задача 2

<details>
<summary>Первый Docker Swarm-кластер в Яндекс Облаке</summary>

Создайте ваш первый Docker Swarm-кластер в Яндекс Облаке.
Чтобы получить зачёт, предоставьте скриншот из терминала (консоли) с выводом команды:
docker node ls

</details>

```
ubuntu@manager-01:~$ docker node ls
ID                            HOSTNAME     STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
0wjsnaorp5tp51d51wgc5ngrh *   manager-01   Ready     Active         Leader           24.0.4
l1t9gx7j22tzwiz95lliegzna     manager-02   Ready     Active         Reachable        24.0.4
sdsxz01037b6kpluz8v7fa6on     manager-03   Ready     Active         Reachable        24.0.4
txm6d0p39legk9hmbmwbfia8u     worker-01    Ready     Active                          24.0.4
uivbmbc8josqmfysy58r1xt46     worker-02    Ready     Active                          24.0.4
z0hhtip9gon56hsvvtbl3bgol     worker-03    Ready     Active                          24.0.4
```

## Задача 3

<details>
<summary>Кластер мониторинга, состоящий из стека микросервисов</summary>

Создайте ваш первый, готовый к боевой эксплуатации кластер мониторинга, состоящий из стека микросервисов.
Чтобы получить зачёт, предоставьте скриншот из терминала (консоли), с выводом команды:
docker service ls

</details>

```
ubuntu@manager-01:~$ docker service ls
ID             NAME                                MODE         REPLICAS   IMAGE                                          PORTS
uer1qjl7t7nv   swarm_monitoring_alertmanager       replicated   1/1        stefanprodan/swarmprom-alertmanager:v0.14.0
pozxg8aa0gka   swarm_monitoring_caddy              replicated   1/1        stefanprodan/caddy:latest                      *:3000->3000/tcp, *:9090->9090/tcp, *:9093-9094->9093-9094/tcp
pjw7chpxoz14   swarm_monitoring_cadvisor           global       0/1        google/cadvisor:latest
paumpzt05yxn   swarm_monitoring_dockerd-exporter   global       6/6        stefanprodan/caddy:latest
520qwxs3gjpm   swarm_monitoring_grafana            replicated   1/1        stefanprodan/swarmprom-grafana:5.3.4
1tol09tvwm3r   swarm_monitoring_node-exporter      global       6/6        stefanprodan/swarmprom-node-exporter:v0.16.0
krsywt0gv3q3   swarm_monitoring_prometheus         replicated   1/1        stefanprodan/swarmprom-prometheus:v2.5.0
eszj2cpok5fr   swarm_monitoring_unsee              replicated   1/1        cloudflare/unsee:v0.8.0
```

![docker-swarm-monitoring](https://github.com/zrusakov/devops-netology/assets/89297920/6141dcc3-cffd-490e-8194-deb70777e303)

## Задача 4

<details>
<summary>docker swarm update --autolock=true</summary>

Выполните на лидере Docker Swarm-кластера команду, указанную ниже, и дайте письменное описание её функционала — что она делает и зачем нужна:
см.документацию: https://docs.docker.com/engine/swarm/swarm_manager_locking/
docker swarm update --autolock=true

</details>

```
ubuntu@manager-01:~$ docker swarm update --autolock=true
Swarm updated.
To unlock a swarm manager after it restarts, run the `docker swarm unlock`
command and provide the following key:

    SWMKEY-1-Zanxe8adgxFjlQyF0UrynAM6fuh/Lzm0ARwEQLXx68E

Please remember to store this key in a password manager, since without it you
will not be able to restart the manager.
```
```
docker swarm update --autolock=true включает автоблокировку на случай перезагрузки ноды.
Безопасность (защита от несанкционированного доступа) - шифрование логов и трафика в кластере.
Ввод ключа позволит расшифровать лог Raft и загрузить все "секреты" в память ноды.
```
```
при перезагрузке manager-01 нода стала недоступна в кластере, лидером стал manager-03
нода manager-01 добавилась в кластер только после разблокировки ноды

ubuntu@manager-02:~$ docker node ls
ID                            HOSTNAME     STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
0wjsnaorp5tp51d51wgc5ngrh     manager-01   Down      Active         Unreachable      24.0.4
l1t9gx7j22tzwiz95lliegzna *   manager-02   Ready     Active         Reachable        24.0.4
sdsxz01037b6kpluz8v7fa6on     manager-03   Ready     Active         Leader           24.0.4
txm6d0p39legk9hmbmwbfia8u     worker-01    Ready     Active                          24.0.4
uivbmbc8josqmfysy58r1xt46     worker-02    Ready     Active                          24.0.4
z0hhtip9gon56hsvvtbl3bgol     worker-03    Ready     Active                          24.0.4

ubuntu@manager-01:~$ docker swarm unlock
Please enter unlock key:
ubuntu@manager-01:~$ docker node ls
ID                            HOSTNAME     STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
0wjsnaorp5tp51d51wgc5ngrh *   manager-01   Ready     Active         Reachable        24.0.4
l1t9gx7j22tzwiz95lliegzna     manager-02   Ready     Active         Reachable        24.0.4
sdsxz01037b6kpluz8v7fa6on     manager-03   Ready     Active         Leader           24.0.4
txm6d0p39legk9hmbmwbfia8u     worker-01    Ready     Active                          24.0.4
uivbmbc8josqmfysy58r1xt46     worker-02    Ready     Active                          24.0.4
z0hhtip9gon56hsvvtbl3bgol     worker-03    Ready     Active                          24.0.4
```

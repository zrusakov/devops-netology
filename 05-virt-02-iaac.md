**Задача 1**

Опишите основные преимущества применения на практике IaaC-паттернов.
```
-удобство и скорость маштабирования;
-использование системы контроля версий позволяет легко вносить, отслеживать и откатывать изменения;
-минимизация возникновения ошибок. IaaC гарантирует, что в различных средах конфигурация будет одинаковой;
-восстановление инфраструктуры в случае аварий и сбоев.
```
Какой из принципов IaaC является основополагающим?
```
-идемпотентность. получаешь одинаковый результат при повторных выполнениях операций.
```
**Задача 2**

Чем Ansible выгодно отличается от других систем управление конфигурациями?
```
-agentless работает без агента на клиентах, использует ssh для доступа
-yaml формат конфигурации. легко освоить, удобно читать
-готовые модули, возможность самостоятельно писать новые модули
-подробная и наглядная документация
-
```
Какой, на ваш взгляд, метод работы систем конфигурации более надёжный — push или pull?
```
имхо наиболее надежный метод это Push.
есть централизованная точка распространения, из который можно следить за ходом выполнения доставки.
```

**Задача 3**

Установите на личный компьютер:

VirtualBox,
Vagrant,
Terraform,
Ansible.
Приложите вывод команд установленных версий каждой из программ, оформленный в Markdown.

```
C:\>vagrant --version
Vagrant 2.2.19
```
```
C:\Program Files\Oracle\VirtualBox>VBoxManage -version
6.1.34r150636
```
```
C:\Program Files\Terraform>terraform.exe --version
Terraform v1.5.1
on windows_amd64
```
```
vagrant@ansible:~/vagrant$ ansible --version
ansible [core 2.12.10]
  config file = /home/vagrant/vagrant/ansible.cfg
  configured module search path = ['/home/vagrant/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.8.10 (default, Nov 26 2021, 20:14:08) [GCC 9.3.0]
  jinja version = 2.10.1
  libyaml = True
```

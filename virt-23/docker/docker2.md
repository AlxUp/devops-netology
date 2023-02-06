Домашнее задание к занятию "4. Оркестрация группой Docker контейнеров на примере Docker Compose"


1. Создать собственный образ любой операционной системы (например, ubuntu-20.04) с помощью Packer
![SCREENSHOT1](https://github.com/AlxUp/devops-netology/blob/master/virt-23/docker/yc1.png)
![SCREENSHOT2](https://github.com/AlxUp/devops-netology/blob/master/virt-23/docker/yc2.png)

2. Создать вашу первую виртуальную машину в YandexCloud с помощью terraform.
![SCRENNSHOT3](https://github.com/AlxUp/devops-netology/blob/master/virt-23/docker/vm1.png)
![SCREENSHOT4](https://github.com/AlxUp/devops-netology/blob/master/virt-23/docker/vm2.png)

3. С помощью ansible и docker-compose разверните на виртуальной машине из предыдущего задания систему мониторинга на основе Prometheus/Grafana . Используйте ansible код в директории (src/ansible)
![SCRENNSHOT5]

4.
- Откройте веб-браузер, зайдите на страницу `http://<внешний_ip_адрес_вашей_ВМ>:3000`.
- Используйте для авторизации логин и пароль из (.env-file).
- Изучите доступный интерфейс, найдите в интерфейсе автоматически созданные docker-compose панели с графиками(dashboards).
- Подождите 5-10 минут, чтобы система мониторинга успела накопить данные.

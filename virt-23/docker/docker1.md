Практическая работа "Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"

1. Сценарий выполения задачи:

создайте свой репозиторий на https://hub.docker.com;
выберете любой образ, который содержит веб-сервер Nginx;
создайте свой fork образа;
реализуйте функциональность: запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```
Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

```
root@sysadm-fs:/home/vagrant# docker pull nginx
Using default tag: latest
latest: Pulling from library/nginx
Digest: sha256:b8f2383a95879e1ae064940d9a200f67a6c79e710ed82ac42263397367e7cc4e
Status: Image is up to date for nginx:latest
docker.io/library/nginx:latest
root@sysadm-fs:/home/vagrant#
```
```
root@sysadm-fs:/home/vagrant# docker build -f dockerfile.txt -t alxup/alx .
Sending build context to Docker daemon  15.36kB
Step 1/2 : FROM nginx
 ---> a99a39d070bf
Step 2/2 : RUN echo '<html><head>Hey, Netology</head><body><h1>Hello Netology!</h1></body></html>' > /usr/share/nginx/html/index.html
 ---> Running in 0c94d51f2389
Removing intermediate container 0c94d51f2389
 ---> f494540bed0b
Successfully built f494540bed0b
Successfully tagged alxup/alx:latest
root@sysadm-fs:/home/vagrant#
```
```
root@sysadm-fs:/home/vagrant# docker push alxup/alx
Using default tag: latest
The push refers to repository [docker.io/alxup/alx]
6fa35fc9d88c: Pushed 
80115eeb30bc: Mounted from library/nginx 
049fd3bdb25d: Mounted from library/nginx 
ff1154af28db: Mounted from library/nginx 
8477a329ab95: Mounted from library/nginx 
7e7121bf193a: Mounted from library/nginx 
67a4178b7d47: Mounted from library/nginx 
latest: digest: sha256:62f0168e79fa80500c7cbf23598e96b03f788e6945e9eb96699648e4c8a73fc3 size: 1777
```

https://hub.docker.com/repository/docker/alxup/alx/general 
```
CONTAINER ID   IMAGE       COMMAND                  CREATED          STATUS          PORTS                                   NAMES
e0d796623bef   alxup/alx   "/docker-entrypoint.…"   9 seconds ago    Up 8 seconds    0.0.0.0:8080->80/tcp, :::8080->80/tcp   sharp_bhaskara 
```
![screenshot](https://github.com/AlxUp/devops-netology/blob/master/virt-23/docker/alx.png)

2. 
Посмотрите на сценарий ниже и ответьте на вопрос: "Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

Высоконагруженное монолитное java веб-приложение;
```
Физический или виртуальный сервер с выделенными ресурсами, конкретно под наше веб-приложение.
```
Nodejs веб-приложение;
```
Docker контейнер, не нужно много ресурсов.
```
Мобильное приложение c версиями для Android и iOS;

```
Мобильные приложеия загружаются в магазин приложений, у андройда это один файл .apk.Для разработки конечно физическая машина, для остального наверное и виртуалки сойдут. 
```
Шина данных на базе Apache Kafka;
```
Докер или Виртуалочка
```
Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
```
Виртуальные машины
```
Мониторинг-стек на базе Prometheus и Grafana;
```
можно Docker, а можно рядом с elasticsearch, logstash, kibana поставить на виртуалки
```
MongoDB, как основное хранилище данных для java-приложения;
```
Виртуалка, удобно будет добавлять ресурсы
```
Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.
```
Физическая машина
```
3. 
Запустите первый контейнер из образа centos c любым тэгом в фоновом режиме, подключив папку /data из текущей рабочей директории на хостовой машине в /data контейнера;
Запустите второй контейнер из образа debian в фоновом режиме, подключив папку /data из текущей рабочей директории на хостовой машине в /data контейнера;
```
root@sysadm-fs:/home/vagrant# docker pull centos
Using default tag: latest
latest: Pulling from library/centos
a1d0c7532777: Pull complete 
Digest: sha256:a27fd8080b517143cbbbab9dfb7c8571c40d67d534bbdee55bd6c473f432b177
Status: Downloaded newer image for centos:latest
docker.io/library/centos:latest

root@sysadm-fs:/home/vagrant# docker pull debian
Using default tag: latest
latest: Pulling from library/debian
bbeef03cda1f: Pull complete 
Digest: sha256:534da5794e770279c889daa891f46f5a530b0c5de8bfbc5e40394a0164d9fa87
Status: Downloaded newer image for debian:latest
docker.io/library/debian:latest
```

```
root@sysadm-fs:/home/vagrant# docker run -v /data:/data --name centos-container -d -t centos
63def0c347dd1d02addd54032a9b1d6c9fac8b9051e7dbdc4fdb9367e198d451
root@sysadm-fs:/home/vagrant# docker run -v /data:/data --name debian-container -d -t debian
0b0969f7afb54caae26db4b430edd9320adeb5a447c5ef7b27b69733a9d7501b
```
```
root@sysadm-fs:/home/vagrant# docker ps
CONTAINER ID   IMAGE     COMMAND       CREATED          STATUS          PORTS     NAMES
0b0969f7afb5   debian    "bash"        6 seconds ago    Up 5 seconds              debian-container
63def0c347dd   centos    "/bin/bash"   18 seconds ago   Up 17 seconds             centos-container
```
Подключитесь к первому контейнеру с помощью docker exec и создайте текстовый файл любого содержания в /data;
```
docker exec centos-container /bin/bash -c "echo test_message>/data/readme.md"
```
Добавьте еще один файл в папку /data на хостовой машине;
```
sudo touch /data/readme_host.md
sudo nano /data/readme_host.md
 test_message2
```
Подключитесь во второй контейнер и отобразите листинг и содержание файлов в /data контейнера.
```
root@sysadm-fs:/home/vagrant# docker exec -it debian-container /bin/bash
root@0b0969f7afb5:/# cd /data
root@0b0969f7afb5:/data# ls -l
total 8
-rw-r--r-- 1 root root 13 Jan 27 08:23 readme.md
-rw-r--r-- 1 root root 15 Jan 27 08:24 readme_host.md
root@0b0969f7afb5:/data# 
```
```

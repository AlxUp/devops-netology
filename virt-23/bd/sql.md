#Домашнее задание к занятию "2. SQL"


1. Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, в который будут складываться данные БД и бэкапы.

![SCREENSHOT](https://github.com/AlxUp/devops-netology/blob/master/virt-23/bd/screenshot/1-1.png)

![SCREENSHOT](https://github.com/AlxUp/devops-netology/blob/master/virt-23/bd/screenshot/1-2.png)

![SCREENSHOT](https://github.com/AlxUp/devops-netology/blob/master/virt-23/bd/screenshot/1-3.png)

2. В БД из задачи 1:

создайте пользователя test-admin-user и БД test_db
в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
создайте пользователя test-simple-user
предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db
Таблица orders:

id (serial primary key)
наименование (string)
цена (integer)
Таблица clients:

id (serial primary key)
фамилия (string)
страна проживания (string, index)
заказ (foreign key orders)
Приведите:

итоговый список БД после выполнения пунктов выше,
описание таблиц (describe)
SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
список пользователей с правами над таблицами test_db


```
root@cd7f250133b4:/# createdb test_db -U alx
root@cd7f250133b4:/# psql -d test_db -U alx
psql (12.14 (Debian 12.14-1.pgdg110+1))
Type "help" for help.

test_db=# CREATE USER test_admin_user;
CREATE ROLE
test_db=# CREATE TABLE orders
(
   id SERIAL PRIMARY KEY,
   наименование TEXT,
   цена INTEGER
);
CREATE TABLE
test_db=# CREATE TABLE clients
(
    id SERIAL PRIMARY KEY,
    фамилия TEXT,
    "страна проживания" TEXT,
    заказ INTEGER,
    FOREIGN KEY (заказ) REFERENCES orders(id)
);
CREATE TABLE
test_db=# CREATE INDEX country_index ON clients ("страна проживания");
CREATE INDEX
test_db-# 

```
```
test_db=# GRANT ALL ON TABLE orders TO test_admin_user;
GRANT
test_db=# GRANT ALL ON TABLE clients TO test_admin_user;
GRANT

```
```
test_db=# CREATE USER test_simple_user;
CREATE ROLE

```
```
test_db=# GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE orders TO test_simple_user;
GRANT
test_db=# GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE clients TO test_simple_user;
GRANT

```
![SCREENSHOT](https://github.com/AlxUp/devops-netology/blob/master/virt-23/bd/screenshot/2-1.png)
![SCREENSHOT](https://github.com/AlxUp/devops-netology/blob/master/virt-23/bd/screenshot/2-2.png)
![SCREENSHOT](https://github.com/AlxUp/devops-netology/blob/master/virt-23/bd/screenshot/2-3.png)
3. Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

Наименование	цена
Шоколад	10
Принтер	3000
Книга	500
Монитор	7000
Гитара	4000
Таблица clients

ФИО	Страна проживания
Иванов Иван Иванович	USA
Петров Петр Петрович	Canada
Иоганн Себастьян Бах	Japan
Ронни Джеймс Дио	Russia
Ritchie Blackmore	Russia
Используя SQL синтаксис:

вычислите количество записей для каждой таблицы
приведите в ответе:
запросы
результаты их выполнения.
```
test_db=# INSERT INTO orders VALUES (1, 'Шоколад', 10), (2, 'Принтер', 3000), (3, 'Книга', 500), (4, 'Монитор', 7000), (5, 'Гитара', 4000);
INSERT 0 5
test_db=# INSERT INTO clients VALUES (1, 'Иванов Иван Иванович', 'USA'), (2, 'Петров Петр Петрович', 'Canada'), (3, 'Иоганн Себастьян Бах', 'Japan'), (4, 'Ронни Джеймс Дио', 'Russia'), (5, 'Ritchie Blackmore', 'Russia');
INSERT 0 5
test_db=# 
```

```
test_db=# SELECT COUNT (*) FROM orders;
 count 
-------
     5
(1 row)

test_db=# SELECT COUNT (*) FROM clients;
 count 
-------
     5
(1 row)

test_db=# 

```

4. Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

ФИО	Заказ
Иванов Иван Иванович	Книга
Петров Петр Петрович	Монитор
Иоганн Себастьян Бах	Гитара
Приведите SQL-запросы для выполнения данных операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.

Подсказк - используйте директиву UPDATE.
![SCREENSHOT4](https://github.com/AlxUp/devops-netology/blob/master/virt-23/bd/screenshot/4.png)

5. Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 (используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.

![SCREENSHOT5](https://github.com/AlxUp/devops-netology/blob/master/virt-23/bd/screenshot/5.png)
```
Чтение данных из таблицы clients происходит с использованием метода Seq Scan — последовательного чтения данных. 
Значение 0.00 — ожидаемые затраты на получение первой строки. Второе — 18.10 — ожидаемые затраты на получение всех строк. 
rows - ожидаемое число строк, которое должен вывести этот узел плана. При этом так же предполагается, что узел выполняется до конца. 
width - ожидаемый средний размер строк, выводимых этим узлом плана (в байтах). Каждая запись сравнивается с условием "заказ" IS NOT NULL. 
Если условие выполняется, запись вводится в результат. Иначе — отбрасывается.
```

6. Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления.

```
root@cd7f250133b4:/# pg_dump -U alx test_db > /home/backup/test_db.backup
```
```
vagrant@sysadm-fs:~/sql$ sudo docker stop pg12
pg12
vagrant@sysadm-fs:~/sql$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
vagrant@sysadm-fs:~/sql$ 

```
```
vagrant@sysadm-fs:~/sql$ sudo docker run --name pg12_new -e POSTGRES_PASSWORD=12345678 -d postgres:12
```
```
vagrant@sysadm-fs:/home$ sudo docker cp pg12:/home/test_db.backup /home
vagrant@sysadm-fs:/home$ sudo docker cp home/test_db.backup pg12_new:/home
root@bdac24fcc02a:/# psql -U postgres -d test_db -f /home/test_db.backup
```

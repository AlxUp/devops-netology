#Домашнее задание к занятию 4. «PostgreSQL»
Задача 1
Используя Docker, поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL, используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

Найдите и приведите управляющие команды для:

* вывода списка БД,
* подключения к БД,
* вывода списка таблиц,
* вывода описания содержимого таблиц,
* выхода из psql.
```
root@home:~# docker pull postgres:13
root@home:~# docker volume create vol1
vol1
root@home:~# docker run --name postgres1 -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v vol1:/var/lib/postgresql/data postgres:13
7c5004c4397b79930b8e4d40e0a9933abe8ca4de2fbcbcde00cb4dd21a47a60f
root@home:~# docker exec -it postgres1 bash
root@7c5004c4397b:/# psql -U postgres
psql (13.6 (Debian 13.6-1.pgdg110+1))
Type "help" for help.
```

```
\l[+]   [PATTERN]      list databases
\c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo}     connect to new database (currently "postgres")
 \dt[S+] [PATTERN]      list tables
   \d[S+]  NAME           describe table, view, sequence, or index
   \q
```
Задача 2
Используя `psql`, создайте БД `test_database`.

Изучите бэкап БД.

Восстановите бэкап БД в `test_database`.

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу `pg_stats`, найдите столбец таблицы `orders` с наибольшим средним значением размера элементов в байтах.

Приведите в ответе команду, которую вы использовали для вычисления, и полученный результат.

```
root@99d4d1201b55:/ddd# psql -U postgres -f ./test_dump.sql test_database
```
```
root@99d4d1201b55:/ddd#  su - postgres
postgres@99d4d1201b55:~$ psql -U postgres
psql (13.6 (Debian 13.6-1.pgdg110+1))
Type "help" for help.

postgres=# 
```
```
postgres=# \l
                                   List of databases
     Name      |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
---------------+----------+----------+------------+------------+-----------------------
 postgres      | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0     | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
               |          |          |            |            | postgres=CTc/postgres
 template1     | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
               |          |          |            |            | postgres=CTc/postgres
 test_database | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
(4 rows)

postgres=# \c test_database
You are now connected to database "test_database" as user "postgres".
```
```
test_database=# ANALYZE VERBOSE public.orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE
test_database=# select avg_width from pg_stats where tablename='orders';
 avg_width
-----------
         4
        16
         4
(3 rows)
```

Задача 3
Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и поиск по ней занимает долгое время. Вам как успешному выпускнику курсов DevOps в Нетологии предложили провести разбиение таблицы на 2: шардировать на orders_1 - price>499 и orders_2 - price<=499.

Предложите SQL-транзакцию для проведения этой операции.

Можно ли было изначально исключить ручное разбиение при проектировании таблицы orders?
```
test_database=# alter table orders rename to orders2;
ALTER TABLE
test_database=# create table orders (id integer, title varchar(80), price integer) partition by range(price);
CREATE TABLE
test_database=# create table orders_2 partition of orders for values from (0) to (499);
CREATE TABLE
test_database=# create table orders_1 partition of orders for values from (499) to (999999999);
CREATE TABLE
test_database=# insert into orders (id, title, price) select * from orders2;
INSERT 0 8
```
Задача 4
Используя утилиту `pg_dump`, создайте бекап БД `test_database`.

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?
```
postgres@99d4d1201b55:~$ pg_dump -U postgres -d test_database > dump.sql
```

```
CREATE TABLE public.orders_2 (
    id integer,
    title character varying(80) UNIQUE,
    price integer
);
```

###Домашнее задание к занятию "3. MySQL"


1. Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.
```
root@sysadm-fs:/home/vagrant/mysql# docker pull mysql
root@sysadm-fs:/home/vagrant/mysql# docker run -v /mydat:/datin --name mysql1 -d -e MYSQL_ROOT_PASSWORD=mysql mysql
13779b0a8e3d5c93e4e0ee189cef38caafdd3a733f6236c5663687aac621da51
root@sysadm-fs:/home/vagrant/mysql# docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS                 NAMES
13779b0a8e3d   mysql     "docker-entrypoint.s…"   19 seconds ago   Up 18 seconds   3306/tcp, 33060/tcp   mysql1
root@sysadm-fs:/home/vagrant/mysql# docker exec -it mysql1 bash
```
Изучите бэкап БД и восстановитесь из него.
```
root@750287e19fe4:/datin# mysql -uroot -pmysql test_db < test_dump.sql
```

Перейдите в управляющую консоль `mysql` внутри контейнера.
```
root@750287e19fe4:/datin# mysql -hlocalhost -uroot -pmysql
...
```
Используя команду `\h` получите список управляющих команд.
```
mysql> \h

For information about MySQL products and services, visit:
   http://www.mysql.com/
For developer information, including the MySQL Reference Manual, visit:
   http://dev.mysql.com/
To buy MySQL Enterprise support, training, or other products, visit:
   https://shop.mysql.com/

List of all MySQL commands:
Note that all text commands must be first on line and end with ';'
?         (\?) Synonym for `help'.
clear     (\c) Clear the current input statement.
connect   (\r) Reconnect to the server. Optional arguments are db and host.
delimiter (\d) Set statement delimiter.
edit      (\e) Edit command with $EDITOR.
ego       (\G) Send command to mysql server, display result vertically.
exit      (\q) Exit mysql. Same as quit.
go        (\g) Send command to mysql server.
help      (\h) Display this help.
nopager   (\n) Disable pager, print to stdout.
notee     (\t) Don't write into outfile.
pager     (\P) Set PAGER [to_pager]. Print the query results via PAGER.
print     (\p) Print current command.
prompt    (\R) Change your mysql prompt.
quit      (\q) Quit mysql.
rehash    (\#) Rebuild completion hash.
source    (\.) Execute an SQL script file. Takes a file name as an argument.
status    (\s) Get status information from the server.
system    (\!) Execute a system shell command.
tee       (\T) Set outfile [to_outfile]. Append everything into given outfile.
use       (\u) Use another database. Takes database name as argument.
charset   (\C) Switch to another charset. Might be needed for processing binlog with multi-byte charsets.
warnings  (\W) Show warnings after every statement.
nowarning (\w) Don't show warnings after every statement.
resetconnection(\x) Clean session context.
query_attributes Sets string parameters (name1 value1 name2 value2 ...) for the next query to pick up.

For server side help, type 'help contents'
```
Найдите команду для выдачи статуса БД и приведите в ответе из ее вывода версию сервера БД.
```
mysql> \s
--------------
mysql  Ver 8.0.32 for Linux on x86_64 (MySQL Community Server - GPL)
```
Подключитесь к восстановленной БД и получите список таблиц из этой БД.
```
mysql> use test_db;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> show tables;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.00 sec)
```
Приведите в ответе количество записей с `price` > 300.
```
mysql> select count(*) from orders where price > 300;
+----------+
| count(*) |
+----------+
|        1 |
+----------+
1 row in set (0.00 sec)
```
В следующих заданиях мы будем продолжать работу с данным контейнером.

2. Создайте пользователя test в БД c паролем test-pass, используя:

* плагин авторизации mysql_native_password
* срок истечения пароля - 180 дней
* количество попыток авторизации - 3
* максимальное количество запросов в час - 100
* аттрибуты пользователя:
  * Имя "James"
  * Фамилия "Pretty"


Предоставьте привелегии пользователю `test` на операции SELECT базы `test_db`.

Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю test и приведите в ответе к задаче.
```
mysql> CREATE USER 'test'@'localhost' IDENTIFIED BY 'myparol';
Query OK, 0 rows affected (0.01 sec)
mysql> select * from INFORMATION_SCHEMA.USER_ATTRIBUTES;
+------------------+-----------+-----------+
| USER             | HOST      | ATTRIBUTE |
+------------------+-----------+-----------+
| root             | %         | NULL      |
| mysql.infoschema | localhost | NULL      |
| mysql.session    | localhost | NULL      |
| mysql.sys        | localhost | NULL      |
| root             | localhost | NULL      |
| test             | localhost | NULL      |
+------------------+-----------+-----------+
6 rows in set (0.00 sec)

mysql> ALTER USER 'test'@'localhost'
    -> IDENTIFIED BY 'myparol'
    -> WITH
    -> MAX_QUERIES_PER_HOUR 100
    -> PASSWORD EXPIRE INTERVAL 180 DAY
    -> FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME UNBOUNDED
    -> ATTRIBUTE '{"fam": "Pretty", "name": "James"}';
Query OK, 0 rows affected (0.02 sec)
mysql> select * from INFORMATION_SCHEMA.USER_ATTRIBUTES;
+------------------+-----------+------------------------------------+
| USER             | HOST      | ATTRIBUTE                          |
+------------------+-----------+------------------------------------+
| root             | %         | NULL                               |
| mysql.infoschema | localhost | NULL                               |
| mysql.session    | localhost | NULL                               |
| mysql.sys        | localhost | NULL                               |
| root             | localhost | NULL                               |
| test             | localhost | {"fam": "Pretty", "name": "James"} |
+------------------+-----------+------------------------------------+
6 rows in set (0.01 sec)

mysql> GRANT Select ON test_db.orders TO 'test'@'localhost';
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test';
+------+-----------+------------------------------------+
| USER | HOST      | ATTRIBUTE                          |
+------+-----------+------------------------------------+
| test | localhost | {"fam": "Pretty", "name": "James"} |
+------+-----------+------------------------------------+
1 row in set (0.00 sec)

```
3. Установите профилирование `SET profiling = 1`. Изучите вывод профилирования команд `SHOW PROFILES;`.

Исследуйте, какой `engine` используется в таблице БД `test_db` и приведите в ответе.

Измените `engine` и приведите время выполнения и запрос на изменения из профайлера в ответе:

* на `MyISAM`
* на `InnoDB`
```
mysql> SET profiling = 1;
mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test';
+------+-----------+------------------------------------+
| USER | HOST      | ATTRIBUTE                          |
+------+-----------+------------------------------------+
| test | localhost | {"fam": "Pretty", "name": "James"} |
+------+-----------+------------------------------------+
1 row in set (0.00 sec)

mysql> SHOW PROFILES;
+----------+------------+--------------------------------------------------------------------+
| Query_ID | Duration   | Query                                                              |
+----------+------------+--------------------------------------------------------------------+
|        1 | 0.00042900 | SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test' |
+----------+------------+--------------------------------------------------------------------+
1 row in set, 1 warning (0.00 sec)
mysql> SELECT TABLE_NAME,ENGINE,ROW_FORMAT,TABLE_ROWS,DATA_LENGTH,INDEX_LENGTH FROM information_schema.TABLES WHERE table_name = 'orders' and  TABLE_SCHEMA = 'test_db' ORDER BY ENGINE asc;
+------------+--------+------------+------------+-------------+--------------+
| TABLE_NAME | ENGINE | ROW_FORMAT | TABLE_ROWS | DATA_LENGTH | INDEX_LENGTH |
+------------+--------+------------+------------+-------------+--------------+
| orders     | InnoDB | Dynamic    |          5 |       16384 |            0 |
+------------+--------+------------+------------+-------------+--------------+
1 row in set (0.00 sec)


Используется InnoDB

mysql> ALTER TABLE orders ENGINE = MyISAM;
Query OK, 5 rows affected (0.03 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SELECT TABLE_NAME,ENGINE,ROW_FORMAT,TABLE_ROWS,DATA_LENGTH,INDEX_LENGTH FROM information_schema.TABLES WHERE table_name = 'orders' and  TABLE_SCHEMA = 'test_db' ORDER BY ENGINE asc;
+------------+--------+------------+------------+-------------+--------------+
| TABLE_NAME | ENGINE | ROW_FORMAT | TABLE_ROWS | DATA_LENGTH | INDEX_LENGTH |
+------------+--------+------------+------------+-------------+--------------+
| orders     | MyISAM | Dynamic    |          5 |       16384 |            0 |
+------------+--------+------------+------------+-------------+--------------+
1 row in set (0.00 sec)

mysql> ALTER TABLE orders ENGINE = InnoDB;
Query OK, 5 rows affected (0.03 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SHOW PROFILES;
+----------+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Query_ID | Duration   | Query                                                                                                                                                                                |
+----------+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|        1 | 0.00042900 | SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test'                                                                                                                   |
|        2 | 0.00172150 | SELECT * FROM information_schema.TABLES WHERE table_name = 'orders' and  TABLE_SCHEMA = 'test_db' ORDER BY ENGINE asc                                                                |
|        3 | 0.00120675 | SELECT TABLE_NAME,ENGINE,ROW_FORMAT,TABLE_ROWS,DATA_LENGTH,INDEX_LENGTH FROM information_schema.TABLES WHERE table_name = 'orders' and  TABLE_SCHEMA = 'test_db' ORDER BY ENGINE asc |
|        4 | 0.00007475 | ALTER TABLE orders ENGINE = MyISAM                                                                                                                                                   |
|        5 | 0.00026950 | select * from orders                                                                                                                                                                 |
|        6 | 0.00014575 | SELECT DATABASE()                                                                                                                                                                    |
|        7 | 0.00072600 | show databases                                                                                                                                                                       |
|        8 | 0.00085550 | show tables                                                                                                                                                                          |
|        9 | 0.00031275 | select * from orders                                                                                                                                                                 |
|       10 | 0.02430250 | ALTER TABLE orders ENGINE = MyISAM                                                                                                                                                   |
|       11 | 0.00138825 | SELECT TABLE_NAME,ENGINE,ROW_FORMAT,TABLE_ROWS,DATA_LENGTH,INDEX_LENGTH FROM information_schema.TABLES WHERE table_name = 'orders' and  TABLE_SCHEMA = 'test_db' ORDER BY ENGINE asc |
|       12 | 0.00053825 | SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test'                                                                                                                   |
|       13 | 0.02744125 | ALTER TABLE orders ENGINE = InnoDB                                                                                                                                                   |
+----------+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
13 rows in set, 1 warning (0.00 sec)

Продолжительность переключения

10 | 0.02430250 | ALTER TABLE orders ENGINE = MyISAM 
13 | 0.02744125 | ALTER TABLE orders ENGINE = InnoDB      


```
4. Изучите файл `my.cnf` в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):

* Скорость IO важнее сохранности данных
* Нужна компрессия таблиц для экономии места на диске
* Размер буффера с незакомиченными транзакциями 1 Мб
* Буффер кеширования 30% от ОЗУ
* Размер файла логов операций 100 Мб
Приведите в ответе измененный файл `my.cnf`.
```
root@750287e19fe4:/# cat /etc/mysql/my.cnf

[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
secure-file-priv= NULL

# Custom config should go here
!includedir /etc/mysql/conf.d/

#Скорость IO важнее сохранности данных
# 0 - скорость
# 1 - сохранность
# 2 - универсальный параметр
innodb_flush_log_at_trx_commit = 0

#Set compression
# Barracuda - формат файла с сжатием увеличивает нагрузку на процессор
innodb_file_format=Barracuda

#Размер буфера с незакомиченными транзакциями 1 Мб
innodb_log_buffer_size  = 1M

#Буфер кеширования 30% от ОЗУ
key_buffer_size = 330М

# Размер файла логов операций 100 Мб
max_binlog_size = 100M
```

1. Какого типа команда cd? Попробуйте объяснить, почему она именно такого типа: опишите ход своих мыслей, 
если считаете, что она могла бы быть другого типа.
```
vagrant@vagrant:~$ type cd

cd is a shell builtin
```

2. Какая альтернатива без pipe команде grep <some_string> <some_file> | wc -l?
Подсказка
man grep поможет в ответе на этот вопрос.
```
Альтернатива без pipe команде grep <some_string> <some_file> | wc -l является grep -c <some_string> <some_file>
```
3. Какой процесс с PID 1 является родителем для всех процессов в вашей виртуальной машине Ubuntu 20.04?
```
vagrant@vagrant:~$ pstree -a -p  | head -n 1
systemd,1
```
```
vagrant@vagrant:~$ sudo ls -l /proc/1/exe
lrwxrwxrwx 1 root root 0 Jan 17 14:17 /proc/1/exe -> /usr/lib/systemd/systemd
```
```
vagrant@vagrant:~$ ps -F 1
UID          PID    PPID  C    SZ   RSS PSR STIME TTY      STAT   TIME CMD
root           1       0  0 42366 12984   1 14:04 ?        Ss     0:04 /sbin/init
```
```
vagrant@vagrant:~$ ls -lh /sbin/init
lrwxrwxrwx 1 root root 20 Sep  8 09:58 /sbin/init -> /lib/systemd/systemd
```
4. Как будет выглядеть команда, которая перенаправит вывод stderr ls на другую сессию терминала?
```
vagrant@vagrant:~$ sudo ls -l \root 2>/dev/pts/1
```

5. Получится ли одновременно передать команде файл на stdin и вывести ее stdout в другой файл? Приведите работающий пример.

```
sed 's/#/##/g' <~/test1 >test2
```

6. Получится ли, находясь в графическом режиме, вывести данные из PTY в какой-либо из эмуляторов TTY? Сможете ли вы наблюдать выводимые данные?
```
root@vagrant:/home/vagrant# echo 'message' > /dev/tty1
```

7. Выполните команду bash 5>&1. К чему она приведет? Что будет, если вы выполните echo netology > /proc/$$/fd/5? Почему так происходит?
   `bash 5>&1` запустит экземпляр bash с fd 5 и перенаправит его на fd 1 (stdout).

   `echo netology > /proc/$$/fd/5` выведет в терминал слово "netology". Это произойдёт потому что echo отправляет netology в fd 5 текущего шелла 

8. Получится ли в качестве входного потока для pipe использовать только stderr команды, не потеряв при этом отображение stdout на pty?
 
```
Да получится, если будем использовать новый дескриптор. cat file 5>&1 2>&1 1>&5 | grep 'No such file' перенаправляем из 5го и 2го дескриптора в перый, а затем из первого перенаправляем в 5ый
```

9. Что выведет команда cat /proc/$$/environ? Как еще можно получить аналогичный по содержанию вывод?

```
root@vagrant:/home/vagrant# cat /proc/$$/environ
```
Переменные окружения.

10. Используя man, опишите что доступно по адресам /proc/<PID>/cmdline, /proc/<PID>/exe.
/proc/<PID>/cmdline выведет команду, к которой относится , со всеми агрументами, разделёнными специальными символом '\x0' (это не пробел, cat файла выведёт всё "слипнувшимся")

```
/proc/<PID>/exe это симлинк на полный путь к исполняемому файлоу, из которого вызвана программа с этим пидом
```

11. Узнайте, какую наиболее старшую версию набора инструкций SSE поддерживает ваш процессор с помощью /proc/cpuinfo.
```
root@vagrant:/proc# cat cpuinfo | grep -o 'sse[0-9_]*' | sort -h | uniq
sse
sse2
sse3
sse4
sse4_1
sse4_2 - `старшая версия`
```
12. При открытии нового окна терминала и vagrant ssh создается новая сессия и выделяется pty.

Это можно подтвердить командой tty, которая упоминалась в лекции 3.2.
Однако:
```
vagrant@netology1:~$ ssh localhost 'tty'
not a tty
Почитайте, почему так происходит, и как изменить поведение.
ssh localhost 'tty'
vagrant@localhost password:
not a tty
```
Это сделано для правильной работы в скриптах. Если сразу выполнить команду на удалённом сервере через ssh, sshd это поймёт, и запускаемые команды тоже, 
поэтому они не будут спрашивать что-то у пользователя, а вывод очистят от лишних данных.

Например, если в интерактивном режиме программа задала бы пользователю вопрос и ждала ответа "yes/no", при запуске через ssh она этого делать не станет.

Изменить поведение можно добавив флаг -t при вызове ssh.

```
ssh -t localhost 'tty'
vagrant@localhost password:
/dev/pts/1
Connection to localhost closed.
```

13. Бывает, что есть необходимость переместить запущенный процесс из одной сессии в другую. Попробуйте сделать это, воспользовавшись reptyr.

Работает

14. `sudo echo string > /root/new_file` не даст выполнить перенаправление под обычным пользователем, так как перенаправлением занимается процесс shell'а,
который запущен без `sudo` под вашим пользователем. Для решения данной проблемы можно использовать конструкцию `echo string | sudo tee /root/new_file`. 
Узнайте? что делает команда `tee` и почему в отличие от `sudo echo` команда с `sudo tee` будет работать.

Команда `tee` делает вывод одновременно и в файл, указанный в качестве параметра, и в `stdou`t. В данном примере команда получает вывод из `stdin`,
перенаправленный через `pipe` от `stdout` команды `echo` и т.к. команда запущена от `sudo`, соответственно имеет повышенные права на запись.

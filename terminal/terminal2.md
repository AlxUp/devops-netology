Задание1 Какого типа команда cd? Попробуйте объяснить, почему она именно такого типа: опишите ход своих мыслей, если считаете, что она могла бы быть другого типа.
vagrant@vagrant:~$ type cd
cd is a shell builtin

Задание2 Какая альтернатива без pipe команде grep <some_string> <some_file> | wc -l?
Подсказка
man grep поможет в ответе на этот вопрос.
ls -r -inc *

Ознакомьтесь с документом о других подобных некорректных вариантах использования pipe.


Задание3 Какой процесс с PID 1 является родителем для всех процессов в вашей виртуальной машине Ubuntu 20.04?
vagrant@vagrant:~$ pstree -a -p  | head -n 1
systemd,1
vagrant@vagrant:~$ sudo ls -l /proc/1/exe
lrwxrwxrwx 1 root root 0 Jan 17 14:17 /proc/1/exe -> /usr/lib/systemd/systemd
vagrant@vagrant:~$ ps -F 1
UID          PID    PPID  C    SZ   RSS PSR STIME TTY      STAT   TIME CMD
root           1       0  0 42366 12984   1 14:04 ?        Ss     0:04 /sbin/init
vagrant@vagrant:~$ ls -lh /sbin/init
lrwxrwxrwx 1 root root 20 Sep  8 09:58 /sbin/init -> /lib/systemd/systemd
vagrant@vagrant:~$


Задание4 Как будет выглядеть команда, которая перенаправит вывод stderr ls на другую сессию терминала?
vagrant@vagrant:~$ sudo ls -l \root 2>/dev/pts/1

Задание5 Получится ли одновременно передать команде файл на stdin и вывести ее stdout в другой файл? Приведите работающий пример.
sed 's/#/##/g' <~/test1 >test2

Задание6 Получится ли, находясь в графическом режиме, вывести данные из PTY в какой-либо из эмуляторов TTY? Сможете ли вы наблюдать выводимые данные?
root@vagrant:/home/vagrant# echo 'message' > /dev/tty1

Задание7 Выполните команду bash 5>&1. К чему она приведет? Что будет, если вы выполните echo netology > /proc/$$/fd/5? Почему так происходит?
bash 5>&1 запустит экземпляр bash с fd 5 и перенаправит его на fd 1 (stdout).

echo netology > /proc/$$/fd/5 выведет в терминал слово "netology". Это произойдёт потому что echo отправляет netology в fd 5 текущего шелла 

Задание8 Получится ли в качестве входного потока для pipe использовать только stderr команды, не потеряв при этом отображение stdout на pty?
ДА. cat ~/.bashrc dasdsfad 2>&1 1>/dev/pts/0 | sed 's/cat/test/g' > test;

Задание9 Что выведет команда cat /proc/$$/environ? Как еще можно получить аналогичный по содержанию вывод?
root@vagrant:/home/vagrant# cat /proc/$$/environ
SHELL=/bin/bashSUDO_GID=1000SUDO_COMMAND=/usr/bin/suSUDO_USER=vagrantPWD=/home/vagrantLOGNAME=rootHOME=/rootLANG=en_US.UTF-8LS_COLORS=rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;
35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;
31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;
31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*
.cpio=01;
31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;
35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.
mkv=01;
35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;
35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;
36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:LESSCLOSE=/usr/bin/lesspipe %s 
%sTERM=xterm-256colorLESSOPEN=| /usr/bin/lesspipe %sUSER=rootSHLVL=2PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/
binSUDO_UID=1000MAIL=/var/mail/root_=/usr/bin/bashroot@vagrant:/home/vagrant#
Переменные окружения.

Задание10 Используя man, опишите что доступно по адресам /proc/<PID>/cmdline, /proc/<PID>/exe.
/proc/<PID>/cmdline выведет команду, к которой относится , со всеми агрументами, разделёнными специальными символом '\x0' (это не пробел, cat файла выведёт всё "слипнувшимся")

/proc/<PID>/exe это симлинк на полный путь к исполняемому файлоу, из которого вызвана программа с этим пидом

Задание11 Узнайте, какую наиболее старшую версию набора инструкций SSE поддерживает ваш процессор с помощью /proc/cpuinfo.
root@vagrant:/proc# cat cpuinfo | grep -o 'sse[0-9_]*' | sort -h | uniq
sse
sse2
sse3
sse4
sse4_1
sse4_2 - старшая версия

Задание12 При открытии нового окна терминала и vagrant ssh создается новая сессия и выделяется pty.
Это можно подтвердить командой tty, которая упоминалась в лекции 3.2.
Однако:
vagrant@netology1:~$ ssh localhost 'tty'
not a tty
Почитайте, почему так происходит, и как изменить поведение.
ssh localhost 'tty'
vagrant@localhost password:
not a tty

то сделано для правильной работы в скриптах. Если сразу выполнить команду на удалённом сервере через ssh, sshd это поймёт, и запускаемые команды тоже, поэтому они не будут спрашивать 
что-то у пользователя, а вывод очистят от лишних данных.

Например, если в интерактивном режиме программа задала бы пользователю вопрос и ждала ответа "yes/no", при запуске через ssh она этого делать не станет.

Изменить поведение можно добавив флаг -t при вызове ssh.

ssh -t localhost 'tty'
vagrant@localhost password:
/dev/pts/1
Connection to localhost closed.

Задание13 Бывает, что есть необходимость переместить запущенный процесс из одной сессии в другую. Попробуйте сделать это, воспользовавшись reptyr.
Работает

Задание14 sudo echo string > /root/new_file не даст выполнить перенаправление под обычным пользователем, так как перенаправлением занимается процесс shell'а, который запущен без sudo 
под вашим пользователем. Для решения данной проблемы можно использовать конструкцию echo string | sudo tee /root/new_file. 
Узнайте? что делает команда tee и почему в отличие от sudo echo команда с sudo tee будет работать.

Команда tee делает вывод одновременно и в файл, указанный в качестве параметра, и в stdout. В данном примере команда получает вывод из stdin, перенаправленный через pipe от stdout 
команды echo и т.к. команда запущена от sudo, соответственно имеет повышенные права на запись.

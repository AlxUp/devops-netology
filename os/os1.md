   "Практическая работа 3.3 Операционные системы"

   Задание
1. Какой системный вызов делает команда cd?
   В прошлом ДЗ мы выяснили, что cd не является самостоятельной программой, это shell builtin, поэтому запустить strace непосредственно на cd не получится. Тем не менее, вы можете запустить
   strace на /bin/bash -c 'cd /tmp'. В этом случае вы увидите полный список системных вызовов, которые делает сам bash при старте.
   Вам нужно найти тот единственный, который относится именно к cd. Обратите внимание, что strace выдаёт результат своей работы в поток stderr, а не в stdout.

    `chdir()`

2. Попробуйте использовать команду file на объекты разных типов в файловой системе. Например:

    `vagrant@netology1:~$ file /dev/tty/dev/tty: character special (5/0) vagrant@netology1:~$ file /dev/sda/dev/sda: block special (8/0) vagrant@netology1:~$ file /bin/bash/bin/bash: ELF 64-bit LSB shared object, x86-64`

   Используя strace выясните, где находится база данных file, на основании которой она делает свои догадки.

    `openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3`

3. Предположим, приложение пишет лог в текстовый файл. Этот файл оказался удален (deleted в lsof), однако возможности сигналом сказать приложению переоткрыть файлы или просто перезапустить приложение – нет. Так как приложение продолжает писать в удаленный файл, место на диске постепенно заканчивается. Основываясь на знаниях о перенаправлении потоков предложит способ обнуления открытого удаленного файла (чтобы освободить место на файловой системе).
 
   По pid процесса. Получить список всех процессов и используемых процессом, и перенаправить. 

4. Занимают ли зомби-процессы какие-то ресурсы в ОС (CPU, RAM, IO)?
 
   Нет, призавершении процесса память и другие ресурсы освобождаются, что бы не мешать другим.

5. В iovisor BCC есть утилита opensnoop:

    `root@vagrant:~# dpkg -L bpfcc-tools | grep sbin/opensnoop/usr/sbin/opensnoop-bpfcc`

   На какие файлы вы увидели вызовы группы open за первую секунду работы утилиты? Воспользуйтесь пакетом bpfcc-tools для Ubuntu 20.04. Дополнительные сведения по установке.

   971    vminfo              6   0 /var/run/utmp
   632    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
   632    dbus-daemon        19   0 /usr/share/dbus-1/system-services
   632    dbus-daemon        -1   2 /lib/dbus-1/system-services
   632    dbus-daemon        19   0 /var/lib/snapd/dbus-1/system-services/

6. Какой системный вызов использует uname -a? Приведите цитату из man по этому системному вызову, где описывается альтернативное местоположение в /proc, где можно узнать версию ядра и 
   релиз ОС.

    `uname()`

    `Part of the utsname information is also accessible via /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}.`

7. Чем отличается последовательность команд через ; и через && в bash? Например:

    `root@netology1:~# test -d /tmp/some_dir; echo Hi`
    `Hi`
    `root@netology1:~# test -d /tmp/some_dir && echo Hi`
    `root@netology1:~#`
   Есть ли смысл использовать в bash &&, если применить `set -e`?

8. Из каких опций состоит режим bash set -euxo pipefail и почему его хорошо было бы использовать в сценариях?
   `&&` логический оператор. 
   `;` разделитель команд.
   `set -e` установка или снятие значений параметров оболочки. Использование с `&&` не имеет смысла, т.к. с `-e` произойдет немедленный выход, если команда завершается с ненулевым
   статусом.
 
9. Используя -o stat для ps, определите, какой наиболее часто встречающийся статус у процессов в системе. 
   В man ps ознакомьтесь (/PROCESS STATE CODES) что значат дополнительные к основной заглавной буквы статуса процессов. 
   Его можно не учитывать при расчете (считать S, Ss или Ssl равнозначными).

  `Ss` - неактивные процессы;
  `R+` - выполняющиеся в группе приоритетных.

  Дополнительные значения состояния процесса:
  `<` - высокий приоритет;
  `N` - низкий приорит;
  `L` - имеет страницы, заблокированные в памяти;
  `s` - является лидером сеанса;
  `l` - является многопоточным;
  `+` - находится в группе приоритетных процессов.

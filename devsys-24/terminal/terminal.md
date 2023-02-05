   Практическое задание "3-1/Работа в терминале"
1. Установил VirtualBox.
2. Установил Vagrant(через vpn, создал учётную запись на vagrant cloud). Выполнил vagrant add box bento/ubuntu-20.04, vagrant up.
3. Использую z-shell терминал на ubuntu 22.10 
4. RAM:1024mb
   CPU:2 cpu
   HDD:64gb
   video:4mb
5. 
   Прописать в vagrantfile:

   config.vm.provider "virtualbox" do |vb| 
     vb.memory = "2048" 
     vb.cpu = "24"
   end

6. подключился по vagrant ssh 
8. Число строк журнала задаётся переменной окружения HISTFILESIZE, она описана со строки 1060
   Число команд задаётся переменой окружения HISTSIZE, она описана со строки 1081
   Директива ignoreboth является сокращением для ignorespace и ignoredups.

9. {} - зарезервированные слова, список, в т.ч. список команд, в отличие от () исполнятся в текущем инстансе, используется в различных условных циклах, условных операторах, или ограничивает тело функции. Статус возврата - это статус выхода из списка.
   Описана со строки 317
10.100000 - да

   touch file{1..100000}

   300000 - нет, слишком большой объём

11. Проверяет наличие каталога /tmp
12. 
    bash is /tmp/new_path_directory/bash
    bash is /usr/local/bin/bash
    bash is /bin/bash

    $ ln -s /usr/bin /tmp/new_path_directory  
    $ PATH=/tmp/new_path_directory:${PATH}  
    $ type -a bash  
    bash is /tmp/new_path_directory/bash  
    bash is /usr/bin/bash  
    bash is /bin/bash  

13. Чем отличается планирование команд с помощью batch и at?

    at выполняется строго по расписанию
    batch выполняется, когда позволит нагрузка на систему (load average упадёт ниже 1.5 или значения, заданного командой atd)

14. vagrant suspend
    default: Saving VM state and suspending execution...

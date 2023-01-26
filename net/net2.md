
Практическая работа "Компьютерные сети.Лекция 2"

1. Проверьте список доступных сетевых интерфейсов на вашем компьютере. Какие команды есть для этого в Linux и в Windows?

LINUX
```root@sysadm-fs:/home/vagrant# ip link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:59:cb:31 brd ff:ff:ff:ff:ff:ff
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:f0:22:d4 brd ff:ff:ff:ff:ff:ff
```

```
root@home:/home/alx# ifconfig -a
br-dd966573acd1: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.18.0.1  netmask 255.255.0.0  broadcast 172.18.255.255
        ether 02:42:19:2f:fe:1b  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

docker0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        ether 02:42:59:a4:07:7f  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

enp3s0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        ether f4:b5:20:2a:44:d7  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Локальная петля (Loopback))
        RX packets 31607  bytes 30778436 (30.7 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 31607  bytes 30778436 (30.7 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

vboxnet0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.56.1  netmask 255.255.255.0  broadcast 192.168.56.255
        inet6 fe80::800:27ff:fe00:0  prefixlen 64  scopeid 0x20<link>
        ether 0a:00:27:00:00:00  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 124  bytes 19250 (19.2 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

vboxnet2: flags=4098<BROADCAST,MULTICAST>  mtu 1500
        ether 0a:00:27:00:00:02  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

vboxnet3: flags=4098<BROADCAST,MULTICAST>  mtu 1500
        ether 0a:00:27:00:00:03  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

vboxnet4: flags=4098<BROADCAST,MULTICAST>  mtu 1500
        ether 0a:00:27:00:00:04  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

vboxnet5: flags=4098<BROADCAST,MULTICAST>  mtu 1500
        ether 0a:00:27:00:00:05  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

vboxnet6: flags=4098<BROADCAST,MULTICAST>  mtu 1500
        ether 0a:00:27:00:00:06  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

vboxnet7: flags=4098<BROADCAST,MULTICAST>  mtu 1500
        ether 0a:00:27:00:00:07  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

vboxnet8: flags=4098<BROADCAST,MULTICAST>  mtu 1500
        ether 0a:00:27:00:00:08  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

wlx502b73d04460: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.59  netmask 255.255.255.0  broadcast 192.168.1.255
        inet6 fe80::8503:ec5c:a9d8:ac32  prefixlen 64  scopeid 0x20<link>
        ether 50:2b:73:d0:44:60  txqueuelen 1000  (Ethernet)
        RX packets 614723  bytes 560380615 (560.3 MB)
        RX errors 0  dropped 345  overruns 0  frame 0
        TX packets 387583  bytes 184287830 (184.2 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

root@home:/home/alx# 

```

WINDOWS
ipconfig /all
```
C:\Users\Alx88>ipconfig /all

Настройка протокола IP для Windows

   Имя компьютера  . . . . . . . . . : WS-IT-06
   Основной DNS-суффикс  . . . . . . : it-one.local.it-1.ru
   Тип узла. . . . . . . . . . . . . : Гибридный
   IP-маршрутизация включена . . . . : Нет
   WINS-прокси включен . . . . . . . : Нет
   Порядок просмотра суффиксов DNS . : it-one.local.it-1.ru

Неизвестный адаптер OpenVPN Wintun:

   Состояние среды. . . . . . . . : Среда передачи недоступна.
   DNS-суффикс подключения . . . . . :
   Описание. . . . . . . . . . . . . : Wintun Userspace Tunnel
   Физический адрес. . . . . . . . . :
   DHCP включен. . . . . . . . . . . : Нет
   Автонастройка включена. . . . . . : Да

Адаптер Ethernet Ethernet 2:

   DNS-суффикс подключения . . . . . :
   Описание. . . . . . . . . . . . . : VirtualBox Host-Only Ethernet Adapter
   Физический адрес. . . . . . . . . : 0A-00-27-00-00-0E
   DHCP включен. . . . . . . . . . . : Нет
   Автонастройка включена. . . . . . : Да
   Локальный IPv6-адрес канала . . . : fe80::89c:4097:95b6:9723%14(Основной) 
   IPv4-адрес. . . . . . . . . . . . : 192.168.56.1(Основной)
   Маска подсети . . . . . . . . . . : 255.255.255.0
   Основной шлюз. . . . . . . . . :
   IAID DHCPv6 . . . . . . . . . . . : 487194663
   DUID клиента DHCPv6 . . . . . . . : 00-01-00-01-2A-D1-E1-46-8C-89-A5-A5-00-15
   DNS-серверы. . . . . . . . . . . : fec0:0:0:ffff::1%1 
                                       fec0:0:0:ffff::2%1
                                       fec0:0:0:ffff::3%1
   NetBios через TCP/IP. . . . . . . . : Включен

Неизвестный адаптер OpenVPN TAP-Windows6:

   Состояние среды. . . . . . . . : Среда передачи недоступна.
   DNS-суффикс подключения . . . . . :
   Описание. . . . . . . . . . . . . : TAP-Windows Adapter V9 
   Физический адрес. . . . . . . . . : 00-FF-A2-31-91-FA      
   DHCP включен. . . . . . . . . . . : Да
   Автонастройка включена. . . . . . : Да

Адаптер Ethernet Ethernet:

   DNS-суффикс подключения . . . . . : it-one.local.it-1.ru
   Описание. . . . . . . . . . . . . : Realtek PCIe FE Family Controller
   Физический адрес. . . . . . . . . : 8C-89-A5-A5-00-15
   DHCP включен. . . . . . . . . . . : Да
   Автонастройка включена. . . . . . : Да
   Локальный IPv6-адрес канала . . . : fe80::8cb7:225c:4584:8641%9(Основной) 
   IPv4-адрес. . . . . . . . . . . . : 192.168.55.73(Основной)
   Маска подсети . . . . . . . . . . : 255.255.255.0
   Аренда получена. . . . . . . . . . : 23 января 2023 г. 9:29:12
   Срок аренды истекает. . . . . . . . . . : 4 марта 2159 г. 19:25:43
   Основной шлюз. . . . . . . . . : 192.168.55.37
   DHCP-сервер. . . . . . . . . . . : 192.168.55.113
   IAID DHCPv6 . . . . . . . . . . . : 109873573
   DUID клиента DHCPv6 . . . . . . . : 00-01-00-01-2A-D1-E1-46-8C-89-A5-A5-00-15
   DNS-серверы. . . . . . . . . . . : 192.168.55.113
                                       192.168.56.113
   NetBios через TCP/IP. . . . . . . . : Включен
```

netstat

```
C:\Users\Alx88>netstat

Активные подключения

  Имя    Локальный адрес        Внешний адрес          Состояние
  TCP    192.168.55.73:50261    relay-aad2e4c0:http    ESTABLISHED
  TCP    192.168.55.73:50266    188.227.72.15:44444    ESTABLISHED
  TCP    192.168.55.73:50277    20.54.37.73:https      ESTABLISHED
  TCP    192.168.55.73:60483    KAVSRV:microsoft-ds    ESTABLISHED
  TCP    192.168.55.73:60484    Serfiles:microsoft-ds  ESTABLISHED
  TCP    192.168.55.73:60508    104.17.106.184:https   ESTABLISHED
  TCP    192.168.55.73:60562    104.17.106.184:https   ESTABLISHED
  TCP    192.168.55.73:60571    lm-in-f188:5228        ESTABLISHED
  TCP    192.168.55.73:60590    static:7200            ESTABLISHED
  TCP    192.168.55.73:60591    lm-in-f95:https        ESTABLISHED
  TCP    192.168.55.73:60954    149.154.167.41:https   ESTABLISHED
```
2. Какой протокол используется для распознавания соседа по сетевому интерфейсу? Какой пакет и команды есть в Linux для этого?

Протокол LLDP.
Пакет lldpd.
Команда lldpctl.

3. Какая технология используется для разделения L2 коммутатора на несколько виртуальных сетей? Какой пакет и команды есть в Linux для этого? Приведите пример конфига.

Технология называется VLAN (Virtual LAN).
Пакет в Ubuntu Linux - vlan
Пример конфига:
```
network:
  version: 2
  renderer: networkd
  ethernets:
    ens4:
      optional: yes
      addresses: 
        - 192.168.0.2/24
  vlans:
    vlan88:
      id: 88
      link: ens4 
      addresses:
        - 192.168.1.2/24
```
4. Какие типы агрегации интерфейсов есть в Linux? Какие опции есть для балансировки нагрузки? Приведите пример конфига.
В Linux есть две технологии агрегации (LAG): bonding и teaming.

Типы агрегации bonding:

```
root@sysadm-fs:/home/vagrant# modinfo bonding | grep mode:
parm:           mode:Mode of operation; 0 for balance-rr, 1 for active-backup, 2 for balance-xor, 3 for broadcast, 4 for 802.3ad, 5 for balance-tlb, 6 for balance-alb (charp)
```
`active-backup` и `broadcast` обеспечивают только отказоустойчивость
`balance-tlb`, `balance-alb`, `balance-rr`, `balance-xor` и `802.3ad` обеспечат отказоустойчивость и балансировку

`balance-rr` - Политика round-robin. Пакеты отправляются последовательно, начиная с первого доступного интерфейса и заканчивая последним. Эта политика применяется для балансировки нагрузки и отказоустойчивости.
`active-backup` - Политика активный-резервный. Только один сетевой интерфейс из объединённых будет активным. Другой интерфейс может стать активным, только в том случае, когда упадёт текущий активный интерфейс. Эта политика применяется для отказоустойчивости.
`balance-xor` - Политика XOR. Передача распределяется между сетевыми картами используя формулу: [( «MAC адрес источника» XOR «MAC адрес назначения») по модулю «число интерфейсов»]. Получается одна и та же сетевая карта передаёт пакеты одним и тем же получателям. Политика XOR применяется для балансировки нагрузки и отказоустойчивости.
`broadcast` - Широковещательная политика. Передает всё на все сетевые интерфейсы. Эта политика применяется для отказоустойчивости.
`802.3ad` - Политика агрегирования каналов по стандарту IEEE 802.3ad. Создаются агрегированные группы сетевых карт с одинаковой скоростью и дуплексом. При таком объединении передача задействует все каналы в активной агрегации, согласно стандарту IEEE 802.3ad. Выбор через какой интерфейс отправлять пакет определяется политикой по умолчанию XOR политика.
`balance-tlb` - Политика адаптивной балансировки нагрузки передачи. Исходящий трафик распределяется в зависимости от загруженности каждой сетевой карты (определяется скоростью загрузки). Не требует дополнительной настройки на коммутаторе. Входящий трафик приходит на текущую сетевую карту. Если она выходит из строя, то другая сетевая карта берёт себе MAC адрес вышедшей из строя карты.
`balance-alb` - Политика адаптивной балансировки нагрузки. Включает в себя политику balance-tlb плюс осуществляет балансировку входящего трафика. Не требует дополнительной настройки на коммутаторе. Балансировка входящего трафика достигается путём ARP переговоров.

`active-backup` на отказоустойчивость:
```
 network:
   version: 2
   renderer: networkd
   ethernets:
     ens3:
       dhcp4: no 
       optional: true
     ens5: 
       dhcp4: no 
       optional: true
   bonds:
     bond0: 
       dhcp4: yes 
       interfaces:
         - ens3
         - ens5
       parameters:
         mode: active-backup
         primary: ens3
         mii-monitor-interval: 2
```
`balance-alb` - балансировка:
```
   bonds:
     bond0: 
       dhcp4: yes 
       interfaces:
         - ens3
         - ens5
       parameters:
         mode: balance-alb
         mii-monitor-interval: 2
```

5. Сколько IP адресов в сети с маской /29 ? Сколько /29 подсетей можно получить из сети с маской /24. Приведите несколько примеров /29 подсетей внутри сети 10.10.10.0/24.
```
root@sysadm-fs:/home/vagrant#  ipcalc -b 10.10.10.0/29
Address:   10.10.10.0           
Netmask:   255.255.255.248 = 29 
Wildcard:  0.0.0.7              
=>
Network:   10.10.10.0/29        
HostMin:   10.10.10.1           
HostMax:   10.10.10.6           
Broadcast: 10.10.10.7           
Hosts/Net: 6                     Class A, Private Internet
```


6. Задача: вас попросили организовать стык между 2-мя организациями. Диапазоны 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 уже заняты. Из какой подсети допустимо взять частные IP адреса? Маску выберите из расчета максимум 40-50 хостов внутри подсети.
```
root@sysadm-fs:/home/vagrant# ipcalc -b 100.64.0.0/10 -s 50
Address:   100.64.0.0           
Netmask:   255.192.0.0 = 10     
Wildcard:  0.63.255.255         
=>
Network:   100.64.0.0/10        
HostMin:   100.64.0.1           
HostMax:   100.127.255.254      
Broadcast: 100.127.255.255      
Hosts/Net: 4194302               Class A

1. Requested size: 50 hosts
Netmask:   255.255.255.192 = 26 
Network:   100.64.0.0/26        
HostMin:   100.64.0.1           
HostMax:   100.64.0.62          
Broadcast: 100.64.0.63          
Hosts/Net: 62                    Class A

Needed size:  64 addresses.
Used network: 100.64.0.0/26
Unused:
100.64.0.64/26
100.64.0.128/25
100.64.1.0/24
100.64.2.0/23
100.64.4.0/22
100.64.8.0/21
100.64.16.0/20
100.64.32.0/19
100.64.64.0/18
100.64.128.0/17
100.65.0.0/16
100.66.0.0/15
100.68.0.0/14
100.72.0.0/13
100.80.0.0/12
100.96.0.0/11

```


7. Как проверить ARP таблицу в Linux, Windows? Как очистить ARP кеш полностью? Как из ARP таблицы удалить только один нужный IP?

Проверить таблицу можно так:

Linux: `ip neigh, arp -n`
Windows: `arp -a`

Очистить кеш так:

Linux: `ip neigh flush`
Windows: `arp -d *`

Удалить один IP так:

Linux: `ip neigh delete <IP> dev <INTERFACE>, arp -d <IP>`
Windows: `arp -d <IP>`

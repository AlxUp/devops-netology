Практическая работа "Компьютерные сети, лекция 3"

1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP
```
telnet route-views.routeviews.org
Username: rviews
show ip route x.x.x.x/32
show bgp x.x.x.x/32
```
```
root@sysadm-fs:/home/vagrant# telnet route-views.routeviews.org
Trying 128.223.51.103...
Connected to route-views.routeviews.org.
Escape character is '^]'.
C
**********************************************************************

                    RouteViews BGP Route Viewer
                    route-views.routeviews.org

 route views data is archived on http://archive.routeviews.org

 This hardware is part of a grant by the NSF.
 Please contact help@routeviews.org if you have questions, or
 if you wish to contribute your view.

 This router has views of full routing tables from several ASes.
 The list of peers is located at http://www.routeviews.org/peers
 in route-views.oregon-ix.net.txt

 NOTE: The hardware was upgraded in August 2014.  If you are seeing
 the error message, "no default Kerberos realm", you may want to
 in Mac OS X add "default unset autologin" to your ~/.telnetrc

 To login, use the username "rviews".

 **********************************************************************

User Access Verification

Username: rviews
route-views>show ip route 91.xxx.xx.52
Routing entry for 91.xxx.xx.0/24
  Known via "bgp 6447", distance 20, metric 0
  Tag 6939, type external
  Last update from 64.71.137.241 4d09h ago
  Routing Descriptor Blocks:
  * 64.71.137.241, from 64.71.137.241, 4d09h ago
      Route metric is 0, traffic share count is 1
      AS Hops 2
      Route tag 6939
      MPLS label: none
route-views>show bgp 91.xxx.xx.52
BGP routing table entry for 91.xxx.xx.0/24, version 2663077116
Paths: (4 available, best #3, table default)
  Not advertised to any peer
  Refresh Epoch 1
  1351 6939 42065, (aggregated by 65500 185.26.72.2)
    132.198.255.253 from 132.198.255.253 (132.198.255.253)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      path 7FE17CF3AD68 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3303 6939 42065, (aggregated by 65500 185.26.72.2)
    217.192.89.50 from 217.192.89.50 (138.187.128.158)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      Community: 3303:1006 3303:1021 3303:1030 3303:3067 6939:7337 6939:8752 6939:9002
      path 7FE038996BE8 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  6939 42065, (aggregated by 65500 185.26.72.2)
    64.71.137.241 from 64.71.137.241 (216.218.252.164)
      Origin IGP, localpref 100, valid, external, atomic-aggregate, best
      path 7FE1680FEB90 RPKI State valid
      rx pathid: 0, tx pathid: 0x0
  Refresh Epoch 1
  20130 6939 42065, (aggregated by 65500 185.26.72.2)
    140.192.8.16 from 140.192.8.16 (140.192.8.16)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      path 7FE038233B18 RPKI State valid
      rx pathid: 0, tx pathid: 0
```

2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.
```
root@sysadm-fs:/home/vagrant# ip link add dummy0 type dummy
root@sysadm-fs:/home/vagrant# ip addr add 10.0.10.1/24 dev dummy0
root@sysadm-fs:/home/vagrant# ip link set dummy0 up
root@sysadm-fs:/home/vagrant# ip route add to 10.10.0.0/16 via 10.0.10.1
root@sysadm-fs:/home/vagrant# ip route add to 10.12.0.0/16 via 10.0.10.1
root@sysadm-fs:/home/vagrant# ip route
default via 10.0.2.2 dev eth0 proto dhcp src 10.0.2.15 metric 100 
10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15 
10.0.2.2 dev eth0 proto dhcp scope link src 10.0.2.15 metric 100 
10.0.10.0/24 dev dummy0 proto kernel scope link src 10.0.10.1 
10.10.0.0/16 via 10.0.10.1 dev dummy0 
10.12.0.0/16 via 10.0.10.1 dev dummy0 
172.17.0.0/16 dev docker0 proto kernel scope link src 172.17.0.1 linkdown 
192.168.56.0/24 dev eth1 proto kernel scope link src 192.168.56.1 
root@sysadm-fs:/home/vagrant# 
```
3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.
```
root@home:/home/alx/vagrant# netstat -ntlp | grep LISTEN
tcp        0      0 127.0.0.1:6379          0.0.0.0:*               LISTEN      1239/redis-server 1 
tcp        0      0 0.0.0.0:7070            0.0.0.0:*               LISTEN      1243/anydesk        
tcp        0      0 127.0.0.1:5433          0.0.0.0:*               LISTEN      1344/postgres       
tcp        0      0 127.0.0.1:5432          0.0.0.0:*               LISTEN      1364/postgres       
tcp        0      0 127.0.0.1:5905          0.0.0.0:*               LISTEN      21282/VBoxHeadless  
tcp        0      0 127.0.0.54:53           0.0.0.0:*               LISTEN      954/systemd-resolve 
tcp        0      0 0.0.0.0:445             0.0.0.0:*               LISTEN      1843/smbd           
tcp        0      0 127.0.0.1:2222          0.0.0.0:*               LISTEN      21282/VBoxHeadless  
tcp        0      0 0.0.0.0:139             0.0.0.0:*               LISTEN      1843/smbd           
tcp        0      0 127.0.0.1:3306          0.0.0.0:*               LISTEN      1457/mysqld         
tcp        0      0 127.0.0.1:33060         0.0.0.0:*               LISTEN      1457/mysqld         
tcp        0      0 127.0.0.1:631           0.0.0.0:*               LISTEN      1226/cupsd          
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      954/systemd-resolve 
tcp6       0      0 :::4369                 :::*                    LISTEN      1/init              
tcp6       0      0 :::5900                 :::*                    LISTEN      21282/VBoxHeadless  
tcp6       0      0 :::6600                 :::*                    LISTEN      1/init              
tcp6       0      0 ::1:631                 :::*                    LISTEN      1226/cupsd          
tcp6       0      0 :::8080                 :::*                    LISTEN      1228/java           
tcp6       0      0 :::445                  :::*                    LISTEN      1843/smbd           
tcp6       0      0 :::22                   :::*                    LISTEN      1/init              
tcp6       0      0 :::139                  :::*                    LISTEN      1843/smbd           
tcp6       0      0 :::9100                 :::*                    LISTEN      1231/node_exporter  
tcp6       0      0 :::9090                 :::*                    LISTEN      1235/prometheus     
tcp6       0      0 ::1:6379                :::*                    LISTEN      1239/redis-server 1 
```
53 порт TCP использует systemd
7070 порт TCP использует anydesk
2222 порт TCP используетVBox

4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?
```
root@home:/home/alx/.git/devops-netology/net# ss -lupn
State           Recv-Q          Send-Q                    Local Address:Port                     Peer Address:Port          Process                                                                                
UNCONN          0               0                               0.0.0.0:44444                         0.0.0.0:*              users:(("sudo",pid=2764,fd=7),("sudo",pid=2513,fd=7),("asts",pid=1847,fd=7))          
UNCONN          0               0                               0.0.0.0:5353                          0.0.0.0:*              users:(("avahi-daemon",pid=1063,fd=12))                                               
UNCONN          0               0                               0.0.0.0:48577                         0.0.0.0:*              users:(("sudo",pid=2764,fd=9),("sudo",pid=2513,fd=9),("asts",pid=1847,fd=9))          
UNCONN          0               0                            127.0.0.54:53                            0.0.0.0:*              users:(("systemd-resolve",pid=954,fd=15))                                             
UNCONN          0               0                         127.0.0.53%lo:53                            0.0.0.0:*              users:(("systemd-resolve",pid=954,fd=13))                                             
UNCONN          0               0                        192.168.56.255:137                           0.0.0.0:*              users:(("nmbd",pid=1768,fd=29))                                                       
UNCONN          0               0                          192.168.56.1:137                           0.0.0.0:*              users:(("nmbd",pid=1768,fd=28))                                                       
UNCONN          0               0                        172.18.255.255:137                           0.0.0.0:*              users:(("nmbd",pid=1768,fd=25))                                                       
UNCONN          0               0                            172.18.0.1:137                           0.0.0.0:*              users:(("nmbd",pid=1768,fd=24))                                                       
UNCONN          0               0                        172.17.255.255:137                           0.0.0.0:*              users:(("nmbd",pid=1768,fd=21))                                                       
UNCONN          0               0                            172.17.0.1:137                           0.0.0.0:*              users:(("nmbd",pid=1768,fd=20))                                                       
UNCONN          0               0                         192.168.1.255:137                           0.0.0.0:*              users:(("nmbd",pid=1768,fd=16))                                                       
UNCONN          0               0                          192.168.1.59:137                           0.0.0.0:*              users:(("nmbd",pid=1768,fd=15))                                                       
UNCONN          0               0                               0.0.0.0:137                           0.0.0.0:*              users:(("nmbd",pid=1768,fd=13))                                                       
UNCONN          0               0                        192.168.56.255:138                           0.0.0.0:*              users:(("nmbd",pid=1768,fd=31))                                                       
UNCONN          0               0                          192.168.56.1:138                           0.0.0.0:*              users:(("nmbd",pid=1768,fd=30))                                                       
UNCONN          0               0                        172.18.255.255:138                           0.0.0.0:*              users:(("nmbd",pid=1768,fd=27))                                                       
UNCONN          0               0                            172.18.0.1:138                           0.0.0.0:*              users:(("nmbd",pid=1768,fd=26))                                                       
UNCONN          0               0                        172.17.255.255:138                           0.0.0.0:*              users:(("nmbd",pid=1768,fd=23))                                                       
UNCONN          0               0                            172.17.0.1:138                           0.0.0.0:*              users:(("nmbd",pid=1768,fd=22))                                                       
UNCONN          0               0                         192.168.1.255:138                           0.0.0.0:*              users:(("nmbd",pid=1768,fd=18))                                                       
UNCONN          0               0                          192.168.1.59:138                           0.0.0.0:*              users:(("nmbd",pid=1768,fd=17))                                                       
UNCONN          0               0                               0.0.0.0:138                           0.0.0.0:*              users:(("nmbd",pid=1768,fd=14))                                                       
UNCONN          0               0                               0.0.0.0:41173                         0.0.0.0:*              users:(("avahi-daemon",pid=1063,fd=14))                                               
UNCONN          0               0                               0.0.0.0:631                           0.0.0.0:*              users:(("cups-browsed",pid=1748,fd=7))                                                
UNCONN          0               0                               0.0.0.0:50001                         0.0.0.0:*              users:(("anydesk",pid=1243,fd=46))                                                    
UNCONN          0               0                                  [::]:44154                            [::]:*              users:(("avahi-daemon",pid=1063,fd=15))                                               
UNCONN          0               0                                  [::]:5353                             [::]:*              users:(("avahi-daemon",pid=1063,fd=13))
```

50001 порт UDP использует anydesk

5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.
![screenshot]()

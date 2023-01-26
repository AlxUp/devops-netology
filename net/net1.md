Практическая работа "Компьютерные сети. Лекция 1".

Задание
1. Работа c HTTP через телнет.
Подключитесь утилитой телнет к сайту stackoverflow.com `telnet stackoverflow.com 80`
Отправьте HTTP запрос
```
GET /questions HTTP/1.0
HOST: stackoverflow.com
[press enter]
[press enter]
```
В ответе укажите полученный HTTP код, что он означает?
```
root@home:/home/alx# telnet stackoverflow.com 80
Trying 151.101.65.69...
Connected to stackoverflow.com.
Escape character is '^]'.
GET /questions HTTP/1.0
HOST: stackoverflow.com

HTTP/1.1 403 Forbidden
Connection: close
Content-Length: 1917
Server: Varnish
Retry-After: 0
Content-Type: text/html
Accept-Ranges: bytes
Date: Thu, 26 Jan 2023 08:20:38 GMT
Via: 1.1 varnish
X-Served-By: cache-ams21049-AMS
X-Cache: MISS
X-Cache-Hits: 0
X-Timer: S1674721239.869454,VS0,VE1
X-DNS-Prefetch-Control: off

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Forbidden - Stack Exchange</title>
    <style type="text/css">
		body
		{
			color: #333;
			font-family: 'Helvetica Neue', Arial, sans-serif;
			font-size: 14px;
			background: #fff url('img/bg-noise.png') repeat left top;
			line-height: 1.4;
		}
		h1
		{
			font-size: 170%;
			line-height: 34px;
			font-weight: normal;
		}
		a { color: #366fb3; }
		a:visited { color: #12457c; }
		.wrapper {
			width:960px;
			margin: 100px auto;
			text-align:left;
		}
		.msg {
			float: left;
			width: 700px;
			padding-top: 18px;
			margin-left: 18px;
		}
    </style>
</head>
<body>
    <div class="wrapper">
		<div style="float: left;">
			<img src="https://cdn.sstatic.net/stackexchange/img/apple-touch-icon.png" alt="Stack Exchange" />
		</div>
		<div class="msg">
			<h1>Access Denied</h1>
                        <p>This IP address (91.108.29.52) has been blocked from access to our services. If you believe this to be in error, please contact us at <a href="mailto:team@stackexchange.com?Subject=Blocked%2091.108.29.52%20(Request%20ID%3A%203094193442-AMS)">team@stackexchange.com</a>.</p>
                        <p>When contacting us, please include the following information in the email:</p>
                        <p>Method: block</p>
                        <p>XID: 3094193442-AMS</p>
                        <p>IP: 91.108.29.52</p>
                        <p>X-Forwarded-For: </p>
                        <p>User-Agent: </p>
                        
                        <p>Time: Thu, 26 Jan 2023 08:20:38 GMT</p>
                        <p>URL: stackoverflow.com/questions</p>
                        <p>Browser Location: <span id="jslocation">(not loaded)</span></p>
		</div>
	</div>
	<script>document.getElementById('jslocation').innerHTML = window.location.href;</script>
</body>
</html>Connection closed by foreign host.
root@home:/home/alx#
```
В ответ получил код 403. HTTP 403 Forbidden — стандартный код ответа HTTP, означающий, что доступ к запрошенному ресурсу запрещен. Сервер понял запрос, но не выполнит его.

2. Повторите задание 1 в браузере, используя консоль разработчика F12.

 -откройте вкладку Network
 -отправьте запрос http://stackoverflow.com
 -найдите первый ответ HTTP сервера, откройте вкладку Headers
 -укажите в ответе полученный HTTP код
 -проверьте время загрузки страницы, какой запрос обрабатывался дольше всего?
 -приложите скриншот консоли браузера в ответ.
В ответ получил код 200. Успешный запрос.
Страница полностью загрузилась за 2.56 сек. Самый долгий запрос - начальная загрузка страницы 550 мс

   ![screenshot](https://github.com/AlxUp/devops-netology/blob/master/net/net1.png) 


3. Какой IP адрес у вас в интернете?
```
root@home:/home/alx# dig @resolver4.opendns.com myip.opendns.com +short
91.108.29.52
```
4. Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой whois
```
root@home:/home/alx# whois 91.108.29.52 | grep ^descr
descr:          eTelecom_Customers_NAT_Network

```
eTelecom_Customers_NAT_Network

```
root@home:/home/alx# whois 91.108.29.52 | grep ^origin
origin:         AS42065
```
AS - AS42065

5. Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой traceroute
```
root@home:/home/alx# traceroute -An 8.8.8.8
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  192.168.1.1 [*]  0.824 ms  1.308 ms  1.550 ms
 2  10.216.3.254 [*]  3.311 ms  3.447 ms  3.425 ms
 3  * * *
 4  10.210.116.25 [*]  3.502 ms  3.483 ms  3.619 ms
 5  10.210.116.26 [*]  3.911 ms  4.300 ms  4.280 ms
 6  10.210.116.18 [*]  4.679 ms  2.575 ms  3.065 ms
 7  72.14.220.116 [AS15169]  3.721 ms  3.698 ms  3.302 ms
 8  * * *
 9  209.85.245.238 [AS15169]  3.836 ms 74.125.244.129 [AS15169]  5.497 ms  5.881 ms
10  74.125.244.133 [AS15169]  4.912 ms 74.125.244.181 [AS15169]  4.894 ms 74.125.244.180 [AS15169]  4.875 ms
11  72.14.232.85 [AS15169]  5.015 ms 142.251.51.187 [AS15169]  8.433 ms 72.14.232.85 [AS15169]  5.731 ms
12  142.251.51.187 [AS15169]  8.359 ms  7.759 ms 142.251.61.221 [AS15169]  8.130 ms
13  142.250.208.25 [AS15169]  10.446 ms 142.250.210.103 [AS15169]  9.196 ms 142.250.208.25 [AS15169]  8.676 ms
14  * * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * 8.8.8.8 [AS15169/AS263411]  7.475 ms
root@home:/home/alx# 

```
Пакет проходит через AS - AS15169/AS263411

6. Повторите задание 5 в утилите mtr. На каком участке наибольшая задержка - delay?
```
root@home:/home/alx# mtr 8.8.8.8 -znrc 1
Start: 2023-01-26T11:50:43+0300
HOST: home                        Loss%   Snt   Last   Avg  Best  Wrst StDev
  1. AS???    192.168.1.1          0.0%     1    1.3   1.3   1.3   1.3   0.0
  2. AS???    10.216.3.254         0.0%     1    2.3   2.3   2.3   2.3   0.0
  3. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
  4. AS???    10.210.116.25        0.0%     1    1.9   1.9   1.9   1.9   0.0
  5. AS???    10.210.116.26        0.0%     1    2.6   2.6   2.6   2.6   0.0
  6. AS???    10.210.116.18        0.0%     1    2.8   2.8   2.8   2.8   0.0
  7. AS15169  72.14.220.116        0.0%     1    2.9   2.9   2.9   2.9   0.0
  8. AS15169  172.253.76.91        0.0%     1    3.3   3.3   3.3   3.3   0.0
  9. AS15169  74.125.244.180       0.0%     1    3.2   3.2   3.2   3.2   0.0
 10. AS15169  216.239.48.163       0.0%     1    6.8   6.8   6.8   6.8   0.0
 11. AS15169  142.250.210.45       0.0%     1    7.2   7.2   7.2   7.2   0.0
 12. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 13. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 14. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 15. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 16. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 17. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 18. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 19. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 20. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 21. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 22. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 23. AS15169  8.8.8.8              0.0%     1    6.5   6.5   6.5   6.5   0.0
root@home:/home/alx# 
```
Наибольшая задержка в 11 строке

7. Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? Воспользуйтесь утилитой dig
```
root@home:/home/alx# dig +short NS dns.google
ns3.zdns.google.
ns2.zdns.google.
ns4.zdns.google.
ns1.zdns.google.
```
NS
```
root@home:/home/alx# dig +short A dns.google
8.8.8.8
8.8.4.4
root@home:/home/alx# 
```
A записи
8. Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? Воспользуйтесь утилитой dig

```
root@home:/home/alx# for ip in `dig +short A dns.google`; do dig -x $ip | grep ^[0-9].*in-addr; done
8.8.8.8.in-addr.arpa.	20145	IN	PTR	dns.google.
4.4.8.8.in-addr.arpa.	14509	IN	PTR	dns.google.
root@home:/home/alx#
```
dns.google


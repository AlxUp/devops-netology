Практическая работа "Элементы безопасности информационных систем".

1. Установите Bitwarden плагин для браузера. Зарегестрируйтесь и сохраните несколько паролей.
![screenshot](https://github.com/AlxUp/devops-netology/blob/master/security/sec1.png)
2. Установите Google authenticator на мобильный телефон. Настройте вход в Bitwarden акаунт через Google authenticator OTP.
![screenshot](https://github.com/AlxUp/devops-netology/blob/master/security/sec2.png)
![screenshot](https://github.com/AlxUp/devops-netology/blob/master/security/sec3.jpg)

3. Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.
![screenshot](https://github.com/AlxUp/devops-netology/blob/master/security/apache2.png)

```
root@home:/home/alx# a2enmod ssl
Considering dependency setenvif for ssl:
Module setenvif already enabled
Considering dependency mime for ssl:
Module mime already enabled
Considering dependency socache_shmcb for ssl:
Enabling module socache_shmcb.
Enabling module ssl.
See /usr/share/doc/apache2/README.Debian.gz on how to configure SSL and create self-signed certificates.
To activate the new configuration, you need to run:
  systemctl restart apache2
root@home:/home/alx# systemctl restart apache2
root@home:/home/alx# ufw allow "Apache"
Правила обновлены
Правила обновлены (v6)
root@home:/home/alx# sudo openssl req -x509 -nodes -days 3650 -newkey rsa:4096 -keyout /etc/ssl/private/test.key -out /etc/ssl/certs/test.cert -subj "/C=RU/ST=LO/L=SPB/O=example/OU=COM/CN=www.example.com"

```
```
root@home:/home/alx# nano /etc/apache2/sites-available/www.example.com.conf

<VirtualHost *:443>
ServerName example.com
DocumentRoot /var/www/example.com
SSLEngine on
SSLCertificateFile /etc/ssl/certs/test.cert
SSLCertificateKeyFile /etc/ssl/private/test.key
</VirtualHost>

```
```
root@home:/home/alx# mkdir /var/www/example.com
root@home:/home/alx# nano /var/www/example.com/index.html

<h1>Netology homework test site</h1>

root@home:/home/alx# a2ensite www.example.com

```

![screenshot](https://github.com/AlxUp/devops-netology/blob/master/security/site.png)


4. Проверьте на TLS уязвимости произвольный сайт в интернете (кроме сайтов МВД, ФСБ, МинОбр, НацБанк, РосКосмос, РосАтом, РосНАНО и любых госкомпаний, объектов КИИ, ВПК ... и тому подобное).
```
git clone --depth 1 https://github.com/drwetter/testssl.sh.git
```
```
root@home:/home/alx/testssl.sh# ./testssl.sh -U --sneaky https://www.ruchoco.ru

###########################################################
    testssl.sh       3.2rc2 from https://testssl.sh/dev/
    (8099dc0 2023-01-17 14:27:01)

      This program is free software. Distribution and
             modification under GPLv2 permitted.
      USAGE w/o ANY WARRANTY. USE IT AT YOUR OWN RISK!

       Please file bugs @ https://testssl.sh/bugs/

###########################################################

 Using "OpenSSL 1.0.2-bad (1.0.2k-dev)" [~179 ciphers]
 on home:./bin/openssl.Linux.x86_64
 (built: "Sep  1 14:03:44 2022", platform: "linux-x86_64")


 Start 2023-01-30 17:21:30        -->> 185.65.148.69:443 (www.ruchoco.ru) <<--

 rDNS (185.65.148.69):   --
 Service detected:       HTTP


 Testing vulnerabilities 

 Heartbleed (CVE-2014-0160)                not vulnerable (OK), no heartbeat extension
 CCS (CVE-2014-0224)                       not vulnerable (OK)
 Ticketbleed (CVE-2016-9244), experiment.  not vulnerable (OK)
 ROBOT                                     not vulnerable (OK)
 Secure Renegotiation (RFC 5746)           supported (OK)
 Secure Client-Initiated Renegotiation     not vulnerable (OK)
 CRIME, TLS (CVE-2012-4929)                not vulnerable (OK)
 BREACH (CVE-2013-3587)                    potentially NOT ok, "gzip" HTTP compression detected. - only supplied "/" tested
                                           Can be ignored for static pages or if no secrets in the page
 POODLE, SSL (CVE-2014-3566)               not vulnerable (OK)
 TLS_FALLBACK_SCSV (RFC 7507)              Downgrade attack prevention supported (OK)
 SWEET32 (CVE-2016-2183, CVE-2016-6329)    VULNERABLE, uses 64 bit block ciphers
 FREAK (CVE-2015-0204)                     not vulnerable (OK)
 DROWN (CVE-2016-0800, CVE-2016-0703)      not vulnerable on this host and port (OK)
                                           make sure you don't use this certificate elsewhere with SSLv2 enabled services, see
                                           https://search.censys.io/search?resource=hosts&virtual_hosts=INCLUDE&q=728F94C1B5EA0711D0311BAD7D79AA7C63EADCC7184ACAE6BF38DA05FC4E7F03
 LOGJAM (CVE-2015-4000), experimental      not vulnerable (OK): no DH EXPORT ciphers, no DH key detected with <= TLS 1.2
 BEAST (CVE-2011-3389)                     TLS1: ECDHE-RSA-AES128-SHA AES128-SHA DES-CBC3-SHA 
                                           VULNERABLE -- but also supports higher protocols  TLSv1.1 TLSv1.2 (likely mitigated)
 LUCKY13 (CVE-2013-0169), experimental     potentially VULNERABLE, uses cipher block chaining (CBC) ciphers with TLS. Check patches
 Winshock (CVE-2014-6321), experimental    not vulnerable (OK)
 RC4 (CVE-2013-2566, CVE-2015-2808)        no RC4 ciphers detected (OK)


 Done 2023-01-30 17:22:09 [  44s] -->> 185.65.148.69:443 (www.ruchoco.ru) <<--


root@home:/home/alx/testssl.sh# 

```

5. Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.
```
$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/alx/.ssh/id_rsa): /home/alx/.ssh/test_rsa       
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/alx/.ssh/test_rsa
Your public key has been saved in /home/alx/.ssh/test_rsa.pub

root@home:~$ ssh-copy-id -i .ssh/test_rsa -p 2200 vagrant@127.0.0.1
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: ".ssh/test_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh -p '2200' 'vagrant@127.0.0.1'"
and check to make sure that only the key(s) you wanted were added.

root@home:~$ ssh -p '2200' 'vagrant@127.0.0.1'
vagrant@127.0.0.1's password: 
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-91-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Mon 30 Jan 2023 16:04:57 AM UTC

  System load:  0.0                Processes:             117
  Usage of /:   11.6% of 30.88GB   Users logged in:       0
  Memory usage: 18%                IPv4 address for eth0: 10.0.2.15
  Swap usage:   0%


This system is built by the Bento project by Chef Software
More information can be found at https://github.com/chef/bento
Last login: Mon Jan 30 17:54:32 2023 from 10.0.2.2

```

6. Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.
```
root@home:~$ mv .ssh/test_rsa .ssh/test2_rsa
root@home:~$ mv .ssh/test_rsa.pub .ssh/test2_rsa.pub
root@home:~$ nano .ssh/config
	Host vagrant2
	HostName 127.0.0.1
	IdentityFile ~/.ssh/test2_rsa
	User vagrant
	Port 2200
```
```
root@home:~$ ssh vagrant2
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-91-generic x86_64)
```

7. Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.
```
root@home:/home/alx# tcpdump -c 100 -w dump.pcap
tcpdump: listening on wlx502b73d04460, link-type EN10MB (Ethernet), snapshot length 262144 bytes
100 packets captured
117 packets received by filter
0 packets dropped by kernel
root@home:/home/alx# 
```
![screenshot](https://github.com/AlxUp/devops-netology/blob/master/security/wire.png)



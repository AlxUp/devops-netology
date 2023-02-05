Практическая работа "Файловые Системы"

1. Узнайте о sparse (разряженных) файлах.
Обычный файл заполненый нулями.
```
$ dd if=/dev/zero of=output1 bs=1G count=4
$ stat output1
File: ouput1
  Size: 4294967296      Blocks: 8388616    IO Block: 4096   regular file
```
Разреженный файл заполненный нулями

```
$ dd if=/dev/zero of=output2 bs=1G seek=0 count=0
$ stat output2
File: output2
  Size: 4294967296      Blocks: 0          IO Block: 4096   regular file
```

2. Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?

Не могут, это просто ссылки на один и тот же inode - в нём и хранятся права доступа и имя владельца.

3. Сделайте `vagrant destroy` на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим:
```
path_to_disk_folder = './disks'

host_params = {
    'disk_size' => 2560,
    'disks'=>[1, 2],
    'cpus'=>2,
    'memory'=>2048,
    'hostname'=>'sysadm-fs',
    'vm_name'=>'sysadm-fs'
}
Vagrant.configure("2") do |config|
    config.vm.box = "bento/ubuntu-20.04"
    config.vm.hostname=host_params['hostname']
    config.vm.provider :virtualbox do |v|

        v.name=host_params['vm_name']
        v.cpus=host_params['cpus']
        v.memory=host_params['memory']

        host_params['disks'].each do |disk|
            file_to_disk=path_to_disk_folder+'/disk'+disk.to_s+'.vdi'
            unless File.exist?(file_to_disk)
                v.customize ['createmedium', '--filename', file_to_disk, '--size', host_params['disk_size']]
            end
            v.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', disk.to_s, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
        end
    end
    config.vm.network "private_network", type: "dhcp"
end
```

```
root@home:/home/alx/vagrant# vagrant validate
Vagrantfile validated successfully.

```
```

vagrant@sysadm-fs:~$ lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
loop0                       7:0    0   62M  1 loop /snap/core20/1611
loop1                       7:1    0 67.8M  1 loop /snap/lxd/22753
loop2                       7:2    0   47M  1 loop /snap/snapd/16292
sda                         8:0    0   64G  0 disk 
├─sda1                      8:1    0    1M  0 part 
├─sda2                      8:2    0    2G  0 part /boot
└─sda3                      8:3    0   62G  0 part 
  └─ubuntu--vg-ubuntu--lv 253:0    0   31G  0 lvm  /
sdb                         8:16   0  2.5G  0 disk 
sdc                         8:32   0  2.5G  0 disk 
```
Данная конфигурация создаст новую виртуальную машину с двумя дополнительными неразмеченными дисками по 2.5 Гб.


4. Используя `fdisk`, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.
```
vagrant@sysadm-fs:~$ sudo fdisk /dev/sdb

Welcome to fdisk (util-linux 2.34).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0x91822698.

Command (m for help): f
f: unknown command

Command (m for help): F   

Unpartitioned space /dev/sdb: 2.51 GiB, 2683305984 bytes, 5240832 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes

Start     End Sectors  Size
 2048 5242879 5240832  2.5G

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 1
First sector (2048-5242879, default 2048): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-5242879, default 5242879): +2G

Created a new partition 1 of type 'Linux' and of size 2 GiB.

Command (m for help): n
Partition type
   p   primary (1 primary, 0 extended, 3 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (2-4, default 2): 2
First sector (4196352-5242879, default 4196352): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (4196352-5242879, default 5242879): 

Created a new partition 2 of type 'Linux' and of size 511 MiB.

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```

5. Используя `sfdisk`, перенесите данную таблицу разделов на второй диск.
```
vagrant@sysadm-fs:~$ sudo sfdisk -d /dev/sdb > sdb.dump
vagrant@sysadm-fs:~$ sudo sfdisk /dev/sdc < sdb.dump
Checking that no-one is using this disk right now ... OK

Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Created a new DOS disklabel with disk identifier 0x91822698.
/dev/sdc1: Created a new partition 1 of type 'Linux' and of size 2 GiB.
/dev/sdc2: Created a new partition 2 of type 'Linux' and of size 511 MiB.
/dev/sdc3: Done.

New situation:
Disklabel type: dos
Disk identifier: 0x91822698

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdc1          2048 4196351 4194304    2G 83 Linux
/dev/sdc2       4196352 5242879 1046528  511M 83 Linux

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```

6. Соберите `mdadm` RAID1 на паре разделов 2 Гб.
```
root@sysadm-fs:/home/vagrant# mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/sd[bc]1
mdadm: Note: this array has metadata at the start and
    may not be suitable as a boot device.  If you plan to
    store '/boot' on this device please ensure that
    your boot-loader understands md/v1.x metadata, or use
    --metadata=0.90
Continue creating array? y
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md0 started.
```
7. Соберите `mdadm` RAID0 на второй паре маленьких разделов.
```
root@sysadm-fs:/home/vagrant# mdadm --create /dev/md1 --level=0 --raid-devices=2 /dev/sd[bc]2
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md1 started.
```
8. Создайте 2 независимых PV на получившихся md-устройствах.
```
root@sysadm-fs:/home/vagrant# pvcreate /dev/md0
  Physical volume "/dev/md0" successfully created.
root@sysadm-fs:/home/vagrant# pvcreate /dev/md1
  Physical volume "/dev/md1" successfully created.
```
9. Создайте общую volume-group на этих двух PV.
```
root@sysadm-fs:/home/vagrant# vgcreate alx_netology /dev/md0 /dev/md1
  Volume group "alx_netology" successfully created
```
10. Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.
```
root@sysadm-fs:/home/vagrant# lvcreate -L 100m -n alx_netology-lv alx_netology /dev/md1
  Logical volume "alx_netology-lv" created.
root@sysadm-fs:/home/vagrant# lvs -o +devices
  LV              VG           Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert Devices     
  alx_netology-lv alx_netology -wi-a----- 100.00m                                                     /dev/md1(0) 
  ubuntu-lv       ubuntu-vg    -wi-ao---- <31.00g                                                     /dev/sda3(0)
```
11. Создайте `mkfs.ext4` ФС на получившемся LV.
```
root@sysadm-fs:/home/vagrant# mkfs.ext4 -L alx_netology-ext4 -m 1 /dev/mapper/alx_netology-alx_netology--lv
Warning: label too long; will be truncated to 'alx_netology-ext'

mke2fs 1.45.5 (07-Jan-2020)
Creating filesystem with 25600 4k blocks and 25600 inodes

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done
```
```
root@sysadm-fs:/home/vagrant# blkid | grep alx_netology--lv
/dev/mapper/alx_netology-alx_netology--lv: LABEL="alx_netology-ext" UUID="8fec55e2-f262-4bb6-8e05-8ab701ca1a8c" TYPE="ext4"
```

12. Смонтируйте этот раздел в любую директорию, например, `/tmp/new`.
```
root@sysadm-fs:/home/vagrant# mount /dev/mapper/alx_netology-alx_netology--lv /tmp/test/
root@sysadm-fs:/home/vagrant# mount | grep alx_netology--lv
/dev/mapper/alx_netology-alx_netology--lv on /tmp/test type ext4 (rw,relatime,stripe=256)
```
13. Поместите туда тестовый файл, например `wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz`.
```
root@sysadm-fs:/home/vagrant# wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/test/test.gz.
--2023-01-24 18:12:18--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 24506017 (23M) [application/octet-stream]
Saving to: ‘/tmp/test/test.gz.’

/tmp/test/test.gz.                                   100%[=====================================================================================================================>]  23.37M  5.28MB/s    in 4.9s    

2023-01-24 18:12:28 (4.74 MB/s) - ‘/tmp/test/test.gz.’ saved [24506017/24506017]

```

14. Прикрепите вывод lsblk.
```
root@sysadm-fs:/home/vagrant# lsblk
NAME                                MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
loop0                                 7:0    0   62M  1 loop  /snap/core20/1611
loop1                                 7:1    0 67.8M  1 loop  /snap/lxd/22753
loop3                                 7:3    0 49.8M  1 loop  /snap/snapd/17950
loop4                                 7:4    0 63.3M  1 loop  /snap/core20/1778
loop5                                 7:5    0 91.9M  1 loop  /snap/lxd/24061
sda                                   8:0    0   64G  0 disk  
├─sda1                                8:1    0    1M  0 part  
├─sda2                                8:2    0    2G  0 part  /boot
└─sda3                                8:3    0   62G  0 part  
  └─ubuntu--vg-ubuntu--lv           253:0    0   31G  0 lvm   /
sdb                                   8:16   0  2.5G  0 disk  
├─sdb1                                8:17   0    2G  0 part  
│ └─md0                               9:0    0    2G  0 raid1 
└─sdb2                                8:18   0  511M  0 part  
  └─md1                               9:1    0 1018M  0 raid0 
    └─alx_netology-alx_netology--lv 253:1    0  100M  0 lvm   /tmp/test
sdc                                   8:32   0  2.5G  0 disk  
├─sdc1                                8:33   0    2G  0 part  
│ └─md0                               9:0    0    2G  0 raid1 
└─sdc2                                8:34   0  511M  0 part  
  └─md1                               9:1    0 1018M  0 raid0 
    └─alx_netology-alx_netology--lv 253:1    0  100M  0 lvm   /tmp/test
```
15. Протестируйте целостность файла:

```
root@vagrant:~# gzip -t /tmp/new/test.gz
root@vagrant:~# echo $?
0
```
16. Используя pvmove, переместите содержимое PV с RAID0 на RAID1.

17. Сделайте `--fail` на устройство в вашем RAID1 md.

18. Подтвердите выводом `dmesg`, что RAID1 работает в деградированном состоянии.

19. Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:

```
root@vagrant:~# gzip -t /tmp/new/test.gz
root@vagrant:~# echo $?
0
```
```
root@sysadm-fs:/tmp/test# gzip -t /tmp/test/test.gz.
root@sysadm-fs:/tmp/test# echo $?
0
```

20. Погасите тестовый хост, vagrant destroy.
```
root@sysadm-fs:~# exit
exit
vagrant@sysadm-fs:~$ exit
logout
root@home:/home/alx/vagrant# vagrant destroy
    default: Are you sure you want to destroy the 'default' VM? [y/N] y
==> default: You assigned a static IP ending in ".1" to this machine.
==> default: This is very often used by the router and can cause the
==> default: network to not work properly. If the network doesn't work
==> default: properly, try changing this IP.
==> default: Forcing shutdown of VM...
==> default: Destroying VM and associated drives...
```


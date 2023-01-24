Практическая работа "Файловые Системы"

1. Узнайте о sparse (разряженных) файлах.

2. Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?

3. Сделайте vagrant destroy на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим:

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
Данная конфигурация создаст новую виртуальную машину с двумя дополнительными неразмеченными дисками по 2.5 Гб.

Используя fdisk, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.

Используя sfdisk, перенесите данную таблицу разделов на второй диск.

Соберите mdadm RAID1 на паре разделов 2 Гб.

Соберите mdadm RAID0 на второй паре маленьких разделов.

Создайте 2 независимых PV на получившихся md-устройствах.

Создайте общую volume-group на этих двух PV.

Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.

Создайте mkfs.ext4 ФС на получившемся LV.

Смонтируйте этот раздел в любую директорию, например, /tmp/new.

Поместите туда тестовый файл, например wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz.

Прикрепите вывод lsblk.

Протестируйте целостность файла:

root@vagrant:~# gzip -t /tmp/new/test.gz
root@vagrant:~# echo $?
0
Используя pvmove, переместите содержимое PV с RAID0 на RAID1.

Сделайте --fail на устройство в вашем RAID1 md.

Подтвердите выводом dmesg, что RAID1 работает в деградированном состоянии.

Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:

root@vagrant:~# gzip -t /tmp/new/test.gz
root@vagrant:~# echo $?
0
Погасите тестовый хост, vagrant destroy.



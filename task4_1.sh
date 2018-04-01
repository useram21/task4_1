#! /bin/bash
exec 1>task4_1.out

echo ---Hardware---
cat /proc/cpuinfo | grep "model name" | sed s'/model name\t/CPU/'

cat /proc/meminfo | grep "MemTotal" | sed s'|MemTotal:       |RAM:|'
#ne vse vivelo
sudo dmidecode -t baseboard |grep "Product Name" | sed s'|Product Name|Motherboard|'

sudo dmidecode -t baseboard |grep "Serial Number" | sed s'|Serial Number|System Serial Number|'
echo ---System---

lsb_release -a | grep "Description" | sed s'/Description:\t/OS Distribution: /'|uniq

echo "Kernel version: " `uname -r` | sed s'/  /\t/'

#echo "Installation date:" ls -clt / |tail -n 1 | awk '{print "Installation date:" $6, $7, $8 }'
#ot imeni admina
sudo tune2fs -l /dev/sda1 | grep 'Filesystem created' |sed s'/Filesystem created:      /Installation date:/'

echo "Hostname:" `hostname`
echo "Uptime:" `uptime -p`

top -n 1 | grep Task | awk '{ print "Processes running: " $2}'

top -n 1 | grep user | awk '{ print "Users logged in: " $7}'



echo ---Network---
ip addr show |grep -w inet |grep -v 127.0.0.0 |awk '{print $5":", $2}' | head -1
ip addr show |grep -w inet |grep -v 127.0.0.0 |awk '{print $7":", $2}' | tail -n 1




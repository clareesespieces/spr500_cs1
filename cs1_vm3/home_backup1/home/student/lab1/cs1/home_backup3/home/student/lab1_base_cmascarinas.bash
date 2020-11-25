#!/bin/bash

#if [[ $EUID -ne 0 ]]; then
#	echo "This script must be run as root"
#	exit 1
#fi 

echo "The script's output will be located in this directory"

if [ "$HOSTNAME" == "vm1.localdomain" ]; then  
	file=./cmascarinas_gateway_base.txt
	exec 1>$file
elif [ "$HOSTNAME" == "vm2.localdomain" ]; then
        file=./cmascarinas_vm2_base.txt
        exec 1>$file
elif [ "$HOSTNAME" == "cmascarinas-pri.aurora-cdt.com" ]; then 
        file=./emailserver_aurora-cdt.com_base.txt
        exec 1>$file
elif	[ "$HOSTNAME" == "vm4.localdomain" ]; then 
        file=./cmascarinas_vm4_base.txt
	exec 1>$file	
else 
	file=./cmascarinas_matrix_base.txt
	exec 1>$file
fi


echo -e "\n This scan was run on `date` "


echo -e "\n ----------------------------------------------- "
echo -e "              GENERAL INFORMATION"
echo -e " ------------------------------------------------ " 
echo -e "\nHostname:"
hostname | grep -oP '.*?(?=\.)'
echo -e "\n Operating System:" 
cat /etc/os-release | grep "PRETTY_NAME" | cut -d "=" -f 2
echo -e "\nFirst Installation:" 
rpm -qi basesystem | grep Install | cut -d ":" -f 2,3,4
echo -e "\nCurrent Active User:`w | cut -d " " -f 1 | grep -v USER`" 

echo -e "\n ------------------------------------------------ "
echo -e "              HARDWARE INFORMATION"
echo -e " ------------------------------------------------ "
echo -e "\n ********** Block Devices Information ***********"
lsblk
echo -e "\n ********** Disk space usage **********"
df -h
echo -e "\n ********** Disk Information **********"
cat /proc/cpuinfo | grep 'vendor' | uniq
cat /proc/cpuinfo | grep 'model name' | uniq
echo -e "Processor:  `cat /proc/cpuinfo | grep processor | wc -l`"
echo -e "Linux Kernel Version: `uname -mrs`"

echo -e "\n ********** Disk Partition Information **********"

if [[ $EUID -ne 0 ]]; then
	echo "Permission denied"
else
	fdisk -l
fi	

echo -e "\n ------------------------------------------------- "
echo -e "              NETWORK INFORMAITON"
echo -e " ------------------------------------------------ "
echo -e "\n ********** DNS Server configured **********"
tail -1 /etc/resolv.conf
echo -e "\n ********** Network devices, IP address, Broadcast, and Netmask **********"
ip a 
echo -e "\n ********** IP routes **********"
ip r
echo -e "\n ********** IPtable rules **********"
iptables -L -v -n

echo -e "\n ------------------------------------------------- "
echo -e "              SECURITY INFORMATION"
echo -e " ------------------------------------------------"

echo -e "\n ********** SELinux **********"
echo -e "`sestatus | sed 's/\(.*\)/     \1/'`"
echo -e "\n ********** Firewall **********"
if [[ $EUID -ne 0 ]]; then
	echo -e "Status: Permission Denied."
	echo -e "List of services: Permission Denied."
else
	echo -e "Status: `firewall-cmd --state`"
	echo -e "List of services: `firewall-cmd --list-services`"
fi

echo -e "\n ---------------------------------------------------"
echo -e "              SOFTWARE/SERVICE INFORMATION"
echo -e " ---------------------------------------------------"

echo -e "\n ********** Repo list of Operating System **********"
yum repolist | sed 's/\(.*\)/    \1/'
echo -e "\n ********** Services that are currently running ********** "
systemctl | grep running
echo -e "\n ********** Services installed but not running ********** "
systemctl list-units -all --state=inactive
 

exec 2>&1

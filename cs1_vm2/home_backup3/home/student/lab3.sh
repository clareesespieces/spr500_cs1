#!/bin/bash

#if [[ $EUID -ne 0 ]]; then
#	echo "This script must be run as root"
#	exit 1
#fi 

echo "The script's output will be located in this directory"

if [ "$HOSTNAME" == "vm1.localdomain" ]; then  
	file=./cmascarinas_gateway_base.txt
	exec 1>$file
elif [ "$HOSTNAME" == "clarize-vm2.mascarinas" ]; then
        file=./cmascarinas_lab3_baseline.txt
        exec 1>$file
elif [ "$HOSTNAME" == "vm3.localdomain" ]; then 
        file=./cmascarinas_vm3_base.txt
        exec 1>$file
elif	[ "$HOSTNAME" == "vm4.localdomain" ]; then 
        file=./cmascarinas_vm4_base.txt
	exec 1>$file	
else 
	file=./cmascarinas_matrix_base.txt
	exec 1>$file
fi


echo -e "\n This scan was run on `date` "

echo -e "\t REPORT TITLE: SPR500 Lab 3 Report"

echo -e "\t Full name: Clarize Mascarinas"
echo -e "\t Username: cmascarinas"
echo -e "\t Student ID: 158759183"

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
echo -e "\n ********** IP tables -L -v -n **********"
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
	echo -e "Status: not running"
	echo -e "List of services: none"
fi

echo -e "\n ---------------------------------------------------"
echo -e "              SOFTWARE/SERVICE INFORMATION"
echo -e " ---------------------------------------------------"

echo -e "\n ********** Repo list of Operating System **********"
yum repolist | sed 's/\(.*\)/    \1/'
echo -e "\n ********** Number of RPM packages **********"
rpm qa | wc -l
echo -e "\n ********** Number of active services **********"
systemctl list-unit-files | grep enabled | wc -l 
echo -e "\n ********** Services that are currently running ********** "
systemctl | grep running
echo -e "\n ********** Services installed but not running ********** "
systemctl list-units -all --state=inactive
echo -e "\n ********** Status of Httpd **********"
systemctl status httpd
echo -e "\n ********** Current size of files **********"
echo -e " /var/log/messages:" `ls -l /var/log/messages`
echo -e " /var/log/boot.log:" `ls -l /var/log/boot.log`
echo -e " /var/log/maillog: `ls -l /var/log/maillog`"
echo -e " /var/log/secure: `ls -l /var/log/secure`"
echo -e " /var/log/wtmp: `ls -l /var/log/wtmp`"
echo -e " /var/log/btmp: `ls -l /var/log/btmp`"
echo -e " /var/log/lastlog: `ls -l /var/log/lastlog`"
echo -e " /var/log/dnf.log: `ls -l /var/log/dnf.log`"


exec 2>&1

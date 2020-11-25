#!/bin/bash


iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p udp -i ens192 -j ACCEPT
iptables -A INPUT -p udp -i ens224 -j ACCEPT
iptables -A INPUT -i ens192 -p icmp -j ACCEPT
iptables -A INPUT -i ens224 -p icmp -j ACCEPT 
iptables -A INPUT -p tcp -s 192.168.20.0/24 --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -s 172.16.20.1 --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -s 10.102.108.0/16 --dport 22 -j ACCEPT #seneca matrix ip addresses
iptables -N LOGGING #create chain

#log/reject rules for SSH access
iptables -A INPUT -p tcp --dport 22 -j LOGGING
iptables -A LOGGING -m limit --limit 2/min -p tcp --dport 22 -j LOG --log-prefix "SSH Access attempts: "
iptables -A LOGGING -p tcp --dport 22 -j REJECT

#log/reject rules for anyone from my network 
iptables -A INPUT -s 192.168.20.0/24 -j LOGGING
iptables -A LOGGING -s 192.168.20.0/24 -m limit --limit 2/min -j LOG --log-prefix "Private Network Access attempts: "
iptables -A LOGGING -s 192.168.20.0/24 -j REJECT 

#log/reject rules from other networks
iptables -A INPUT -j LOGGING
iptables -A LOGGING -m limit --limit 2/min -j LOG --log-prefix "Access attempts: "
iptables -A LOGGING -j DROP


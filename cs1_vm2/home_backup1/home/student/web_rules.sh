#!/bin/bash

iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p udp -s 172.16.0.1 -j ACCEPT
iptables -A INPUT -p udp -s 192.168.20.0/24 -j ACCEPT
iptables -A INPUT -p icmp -s 172.16.0.1 -j ACCEPT
iptables -A INPUT -p icmp -s 192.168.20.0/24 -j ACCEPT
#iptables -A INPUT -p tcp -s 192.168.20.0/24 --sport 22 -j ACCEPT 
iptables -A INPUT -p tcp -s 192.168.20.0/24 --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -s 172.16.0.1 --dport 22 -j ACCEPT

#-- IP address rules to allow machines in my network to wget for Lab 3 --
#iptables -A INPUT -p tcp -s 127.0.0.1 -d 192.168.20.2 --dport 80 -j ACCEPT
#iptables -A INPUT -p tcp -i ens192 --dport 80 -j ACCEPT
#iptables -A INPUT -p tcp -i ens224 --dport 80 -j ACCEPT


iptables -A INPUT -p tcp -s 10.102.108.0/16 --dport 22 -j ACCEPT #Allow matrix ssh 
iptables -I INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT  
iptables -N LOGGING #create Logging chain 

#-- log/reject rules for SSH access --
iptables -A INPUT -p tcp --dport 22 -j LOGGING
iptables -A LOGGING -m limit --limit 2/min -p tcp --dport 22 -j LOG --log-prefix "SSH Access attempts: "
iptables -A LOGGING -p tcp --dport 22 -j REJECT

#-- log/reject rules from private network --
iptables -A INPUT -s 192.168.20.0/24 -j LOGGING
iptables -A LOGGING -s 192.168.20.0/24 -m limit --limit 2/min -j LOG --log-prefix "Private Network Access attempts: "
iptables -A LOGGING -j REJECT

#-- log/reject rules from other networks --
iptables -A INPUT -j LOGGING
iptables -A LOGGING -m limit --limit 2/min -j LOG --log-prefix "Access attempts: "
iptables -A LOGGING -j DROP



#!/bin/bash

# This is a generic firewalling script for a mailserver in the Aurora-CDT.com
# domain. This is primarily designed to act as a filter for incoming traffic on
# the SPR lab network. This host will be permitted to receive content
# from within the Aurora-CDT.com network architecture, and other access from
# the lab will be restricted to DNS and email traffic only.

# Change default input policy to drop
iptables -P INPUT DROP

# Permit SSH from Aurora-CDT.com network hosts
iptables -I INPUT -p tcp -s 192.168.4.0/24 --dport 22 -j ACCEPT
iptables -I INPUT -p tcp -s 192.168.20.0/24 --dport 22 -j ACCEPT
iptables -I INPUT -p tcp -s 192.168.27.0/24 --dport 22 -j ACCEPT

# Permit POP3 from other network hosts
iptables -I INPUT -p tcp --dport 110 -j ACCEPT

#Permit ssh from Seneca matrix
iptables -A INPUT -p tcp -s 10.102.108.0/16 --dport 22 -j ACCEPT 

# Permit instructor ssh
iptables -I INPUT -p tcp -s 172.16.0.1 --dport 22 -j ACCEPT

# Permit DNS traffic from all sources
iptables -A INPUT -p udp --dport 53 -j ACCEPT

# Permit email traffic from all sources within the SPR500 lab
iptables -A INPUT -p tcp --dport 25 -j ACCEPT

# Permit ICMP from all sources
iptables -A INPUT -p icmp -j ACCEPT

# Allow all traffic originating from the localhost
iptables -A INPUT -i lo -j ACCEPT

# Allow all other established/related traffic
iptables -I INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Log and Drop other traffic
iptables -A INPUT -p tcp --dport 22 -j LOG --log-prefix "Unknown SSH Traffic: " --log-level 4
iptables -A INPUT -p tcp --dport 22 -j REJECT
iptables -A INPUT -p udp -j LOG --log-prefix "Unknown UDP Traffic: " --log-level 4
iptables -A INPUT -j LOG --log-prefix "Unknown OTHER Traffic: " --log-level 4
iptables -A INPUT -j DROP

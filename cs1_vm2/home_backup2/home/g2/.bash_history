cd
sudo ls -la /root
su cmascarinas
su student
ls
ls /var/log
ls /var/log/httpd
cd /var/log
ls
sudo chmod +rw httpd
cd httpd
sudo chmod 777 httpd
cd httpd
ls
pwd
cd
ls
vi splunk-install.sh 
ls
sudo ./splunk-install.sh 
systemctl status httpd
sudo systemctl stop httpd
sudo systemctl start httpd
tail /var/log/messages
sudo tail /var/log/messages
iptables -L -n -v
sudo iptables -L -n -v
dig MX @192.168.20.2 aurora-cdt.com
dig MX @192.168.4.2 aurora-cdt.com
nslookup -query=MX aurora-cdt.com 192.168.20.3
clear
tail /var/log/messages
sudo tail /var/log/messages
sudo grep "Unkown SSH" /var/log/messages
sudo grep "Unknown SSH" /var/log/messages
clear
sudo grep "Unknown SSH" /var/log/messages
clear

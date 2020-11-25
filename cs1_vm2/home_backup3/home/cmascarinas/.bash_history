su student 
qCpnmCrcB9*
su student 
sudo diff /etc/httpd/conf.d/userdir.conf /home/cmascarinas/httpd/userdir.conf
su 
su student 
cd
ls
ls lab3/httpd
su student 
cd
ls
pwd
mkdir lab3/httpd
mkdir -p lab3/httpd
ls
ls lab3
su student
ls
cd
ls
cd lab3
ls
cd log-backup/
ls
cd
su student 
ls
cd
ls
cd lab3
ls
ping 192.168.29.2
ping 192.168.29.1
ping 192.168.29.3
ping 192.168.29.4
ls
mkdir log-backup
ls
cd
su student
cd cmascarinas/
ls
ls -l public_html/
ls
ls -l
getsebool -a
setsebool http_enable_homedir on
setsebool http_enable_homedirs on
setsebool httpd_enable_homedirs on
sudo setsebool httpd_enable_homedirs on

getsebool -a | grep "httpd"
ls
cd public_html/
ls
vim index.html 
wget http://172.16.20.2/
;s
ls
cat index.html.1
wget http://172.16.5.2/
cat index.html.2
wget http://172.16.26.2/
cat index.html.3
vim index.html 
wget http://172.16.24.2/
cat index.html.4
cat index.html.3
cd
sudo cat /var/log/messages | tail
su student
ls
cd
ls
cat public_html 
cp public_html index.html
ls
rm public_html 
ls
mkdir public_html
ls
mv index public_html/
mv index.html public_html/
ls
cd
cd ..
ls
cd ..
ls
sudo ls -l home
su student

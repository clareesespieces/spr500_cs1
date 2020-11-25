#!/bin/bash

#.......... Home Directories .........
rm -rf /cs1/home_backup3
mv /cs1/home_backup2 /cs1/home_backup3
cp -al /cs1/home_backup1 /cs1/home_backup2
rsync -a -v --delete /home /cs1/home_backup1


#.......... DNS configurations ..........
rm -rf /cs1/dns_backup3/
mv /cs1/dns_backup2/ /cs1/dns_backup3/
cp -al /cs1/dns_backup1/ /cs1/dns_backup2/
rsync -a -v --delete /etc/named.conf /cs1/dns_backup1/

#.......... Zone files ..........
rm -rf /cs1/dns_backup3/zones
mv /cs1/dns_backup2/zones /cs1/dns_backup3/zones
cp -al /cs1/dns_backup1/zones /cs1/dns_backup2/zones
rsync -a -v --delete /var/named /cs1/dns_backup1/zones

#.......... Web Server Directories .........
rm -rf /cs1/web_backup3
mv /cs1/web_backup2 /cs1/web_backup3
cp -al /cs1/web_backup1 /cs1/web_backup2
rsync -a -v --delete /var/www /cs1/web_backup1


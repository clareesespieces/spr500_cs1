#!/bin/bash


#.......... Home Directories .........
rm -rf /cs1/home_backup3
mv /cs1/home_backup2 /cs1/home_backup3
cp -al /cs1/home_backup1 /cs1/home_backup2
rsync -a -v --delete /home /cs1/home_backup1

# .......... Postfix configurations ..........
rm -rf /cs1/postfix_backup3
mv /cs1/postfix_backup2 /cs1/postfix_backup3
cp -al /cs1/postfix_backup1 /cs1/postfix_backup2
rsync -a -v --delete /etc/postfix /cs1/postfix_backup1 

#.......... Mailbox mails ..........
rm -rf /cs1/mailbox_backup3
mv /cs1/mailbox_backup2 /cs1/mailbox_backup3
cp -al /cs1/mailbox_backup1 /cs1/mailbox_backup2
rsync -a -v --delete /var/spool/mail /cs1/mailbox_backup1 

#.......... Docevot ..........
rm -rf /cs1/dovecot_backup3
mv /cs1/dovecot_backup2 /cs1/dovecot_backup3
cp -al /cs1/dovecot_backup1 /cs1/dovecot_backup2
rsync -a -v --delete /etc/dovecot /cs1/dovecot_backup1 

#.......... Spamassassin ..........
rm -rf /cs1/spamassassin_backup3
mv /cs1/spamassassin_backup2 /cs1/spamassassin_backup3
cp -al /cs1/spamassassin_backup1 /cs1/spamassassin_backup2
rsync -a -v --delete /etc/mail/spamassassin /cs1/spamassassin_backup1 

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











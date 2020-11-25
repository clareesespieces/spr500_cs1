sudo rpm -i splunkuf.rpm
cd /opt/splunkforwarder/bin

sudo ./splunk start

sudo ./splunk add forward-server 3.13.2.120:9997

sudo ./splunk add monitor /var/log/messages
sudo ./splunk add monitor /var/log/secure
sudo ./splunk set deploy-poll 3.13.2.120:8089
sudo ./splunk restart

#!/bin/bash


#should I update this value to the local LAN IP???
BUCount=$(curl http://192.168.2.21:8810/status-json.xsl | awk -F ',' '{print $14}' |  tr -d '"listeners":'
)

#echo "Current listenership on the backup server is $BUCount"

if (test $BUCount -gt 0);
then
    echo "larger than 0!!";
    exit
#This is the area I'll fill in info about emailing my email address with the details. 
else
    curl https://hc-ping.com/3215be5b-7d5d-4633-9fb2-fd27e0abf170
    echo "Good news homie! The current listener count is $BUCount!!";
    exit;
fi

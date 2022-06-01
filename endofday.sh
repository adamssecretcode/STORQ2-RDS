#!/bin/bash

#confirm we're in the right directory
cd /mnt/c/RDS

#establish date format/pattern
NOW=$(date +"%Y%m%d")


cat today.txt | uniq > logs/$NOW\ songs.txt

echo "" > today.txt

curl https://hc-ping.com/8c09b489-4253-4238-9571-014373578274
#Check in with Healthchecks.io

exit

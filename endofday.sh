#!/bin/bash

#confirm we're in the right directory
cd /mnt/c/RDS

#establish date format/pattern
NOW=$(date +"%Y%m%d")


cat today.txt | uniq > logs/$NOW\ songs.txt

echo "" > today.txt

exit

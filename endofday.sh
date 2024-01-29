#!/bin/bash

######Import configuration details.
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
######Import configuration details.
source "$SCRIPT_DIR/config.txt"

cd $DIRECTORY

#establish date format/pattern
NOW=$(date +"%Y%m%d")

cat $DAILYFILE | uniq > logs/$NOW-songs.txt

echo "" > $DAILYFILE

#curl $HEALTHCHECKSEOD

exit

#!/bin/bash
#Nowplaying Script for Harvesters FM to check the last line of the "as played" log.
# If its a song, update RDS. If its other, decipher what it is, and print it to RDS.
#

#first, check in with HealthChecks.io
curl https://hc-ping.com/800fae54-6d09-4682-b739-e28d076fef86



#confirm we're in the right directory
cd /mnt/c/RDS

#establish date format/pattern
NOW=$(date +"%Y%m%d")

#create a variable to load all our stuff into
nowplaying=$(curl -k http://192.168.2.69/aftlogs/1/$NOW.log | tail -n 1 | awk -F "," '{ print $12 }')

#curl -k [URL] (download log)
#tail -n 1 | (read the last line ONLY)
#awk -F "," '{ print $12 }' (print the 12th column, using a comma as a delimiter)


if grep -q "$nowplaying"  <<< "song"; then
    song=$(curl -k http://192.168.2.69/aftlogs/1/$NOW.log | tail -n 1 | awk -F "," '{ print $8 " by " $9 }' | tr -d '"')
    final=$song
    
elif grep -q "$nowplaying" <<< "spot" || grep -q "$nowplaying" <<< "localspot"; then   
    spot=$(curl -k http://192.168.2.69/aftlogs/1/$NOW.log | tail -n 1 | awk -F "," '{ print $6 }')
    if ! grep -q "$spot" assets-*.txt; then #If the spot isn't located in either assets document, print Station Name
        final="Harvesters FM"
    elif grep -q "$spot" assets-prg.txt; then #If the spot is in our programming assets, print show title
        final=$(grep -F -e "$spot" assets-prg.txt | awk -F "," '{print $2}' );
    else
        final=$(grep -F -e "$spot" assets-mus.txt | awk -F "," '{print $2}' ); #If the spot is in our music assets, print song title, and log it for charting. 
        song=$final;
    fi


else
    final="Harvesters FM - option 3"
    exit
fi


#if column 12 (of our STORQ2 airlog output) says song, then parse the song information. 

# download the log again >> curl -k link
# parse the last line again >> tail -n 1  
# print the Artist & Title (8th & 9th columns) >> awk -F "," '{ print $8 " by " $9 }' 
# eliminate the quotes using a program called 'tr' >> tr -d '"'

#if column 12 says spot, check to see if it's a program or not. 
#parse the 6th column to get the cart number, then process the cart number. 
# Double pipes indicate "or" 


if [ -z "$song" ]; then
        :
#if the variable song is empty, do nothing. If its filled, write it to log. 
    else
        if [ "$song" != "$(tail -n 1 today.txt)" ]; then
            echo $song >> "today.txt"
#if the song DOESNT match the last line in the log file, write it to the log
        else
            :
        fi
fi
#If we're playing a song, log it. If it's already been logged, skip the step. 


#Strip "(Cancon)" from displaying on nowplaying.txt, but keep it for the logs. 
final=$(echo $final | sed "s/[(]Cancon[)]//g")


# This version eliminates everything between parathensis:
# final=$(echo $final | sed "s/[(][^)]*[)]//g")



if [ "$final" == "$(cat /mnt/c/RDS/nowplaying.txt)" ]; then
    exit 
else
    echo $final > /mnt/c/RDS/nowplaying.txt
fi

#check now playing file, to see if its up to date. if there is a change, update it.  

exit

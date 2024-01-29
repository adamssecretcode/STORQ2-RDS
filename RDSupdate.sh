#!/bin/bash
#######Nowplaying Script for Harvesters FM to check the last line of the "as played" log.
#######If its a song, update RDS. If its other, decipher what it is, and print it to RDS.

#Get our configuration details regardless from where the script is called. 
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
######Import configuration details.
source "$SCRIPT_DIR/config.txt"

######Change to working directory
cd $DIRECTORY

while true; do
    sleep 20
    ######first, check in with HealthChecks.io
    # curl $HEALTHCHECKSRDS

    ######establish date format/pattern
    NOW=$(date +"%Y%m%d")

    ######create a variable to load all our stuff into
    nowplaying=$(curl -k http://$IP/aftlogs/1/$NOW.log | tail -n 1)
    ######Isolate the element being aired:
    nowplayingstatus=$(echo $nowplaying | awk -F "," '{ print $12 }')

    #curl -k [URL] (download log)
    #tail -n 1 | (read the last line ONLY)
    #awk -F "," '{ print $12 }' (print the 12th column, using a comma as a delimiter)


    if grep -q "$nowplayingstatus"  <<< "song"; then
        song=$(echo $nowplaying | awk -F "," '{ print $8 " by " $9 }' | tr -d '"')
        final=$song
        
    elif grep -q "$nowplayingstatus" <<< "spot" || grep -q "$nowplayingstatus" <<< "localspot"; then   
        spot=$(echo $nowplaying | awk -F "," '{ print $6 }')
        if ! grep -q "$spot" assets/assets-*.txt; then #If the spot isn't located in either assets document, print Station Name
            final="$GENERICDISPLAYTEXT"
        elif grep -q "$spot" assets/assets-prg.txt; then #If the spot is in our programming assets, print show title
            final=$(grep -F -e "$spot" assets/assets-prg.txt | awk -F "," '{print $2}' );
        else
            final=$(grep -F -e "$spot" assets/assets-mus.txt | awk -F "," '{print $2}' ); #If the spot is in our music assets, print song title, and log it for charting. 
            song=$final;
        fi


    else
        final="Harvesters FM - option 3"
        continue
    fi

    #######Explaination on the above
    # if column 12 (of our STORQ2 airlog output) says song, then parse the song information. 
    # print the Artist & Title (8th & 9th columns) >> awk -F "," '{ print $8 " by " $9 }' 
    # eliminate the quotes using 'tr' >> tr -d '"'
    # if column 12 says spot, check to see if it's a program or not. 
    # parse the 6th column to get the cart number, then process the cart number. 
    # Double pipes indicate "or" 


    if [ -z "$song" ]; then
            :
    #if the variable song is empty, do nothing. If its filled, write it to log. 
        else
            if [ "$song" != "$(tail -n 1 $DAILYFILE)" ]; then
                echo $song >> "$DAILYFILE"
    #if the song DOESNT match the last line in the log file, write it to the log
            else
                :
            fi
    fi
    #If we're playing a song, log it. If its already been logged, skip the step. 


    #Strip "(Cancon)" from displaying on nowplaying.txt, but keep it for the logs. 
    final=$(echo $final | sed "s/[(]Cancon[)]//g")


    # This version eliminates everything between parathensis:
    # final=$(echo $final | sed "s/[(][^)]*[)]//g")


    ###check now playing file, to see if its up to date. if there is a change, update it.  

    if [ "$final" == "$(cat $DIRECTORY/$RDSFILE)" ]; then
        continue
    else

        echo $final > $DIRECTORY/$RDSFILE
    fi

    

done


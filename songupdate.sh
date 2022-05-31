#!/bin/bash
#Nowplaying Script for Harvesters FM to check the last line of the "as played" log.
# If its a song, update RDS. If its other, shut down.
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
    if grep -q "$spot" <<< "6017"; then
        final="Turning Point"
    elif grep -q "$spot" <<< "6005"; then
        final="Grace To You"
    elif grep -q "$spot" <<< "6018"; then
        final="Haven Today"
    elif grep -q "$spot" <<< "4209"; then
        final="World Missionary Evangelism"
    elif grep -q "$spot" <<< "6202"; then
        final="Truth For Life" 
    elif grep -q "$spot" <<< "5022"; then
        final="Just a Minute"
    elif grep -q "$spot" <<< "6597"; then
        final="Tom Copland Financial Minute"
    elif grep -q "$spot" <<< "6001"; then
        final="Back To The Bible"
    elif grep -q "$spot" <<< "6007"; then
        final="In Touch"
    elif grep -q "$spot" <<< "6004"; then
        final="Focus On The Family Canada"
    elif grep -q "$spot" <<< "6117"; then
        final="Live In The Light"
    elif grep -q "$spot" <<< "6015"; then
        final="Plugged In"
    elif grep -q "$spot" <<< "6256"; then
        final="Let The Bible Speak"
    elif grep -q "$spot" <<< "6260"; then
        final="Let The Bible Speak"
    elif grep -q "$spot" <<< "6013"; then
        final="Life Study of the Bible"
    elif grep -q "$spot" <<< "6016"; then
        final="Thru the Bible"
    elif grep -q "$spot" <<< "1446"; then
        final="Words to Live By"
    elif grep -q "$spot" <<< "6535"; then
        final="Tom Copland 30 Minutes"
    elif grep -q "$spot" <<< "6014"; then
        final="Adventures In Odyssey"
    elif grep -q "$spot" <<< "4038"; then
       final="Adventures In Odyssey"
    elif grep -q "$spot" <<< "4943"; then
        final="Culture at a Crossroads"
    elif grep -q "$spot" <<< "4044"; then
        final="Focus Radio Theatre"
    elif grep -q "$spot" <<< "4045"; then
        final="Focus Radio Theatre"
    elif grep -q "$spot" <<< "4043"; then
        final="Focus Radio Theatre"
    elif grep -q "$spot" <<< "4021"; then
        final="Friends of Israel"
    elif grep -q "$spot" <<< "4032"; then
        final="Lamplighter Theatre"
    elif grep -q "$spot" <<< "4033"; then
        final="Lamplighter Theatre"
    elif grep -q "$spot" <<< "4034"; then
        final="Lamplighter Theatre"
    elif grep -q "$spot" <<< "5046"; then
        final="In Doubt"
    elif grep -q "$spot" <<< "4059"; then
        final="Weekend Magazine"
    elif grep -q "$spot" <<< "4060"; then
        final="Weekend Magazine"
    elif grep -q "$spot" <<< "4061"; then
        final="Weekend Magazine"
    elif grep -q "$spot" <<< "4062"; then
        final="Weekend Magazine"
    elif grep -q "$spot" <<< "4025"; then
        final="Canada's National Bible Hour"
    elif grep -q "$spot" <<< "5200"; then
        final="Sky's Revival"
    elif grep -q "$spot" <<< "4028"; then
        final="In Touch (Weekend)"
    elif grep -q "$spot" <<< "6261"; then
        final="Let The Bible Speak Weekend"
    elif grep -q "$spot" <<< "4024"; then
        final="Back To The Bible Weekend"
    elif grep -q "$spot" <<< "4037"; then
        final="Lutheran Hour"
    elif grep -q "$spot" <<< "6019"; then
        final="Haven Today Weekend"
    elif grep -q "$spot" <<< "6201"; then
        final="Truth For Life (Weekend)"
    elif grep -q "$spot" <<< "4010"; then
        final="Mission Compass"
    elif grep -q "$spot" <<< "6200"; then
        final="Men Alive"
    elif grep -q "$spot" <<< "4938"; then
        final="Spread The Word"
    elif grep -q "$spot" <<< "1445"; then
        final="The Lord's Challenge"
    elif grep -q "$spot" <<< "4036"; then
        final="La Foi Vivifiante"
    elif grep -q "$spot" <<< "4030"; then
        final="Gaither Homecoming Radio"
    elif grep -q "$spot" <<< "6108"; then
        final="Hearts To Believe"
    elif grep -q "$spot" <<< "6099"; then
        final="Banner of Truth"
    elif grep -q "$spot" <<< "4023"; then
        final="AnchorPoint"
    elif grep -q "$spot" <<< "4939"; then
        final="Hope Today"
    elif grep -q "$spot" <<< "4940"; then
        final="Hope Today"
    elif grep -q "$spot" <<< "4941"; then
        final="Hope Today"
    elif grep -q "$spot" <<< "4942"; then
        final="Hope Today"
    elif grep -q "$spot" <<< "1234"; then
        final="Program Name"
    elif grep -q "$spot" <<< "1234"; then
        final="Program Name"
    elif grep -q "$spot" <<< "1234"; then
        final="Program Name"
    elif grep -q "$spot" <<< "1234"; then
        final="Program Name"
    elif grep -q "$spot" <<< "1234"; then
        final="Program Name"
    elif grep -q "$spot" <<< "1234"; then
        final="Program Name"
    elif grep -q "$spot" <<< "1234"; then
        final="Program Name"
#start of cancon
    elif grep -q "$spot" <<< "7501"; then
        final="Your Love by Aaron Bucks (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7502"; then
        final="A Little Bit of Faith by Alisha Dawn (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7503"; then
        final="No One Else by Allen Froese (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7504"; then
        final="Renew My Mind by Allen Froese (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7505"; then
        final="Miracles by BLSNG (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7506"; then
        final="Someone Like You by Brant Pethick (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7507"; then
        final="Still by Brooke Nicholls (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7508"; then
        final="Inside Your Heart by C3 Saskatoon (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7509"; then
        final="What Can He Do by Chris Bray (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7510"; then
        final="Key To My Heart by Corey Lueck (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7511"; then
        final="We Never Stop by Corey Lueck (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7512"; then
        final="Let That Go by Dan Bremnes (Cancon)" 
        song=$final
    elif grep -q "$spot" <<< "7513"; then
        final="Scars by Dan Bremnes (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7514"; then
        final="Expectation by Elias Dummer (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7515"; then
        final="Echoing Holy by Elias Dummer (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7516"; then
        final="Here Comes The Kingdom by Jake Fretz (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7517"; then
        final="I Want Your Heart by Jake Fretz (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7518"; then
        final="Fires by Jordan St. Cyr (Cancon)" 
        song=$final
    elif grep -q "$spot" <<< "7519"; then
        final="Weary Traveller by Jordan St. Cyr (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7520"; then
        final="Moving On by Love & The Outcome (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7521"; then
        final="Thank God I'm Alive by Manic Drive (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7522"; then
        final="God of Faithfulness by Movement Worship (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7523"; then
        final="My Victory by Tehillah Worship (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7524"; then
        final="Your Sad Eyes by The 8th Line (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7525"; then
        final="After My Heart by The Color (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7526"; then
        final="Better Way by The Color (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7527"; then
        final="Call of the Wild by The Color (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7528"; then
        final="Fly by The Voyage (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7529"; then
        final="Mortals by West of Here (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7530"; then
        final="Jesus Plus Nothing by Corey Lueck (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7531"; then
        final="Joyful Noise by Matt Maher (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7532"; then
        final="Bloodlines by Tim & The Gloryboys (Cancon)" 
        song=$final
    elif grep -q "$spot" <<< "7533"; then
        final="I'm Not Lucky, I'm Blessed by Love & The Outcome (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7534"; then
        final="The Wind & The Waves by Fresh IE (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7535"; then
        final="Let The World Sing by Tehillah Worship (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7536"; then
        final="All The Glory by Allen Froese (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7537"; then
        final="Miracle by Brant Pethick (Cancon)"
        song=$final
    elif grep -q "$spot" <<< "7538"; then
        final="Captain by Hunter Brothers (Cancon)"
        song=$final
    else
        final="Harvesters FM"
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

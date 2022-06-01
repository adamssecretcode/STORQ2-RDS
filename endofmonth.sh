#!/bin/bash
#This is a script to create an airplay chart out of all the logs for an entire month.
#This works for logfiles labelled YYYYMMDD.* 
#Launch the script with a 2 digit month number arguement to create the chart. 
#E.G. "./endofmonthchart.sh 05"


#Ensure we have arguments. 
if [ $# -eq 0 ]; then
 echo "Please run again with a two digit month number"
 exit 1
fi

#Create a couple of variables. 
YEAR=$(date +"%Y")
MONTH=$1
# $1 is the number of the month passed from launching the script e.g. 05

cat logs/$YEAR$MONTH* > monthtemp.txt
#Gathers all the logs into a temp file. 

cat monthtemp.txt | sort | uniq -c | sort -n -r | sed "s/[(]Cancon[)]//g" >  chart-$YEAR$MONTH.txt
#Creates main chart of all songs

cat monthtemp.txt | sort | uniq -c | sort -n -r | grep "(Cancon)" | sed "s/[(]Cancon[)]//g" >  chart-$YEAR$MONTH-cancon.txt
#Creates main chart of Cancon only. 

rm monthtemp.txt
#Delete temp file

echo -n "Files have been saved as \"" && echo -n $PWD && echo "/chart-$YEAR$MONTH.txt\""

exit

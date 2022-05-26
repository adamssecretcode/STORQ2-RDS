# STORQ2-RDS
Collection of scripts to parse output of STORQ2 radio automation log, update RDS, create logs & charts. 


This is a collection of scripts for parsing the output of the STORQ2 radio automation system messy logs and export clean song titles and specialty programming to RDS displays. Additional scripts will clean up the data and create monthly song charts. 


**songupdate.sh** - Parses the output of the final line of the STORQ2 'asplayed' log, cleans it up, and directs output to text file for RDS to pick up. 

**endofday.sh** - Checks for any items that accidentally got logged twice in a row, and cleans those up before archiving the final playlist in the logs subfolder. 

**endofmonth.sh** - When run with a 2 digit numerical argument (eh "./endofmonth.sh 05"), will create a song chart from all the archived logs from that month (05 is May, 06 in June, etc). 

**Scheduling in Crontab**

    * * * * * /path/to/songupdate.sh 
songupdate scripts runs every minute

    59 23 * * * endofday.sh 
runs at 23:59:00 daily. 



# STORQ2-RDS
Collection of scripts to parse output of STORQ2 radio automation log, update RDS, create logs & charts. 

This is a collection of scripts for parsing the output of the STORQ2 radio automation system messy logs and export clean song titles and specialty programming to RDS displays. Additional scripts will clean up the data and create monthly song charts. 


**RDSupdate.sh** - Parses the output of the final line of the STORQ2 'asplayed' log, cleans it up, and directs output to text file for RDS to pick up. An "archive" version is also saved in a daily log file. 

**endofday.sh** - Scans the daily log file for any items that accidentally got logged twice in a row, and cleans those up before archiving the final playlist in the logs subfolder. 

**endofmonth.sh** - When run with a 2 digit numerical argument (eh "./endofmonth.sh 05"), will create a song chart from all the archived logs from that month (05 is May, 06 in June, etc). 

**Scheduling**
The RDS update script - which used to run via crontab every minute - now runs as a systemd service. The bash script now runs every 20 seconds in a loop rather than needing to be called via cron. 

Edit the RDS.service script with the path to your "RDSupdate.sh" script. Copy it to /etc/systemd/system/RDS.service. Then run:
    sudo systemctl daemon-reload
    sudo systemctl start RDS
    sudo systemctl enable RDS

**Crontab scheduling of "end of day" script:**
The end of day script only runs once per day, which is fine to schedule via crontab.     
    crontab -e
    59 23 * * * endofday.sh 





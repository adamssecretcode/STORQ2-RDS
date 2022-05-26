# STORQ2-RDS
Collection of scripts to parse output of STORQ2 radio automation log, update RDS, create logs & charts. 


This is a collection of scripts for parsing the output of the STORQ2 radio automation system messy logs and export clean song titles and specialty programming to RDS displays. Additional scripts will clean up the data and create monthly song charts. 

**Crontab**

songupdate.sh runs every minute

endofday.sh runs at 23:59:00 daily. 

endofmonth.sh runs manually, with 2 digit month number passed through as argument upon launch (e.g. ./endofmonth.sh 05)

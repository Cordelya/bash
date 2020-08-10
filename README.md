# bash
Cordelya's Collected Bash Scripts

* act-choose.sh *
I wrote this script to randomly select two activities from a pool of possible activities. For me, this means a mix of leisure reading, personal care, educational activities, practicing things I'm learning, and doing non-urgent chores that can be done on a relaxed schedule. These activities (for me) are intended to be done for 30 minutes to 2 hours, with the option to set a timer to keep from spending all day doing one thing. This can be helpful for people who experience decision-gridlock, where too many choices mean they choose nothing and sit around surfing Twitter (cough).

This script, when provided file activities.csv, randomly chooses two lines from the top 20 in the file, displays them in stdout, updates the last-seen date to the current date, re-sorts the file so it is in reverse chronological order (oldest first), and saves a copy in /archives with the current date added to the filename. You will need to write this file yourself and place it into the same directory as the shell script file.

Your activities.csv file contents should be formatted as YYYYMMDD;$activity where $activity is an activity you would like added to the pool of choices. Each new activity goes on a new line. You need at least 20 lines for this to work (or you need to edit the script to apply a different %) and it will work better if there are about 30 lines - because any activity you do will sit below line 20 for several days, and therefore is guaranteed to not be chosen. Because we all know that boredom kills, right?

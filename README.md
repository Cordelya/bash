# bash
Cordelya's Collected Bash Scripts

## act-choose.sh
I wrote this script to randomly select two activities from a pool of possible activities. For me, this means a mix of leisure reading, personal care, educational activities, practicing things I'm learning, and doing non-urgent chores that can be done on a relaxed schedule. These activities (for me) are intended to be done for 30 minutes to 2 hours, with the option to set a timer to keep from spending all day doing one thing. This can be helpful for people who experience decision-gridlock, where too many choices mean they choose nothing and sit around surfing Twitter (cough).

This script, when provided file *activities.csv*, randomly chooses two lines from the top 20 in the file, displays them in stdout, updates the last-seen date to the current date, re-sorts the file so it is in reverse chronological order (oldest first), and saves a copy in /archives with the current date added to the filename. You will need to write this file yourself and place it into the same directory as the shell script file.

Your *activities.csv* file contents should be formatted as 

> YYYYMMDD;$activity 

where YYYYMMDD is a date in the past (so you can start using it today) and $activity is an activity you would like added to the pool of choices. Each new activity goes on a new line. You need at least 20 lines for this to work (or you need to edit the script to apply a different %) and it will work better if there are about 30 lines - because any activity you do will sit below line 20 for several days, and therefore is guaranteed to not be chosen. Because we all know that boredom kills, right?

This script won't give you a second chance to generate activities, but if you absolutely must, you can copy the previous day's archive file over *activities.csv* and it will be like you haven't run it yet.

## packages.sh
This script queries and builds a file containing your locally installed packages, grabs and refines the manifest of the version of your default OS (built for Ubuntu, may need tweaking for other OSs), and builds a new file, *custompackages.txt* that contains only packages that are installed but not on the manifest. 

If you lose your install or are expanding to a new machine, and you have an uploaded or backed up copy of *custompackages.txt*, it'll give you a list of packages you'll want to consider installing on a new build.

See https://unix.stackexchange.com/questions/3595/list-explicitly-installed-packages/3624#3624 for an explanation of how this works.

## gauge.sh
This script pulls river gauge data from https://waterservices.usgs.gov/, extracts the data from the xml, filters it to one reading per day, chops off the date/time, and displays the resulting readings using sparklines. Depends on https://github.com/holman/spark for the sparklines and non-standard package xml-twig-tools for xml_grep. The script defaults to the Lower Mississippi River Carrollton Gauge. You can use it as-is for some New Orleans flavor or roll your own gauge data-pull at the Water Services site.

A planned feature: display spark bars in red whenever the gauge value exceeds 8. (Why 8? There is a "high water" threshhold at 8 feet which changes how USACE and USCG operate in terms of Mississippi River Operations, and it affects marine traffic)

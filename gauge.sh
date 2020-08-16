#!/bin/bash

# This script pulls a dynamic XML file from https://waterservices.usgs.gov which contains river gauge information for one gauge. 
# If you want to pull a different gauge, you need to, at minimum, change the value in "&sites=" in the URL to the resource ID for 
# the gauge you want to use. You may also need to modify the site type. In this file, it is set to "ST" for "Stream".

# File references
url="https://waterservices.usgs.gov/nwis/iv/?format=waterml,2.0&sites=07374510&period=P4W&parameterCd=00065&siteType=ST&siteStatus=all"
xml=("$HOME"/scripts/gauge/"$(date +%m%d)".xml) # where we store the raw data, relative to $HOME
txt=("$HOME"/scripts/gauge/gauge.txt) # where we store the extracted data, rel 2 $HOME
search=(./gauge/*.xml)
old=()
temp=("$HOME"/scripts/gauge/temp.txt)

if [ $(find . -wholename "$search" -print) ]
then old=$(find . -wholename "$search" -mtime 0 -print)
fi
# raw data retrieval (not more than once per day)
if [[ $old != $xml ]]  #if existing file is not from today
then
wget -q -O $xml $url # then request an updated copy
fi

# Use xml_grep to pull just the data we want - the date/time and the 
# gauge readings
xml_grep "wml2:MeasurementTVP" "$xml" --text_only > "$txt"

# Prepend some descriptive text
echo 'Carrollton Gauge Last 28 Days'

# Use grep to pull only the 8:00 a.m. readings, because once 
# per hour for two weeks is too much, but once daily is very nice.
# Use cut to remove the date/time portion because now it isn't needed
# Store result back into $txt
grep 'T08:00:00-' $txt | cut -c 1-25 --complement > $temp 
mv "$temp" "$txt"
cat "$txt" | spark # display the data in a sparkline

# safely find and delete any xml files older than 1 day
find . -wholename "$search" -mtime +1 -delete 

#!/bin/bash

# This script pulls a dynamic XML file from https://waterservices.usgs.gov which contains river gauge information for one gauge. 
# If you want to pull a different gauge, you need to, at minimum, change the value in "&sites=" in the URL to the resource ID for 
# the gauge you want to use. You may also need to modify the site type. In this file, it is set to "ST" for "Stream".

# grab the xml document and save it locally
wget -q -O gauge.xml 'https://waterservices.usgs.gov/nwis/iv/?format=waterml,2.0&sites=07374510&period=P2W&parameterCd=00065&siteType=ST&siteStatus=all'

# Use xml_grep to pull just the data we want - the date/time and the gauge readings
xml_grep "wml2:MeasurementTVP" gauge.xml --text_only > gauge.txt

# Prepend some descriptive text
echo 'Carrollton Gauge Last 14 Days'

# Use grep to pull only the 8:00 a.m. readings, because once per hour for two weeks is too much, but once daily is very nice.
# Use cut to remove the date/time portion because now it isn't needed
# Pipe the result to spark
grep 'T08:00:00-' gauge.txt | cut -c 1-25 --complement | spark

#!/usr/bin/bash -x

OLDIFS=$IFS                   #preserve the default IFS
IFS=';'                       #set IFS to use ; 

one=$RANDOM                   #Roll die 1
one="$(($one % 20))"
echo "First Roll: $one"       #Output result of die 1
two="$(($RANDOM % 20))"	      #Roll die 2	
if [ "$one" == "$two" ];       #Check to make sure die 2 is different
then			      #Display an error message and increment by one
echo "oops, I rolled the same number twice!"
$two++
fi
echo "Second Roll: $two"      #Display the result of die 2
p="p"
first=$(sed -n "$one$p" < activities.csv) #Display the corresponding line in the file
second=$(sed -n "$two$p" < activities.csv) #Display the corresponding line in the file
echo $first
echo $second
year=$(date +%Y)
month=$(date +%m)
day=$(date +%d)
date=$year$month$day

s="s/^......../$date/"
one=$one$s
two=$two$s
cat activities.csv | sed -iE "$one" activities.csv #overwrite last date for act 1 with today's date
cat activities.csv | sed -iE "$two" activities.csv #overwrite last date for act 2 with today's date
cat activities.csv | sort -o activities.csv
cp activities.csv ~/scripts/archive/activities$date.csv
IFS=$OLDIFS

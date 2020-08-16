#!/usr/bin/bash -x

OLDIFS=$IFS                   #preserve the default IFS
IFS=';'                       #set IFS to use ; 
date=$(date +"%Y%m%d")
# set some file path variables
act=("$HOME"/scripts/activities/activities.csv)
archive=("$HOME"/scripts/activities/activities"$date".csv)

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
first=$(sed -n "$one$p" "$act") # Display the corresponding line in the file
second=$(sed -n "$two$p" "$act") # Display the corresponding line in the file
echo $first
echo $second

s="s/^......../$date/" # Replacement pattern for the date string
one=$one$s # Replace the date on $one
two=$two$s # Replace the date on $two
cat "$act" | sed -iE "$one" "$act" # overwrite last date for act 1 with today's date
cat "$act" | sed -iE "$two" "$act" # overwrite last date for act 2 with today's date
cat "$act" | sort -o "$act" # sort the file from oldest to newest
cp "$act" "$archive" # save an archive copy with today's date
IFS=$OLDIFS

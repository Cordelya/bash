#!/usr/bin/bash

# ========= #
# Functions #
# ========= #

new() {
 # this function to be invoked if activities.csv isn't found 
    echo "An activities.csv file was not found."
    read -p "Would you like to create one now? (y/N)" yn
# if they respond yes, create the file
      case $yn in
        [Yy]* ) touch $act ; return ;;
        [Nn]* ) echo "activities.csv wasn't found. Exiting."
                exit ;;
        * ) exit ;;
      esac
}
add() {
# this function to be invoked if activities.csv has 0 lines
# or when a user passes the -a flag when invoking the script
if $findempty
  then read -r -n 8 $olddate < $act
fi

read "What activity would you like to add?" $new
echo "$olddate;$new" >> $act
while true; do
  read "Add another activity? (y/N)" yn
case $yn in
  [Yy]* ) read "What activity would you like to add?" $new
    echo "$olddate;$new" >> $act
    read "Got it! Add another activity?" yn ;;
  [Nn]* ) break;;
  * ) break;;
esac
done
# sort the file in case we were adding to a file with previous lines
cat "$act" | sort -o "$act" 
return

}

OLDIFS=$IFS                   #preserve the default IFS
IFS=';'                       #set IFS to use ; 
date=$(date +"%Y%m%d")
# set some file path variables
path=("$HOME"/scripts/activities/)
act=("$HOME"/scripts/activities/activities.csv)
archive=("$HOME"/scripts/activities/activities"$date".csv)

# ================ #
#   Housekeeping   #
# ================ #

# Does activities.csv exist?
$find="find . -name $path 'activities.csv'"
case "$find" in
  0 ) return ;;
  1 ) new ;;
esac 

# Does activities.csv have any lines
findempty="find . -name $path 'activities.csv' -empty"
case "$findempty" in
  0 ) echo "Your activities.csv file is empty";
      read "Would you like to add some activities?" yn ;
      case "$yn" in
        [Yy]* ) add ;;
        [Nn]* ) echo "I can't continue without data. Exiting." ; exit ;;
        * ) echo "I can't continue without data. Exiting."; exit  ;;
      esac
      ;;
  1 ) return ;;
esac

# Were any options passed when this script was invoked?
while getopts ":a" opt; do
  case ${opt} in
    a ) add ;;
    \?) echo "Usage: cmd [-a add]" ;;
  esac
done

# ============ #
#  The Script  #
# ============ # 

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

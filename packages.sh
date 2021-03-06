#!/bin/bash

# Updates the list of installed packages that are not part of the base Ubuntu release
# The manifest version needs to be verified occasionally to make sure that it reflects the current version
# Based on a snippet found at https://unix.stackexchange.com/questions/3595/list-explicitly-installed-packages/3624#3624

#-------------------------------------#
#             FUNCTIONS               #
#-------------------------------------#
manifest() {
  if test ! -e "$default";
  then
    echo "Fetching the manifest! Hang on a sec.."
    wget -qO- $url | cut -f1 | sort -u > $default
  fi
}

# Set the target directory for files and specify filenames
dir=$HOME"/scripts/packages/"
loc=$dir'local.txt'
default=$dir'default.txt'
custom=$dir'packages.txt'
temp=$dir'temp.txt'
url='https://releases.ubuntu.com/20.04/ubuntu-20.04.1-desktop-amd64.manifest'
date=$(date +%Y-%m-%d)

# First we ask aptitude to make a list of all currently installed packages
aptitude search '~i !~M' -F '%p' --disable-columns | sort -u > $loc

# Look for existing copy of the manifest; fetch the current manifest if none
# found
manifest

# Then we compare the two files and produce a third file which only includes packages unique to the local system
comm -23 $loc $default > $custom 
# Add a note to the top of the filtered list
echo 'Post-install Software Manifest built on' $date | cat - $custom > $temp && mv $temp $custom

# File cleanup because we no longer need these
rm $loc

echo "Based on Ubuntu 20.04.1 Desktop AMD-64 Manifest." 
echo "If using a later version of Ubuntu, please update this script with an"
echo "updated manifest url."


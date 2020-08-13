!/bin/bash

# Updates the list of installed packages that are not part of the base Ubuntu release
# The manifest version needs to be verified occasionally to make sure that it reflects the current version

# First we ask aptitude to make a list of all currently installed packages
aptitude search '~i !~M' -F '%p' --disable-columns | sort -u > currentlyinstalled.txt

# Then we fetch the current manifest and store that locally
wget -qO - https://releases.ubuntu.com/20.04/ubuntu-20.04.1-desktop-amd64.manifest \  | cut -f1 | sort -u > defaultinstalled.txt

# Then we compare the two files and produce a third file which only includes packages unique to the local system
comm -23 currentlyinstalled.txt defaultinstalled.txt > custompackages.txt

# File cleanup because we no longer need these
rm currentlyinstalled.txt
rm defaultinstalled.txt

echo "Based on Ubuntu 20.04.1 Desktop AMD-64 Manifest. If we are using a later version, update this script with an updated manifest url"


#!/bin/bash

#checking to see if lxd is installed. if not, it will be installed.

if [ $(dpkg-query -W -f ='${Status}' lxd 2>/dev/null | grep -c "lxd is Installed") -eq 1 ]; then
	echo "lxd does not exist. Installing..."
	snap install lxd;
else
	echo "lxd exists. Proceeding.."
fi

#checking to see if a lxdbr0 interface exists. if not, it will be created.

if ip address | grep -q "lxdbr0"; then
	echo "lxdbr0 interface exists. Proceeding.."
else
	echo "Creating lxdbr0 interface.."
	lxd init --auto
fi

#check to see if COMP2101-S22 container alredy exists. if not, it will be created

if lxc list | grep -q "COMP2101-S22"; then
	echo "Container exists. Proceeding..."
else
	echo"Creating container COMP2101-S22"
	lxc launch ubuntu:22.04 CMP2101-S22
fi

#check if a /etc/hosts entry for COMP2101-S22 already exists, If not, create one,

if sudo cat  /etc/hosts |  grep -q "COMP2101-S22"; then
	echo "Entry exists. Proceeding.."
else
	echo "Creating an entry.."
	sudo echo $(lxc list "COMP2101-S22" -c 4 | awk '!/IPV4/{ if ( $2 != " " ) print $2}')"           COMP2101-S22" >> /etc/hosts
	echo "Done."
fi

#install apache2 into the container if it hasn't been,


sudo lxc exec COMP2101-S22 -- apt install apache2


#finally we check if the webserver is running or not by retrieving a webpage from the server.

if curl "http://COMP2101-S22" > HTML_Output; then
	echo "Webpage retrieved successfully. Server is running."
else
	echo "Couldn't retrieve the file from the server. Check for issues."
fi


 

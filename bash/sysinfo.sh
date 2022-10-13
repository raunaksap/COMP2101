#!/bin/bash

#introduction to report
echo "Report for "$(hostname)
echo " "

echo "------------------------------"
#for FQDN
echo "FQDN: " $(hostname --fqdn)
echo ""

#for system OS, version and kernel

echo "System OS: " $(uname)
echo $(hostnamectl | sed -n 7p)
echo "Distro version: "$(uname -r)
echo ""

#for system IP address

echo "IP Addresses: "$(hostname -I)
echo ""

#storage info for root

echo "Root system available disk size: "$(df -h / --output=avail | tail -n 1)
echo "------------------------------"
echo " "

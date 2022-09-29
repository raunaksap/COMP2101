#!/bin/bash

#for FQDN
echo "FQDN: " $(hostname --fqdn)
echo ""

#for system OS, version and kernel

echo "System OS: " $(uname)
echo "Distro: "$(uname -v)
echo "Distro version: "$(uname -r)
echo ""

#for system IP address

echo "IP Addresses: "$(hostname -I)
echo ""

#storage info for root

echo "Root system info: "
echo $(df -h | sed -n 1p)
echo $(df -h | sed -n 3p)


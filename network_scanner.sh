#!/bin/bash

#making an network scanner 

network_ip=$( ip addr show eth0 | grep inet -w -m 1 | awk -F" " {' print$2 '} | awk -F"." {' print $1"."$2"."$3 '})

echo -n "Starting IP: $network_ip."
read startip
echo -n "Ending IP: $network_ip."
read endip

echo -n "Searching devices from $network_ip.$startip-$endip"

for (( i=startip; i<=endip ; i++ ));do
	ping -c 1 -w 1 "$network_ip.$i"
done


echo "Current arp cache:"
arp -e

echo "seach complete...File Saved"
arp -e | grep -v incomplete > /home/sahil/Desktop/network_scanner/arp_cache_$(date +%F)

echo "Would you like to renove the incomplete entries form arp cache(y/n)"
read choice

if [ $choice = y ];then
	clear
	echo "updated arp cache"
	grep -v address /home/sahil/Desktop/network_scanner/arp_cache_$(date +%F) | awk -F" " {' print $1" "$3 '} > /home/sahil/Desktop/network_scanner/update
	ip -s neigh flush all
	arp -f /home/sahil/Desktop/network_scanner/update
	rm /home/sahil/Desktop/network_scanner/update
	arp -e
fi           







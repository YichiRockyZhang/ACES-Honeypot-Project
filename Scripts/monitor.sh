#!/bin/bash

ct_num=$1

if [ $ct_num -eq "103" ]; then
	ct_ip="172.20.0.4"
	d_port="10002"
fi

if [ $ct_num -eq "104" ]; then
	ct_ip="172.20.0.3"
	d_port="10001"
fi

if [ $ct_num -eq "101" ]; then
	ct_ip="172.20.0.2"
	d_port="10000"
fi

if [ $ct_num -eq "102" ]; then
	ct_ip="172.20.0.5"
	d_port="10003"
fi

while read a
do

	# Monitor for login event
	accepted_line=$(echo "$a" | grep "sshd" | grep "Accepted password for")

	if [ ! -z "$accepted_line" ]; then
		sleep 1

		# Extract IP address
		ip_addr=$(tail -n1 /root/MITM_data/logins/$ct_num.txt | cut -d";" -f2)
		date >> ~/logs/plain$ct_num.log
		echo "New connection from $ip_addr" >> ~/logs/plain$ct_num.log
		echo "$(date --rfc-3339=ns | cut -c -23) - [Ports] $(cat
		~/recycling_scripts/port$ct_num.txt)" >> ~/logs/mitm$ct_num.log

		# Allow only the attacker in the container for the duration of attack
		iptables --table filter --insert INPUT 1 --protocol tcp --source $ip_addr --destination
		172.20.0.1 --destination-port $d_port --jump ACCEPT
		iptables --table filter --insert INPUT 2 --protocol tcp --source 0.0.0.0/0 --destination
		172.20.0.1 --destination-port $d_port --jump DROP
		/root/recycling_scripts/wait.sh $ct_num $ip_addr &
		exit
	fi
done
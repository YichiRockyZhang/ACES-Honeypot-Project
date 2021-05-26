#!/bin/bash

ct_num=$1
ip_addr=$2

# Wait time
WAIT_TIME=300

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

# Wait for specified amount of time
echo "Started waiting for timeout on container $ct_num"
sleep $WAIT_TIME

# Check to see if malware.sh was created; if it was, block the user
# ct_files=$(ls -1 /var/lib/lxc/$ct_num/rootfs/root/)
# if echo $ct_files | grep "malware.txt"; then
# Permanently block attacker
pct exec $ct_num -- killall sshd
iptables --table filter --insert INPUT 1 --protocol tcp --source $ip_addr --destination 172.20.0.1 --destination-port $d_port --jump DROP
echo "Blocked attacker for ip $ip_addr" >> ~/logs/plain$ct_num.log

# Delete previously created rules
iptables --table filter --delete INPUT --protocol tcp --source $ip_addr --destination 172.20.0.1 --destination-port $d_port --jump ACCEPT
iptables --table filter --delete INPUT --protocol tcp --source 0.0.0.0/0 --destination 172.20.0.1 --destination-port $d_port --jump DROP

echo "Beginning recycle of $ct_num" >> ~/logs/plain$ct_num.log
/root/recycling_scripts/recycle.sh $ct_num &
exit
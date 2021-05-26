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

#Kill currently running tail process
kill -9 $(ps aux | grep "tail -n 0 -F /var/lib/lxc/$ct_num/rootfs/var/log/auth.log" | awk '{print $2}')
kill -9 $(ps aux | grep "tail -n 0 -F ~/logs/mitm$ct_num.log" | awk '{print $2}')
kill  $(ps aux | grep node | grep $ct_num | awk -F' ' '{print$2}')
kill -9 $(ps aux | grep "openPorts.sh $ct_num" | awk '{print$2}')
sleep 10

echo -n $({ cat ~/recycling_scripts/port$ct_num.txt}) >> ~/logs/port_data.log
echo -n " " >> ~/logs/port_data.log
echo $(ls -lt ~/MITM_data/sessions/ | head -n2 | awk '{print $9}'|cut -b -36) >> ~/logs/port_data.log

echo -n $ct_num >> ~/logs/port_data_better.log
echo -n " " >> ~/logs/port_data_better.log
echo -n $(cat ~/recycling_scripts/port$ct_num.txt) >> ~/logs/port_data_better.log
echo -n " " >> ~/logs/port_data_better.log
echo $(tail -1 ~/MITM_data/logins/$ct_num.txt) >> ~/logs/port_data_better.log

# Unmount container
pct unmount $ct_num
# Stop container
pct unlock $ct_num
pct stop $ct_num --skiplock 1
# Unmount container
pct unmount $ct_num
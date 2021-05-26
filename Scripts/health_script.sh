#!/bin/bash

date > "health.log"

#Host data
free --mega | grep 'Mem:' | awk '{print $4}' >> "health.log"
df -m | grep /dev/mapper/pve-root | awk {'print $4'} >> "health.log"
uptime | awk 'NF>1{print $NF}' >> "health.log"
ifconfig | grep enp4s2 -A 7 | grep "RX packets" | awk '{print int($5/1024)}' >> "health.log"
ifconfig | grep enp4s2 -A 7 | grep "TX packets" | awk '{print int($5/1024)}' >> "health.log"

#C-101
pct exec 101 -- free --mega | grep 'Mem:' | awk '{print $4}' >> "health.log"
pct exec 101 -- df -m | grep /dev/mapper/pve-vm--101--disk--0 | awk {'print $4'} >> "health.log"
pct exec 101 -- uptime | awk 'NF>1{print $NF}' >> "health.log"
pct exec 101 -- ifconfig | grep eth0 -A 7 | grep "RX bytes" | awk '{print $2}' | cut -c7- | awk '{print int($1/1024)}' >> "health.log"
pct exec 101 -- ifconfig | grep eth0 -A 7 | grep "TX bytes" | awk '{print $6}' | cut -c7- | awk '{print int($1/1024)}' >> "health.log"

#C-102
pct exec 102 -- free --mega | grep 'Mem:' | awk '{print $4}' >> "health.log"
pct exec 102 -- df -m | grep /dev/mapper/pve-vm--102--disk--0 | awk {'print $4'} >> "health.log"
pct exec 102 -- uptime | awk 'NF>1{print $NF}' >> "health.log"
pct exec 102 -- ifconfig | grep eth0 -A 7 | grep "RX bytes" | awk '{print $2}' | cut -c7- | awk '{print int($1/1024)}' >> "health.log"
pct exec 102 -- ifconfig | grep eth0 -A 7 | grep "TX bytes" | awk '{print $6}' | cut -c7- | awk '{print int($1/1024)}' >> "health.log"

#C-103
pct exec 103 -- free --mega | grep 'Mem:' | awk '{print $4}' >> "health.log"
pct exec 103 -- df -m | grep /dev/mapper/pve-vm--103--disk--0 | awk {'print $4'} >> "health.log"
pct exec 103 -- uptime | awk 'NF>1{print $NF}' >> "health.log"
pct exec 103 -- ifconfig | grep eth0 -A 7 | grep "RX bytes" | awk '{print $2}' | cut -c7- | awk '{print int($1/1024)}' >> "health.log"
pct exec 103 -- ifconfig | grep eth0 -A 7 | grep "TX bytes" | awk '{print $6}' | cut -c7- | awk '{print int($1/1024)}' >> "health.log"

#C-104
pct exec 104 -- free --mega | grep 'Mem:' | awk '{print $4}' >> "health.log"
pct exec 104 -- df -m | grep /dev/mapper/pve-vm--104--disk--0 | awk {'print $4'} >> "health.log"
pct exec 104 -- uptime | awk 'NF>1{print $NF}' >> "health.log"
pct exec 104 -- ifconfig | grep eth0 -A 7 | grep "RX bytes" | awk '{print $2}' | cut -c7- | awk '{print int($1/1024)}' >> "health.log"
pct exec 104 -- ifconfig | grep eth0 -A 7 | grep "TX bytes" | awk '{print $6}' | cut -c7- | awk '{print int($1/1024)}' >> "health.log"

#!/bin/bash

ctnum=$1
random=$2
i=0
currentPort=0;
portCount=0;
lineCount=0;

cp /dev/null port.txt
python3 genPortFile.py

if [ $random -eq 1 ]
then
    portCount=0
elif [ $random -eq 2 ]
then
    portCount=25
elif [ $random -eq 3 ]
then
    portCount=50
elif [ $random -eq 4 ]
then
	portCount=100
fi

#print to a text file
echo $portCount > ~/recycling_scripts/port$ctnum.txt

while [ $i -lt $portCount ]
do
	lineCount=$(($i+1))
	currentPort=$(sed -n "$lineCount p" ~/recycling_scripts/port.txt)
	pct exec $ctnum -- ncat -l $currentPort --keep-open --exec "/bin/cat" & >> ~/logs/err$ctnum.log
	i=$(($i+1))
done
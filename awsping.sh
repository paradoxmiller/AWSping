#!/bin/bash
# This script will query the Public DNS Names of AWS instances
# It will save them to a list 'ec2list.txt' and then ping them

aws ec2 describe-instances --query 'Reservations[*].Instances[*].[PublicDnsName]' --output text >ec2list.txt

cat ~/ec2list.txt | while read output
do
	ping -c 1 "$output" > /dev/null
	if [ $? -eq 0 ]; then
		setterm -term linux -back black -fore green
		echo "$output responds to ping"
	else
		setterm -term linux -back white -fore red		
		echo "$output is NOT responding"
	fi
tput sgr0
done

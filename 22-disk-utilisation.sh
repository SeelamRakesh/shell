#!/bin/bash

DISK_USAGE=$(df -hT | grep -v Filesystem)
USAGE_THRESHOLD=3

while IFS= read -r line
do
    USAGE=$(echo $line | awk '{print $6}' | cut -d '%' -f1)
    PARTITION=$(echo $line | awk '{print $7}')

    if [ $USAGE_THRESHOLD -gt $USAGE ]; then
      MESSAGE+="High Disk Usage on $PARTITION: $USAGE% <br>"
    fi
done <<< $DISK_USAGE

echo -e "$MESSAGE"

sh mail.sh "rakeshgautam602@gmail.com" "High Disk Usage Alert on $IP_ADDRESS" "$MESSAGE" "HIGH_DISK_USAGE" "$IP_ADDRESS" "DevOps Team"
#!/bin/bash

DISK_USAGE=$(df -hT | grep -v Filesystem)
USAGE_THRESHOLD=3

while IFS= read -r line
do
   USAGE=$(grep -v $line | awk '{print $6}' | cut -d '%' -f1)
   PARTITION=$(grep -v $line | awk '{print $7}')
   echo "USAGE"
   echo "PARTITION"
done <<< $DISK_USAGE



# DISK_USAGE=$(df -hT | grep -v Filesystem)
# USAGE_THRESHOLD=3

# while IFS= read -r line
# do
#     USAGE=$(echo $line | awk '{print $6}' | cut -d "%" -f1)
#     PARTITION=$(echo $line | awk '{print $7}')

#     if [ "$USAGE" -ge "$USAGE_THRESHOLD" ]; then
#         MESSAGE+="High Disk usage on $PARTITION: $USAGE% <br>"
#     fi
# done <<< $DISK_USAGE

# echo -e "$MESSAGE"
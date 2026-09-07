#! /bin/bash

START_TIME=$(date +%s)
echo "script executed at $START_TIME"

sleep 10

END_TIME=$(date +%s)
echo "script execution ended at $END_TIME"

TOTAL_TIME=$(($END_TIME - $START_TIME))
echo "script executed in $TOTAL_TIME"

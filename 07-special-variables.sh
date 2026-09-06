#!/bin/bash

echo "all variables passed to script: $@"
echo "number of variables passed to script: $#"
echo "script name: $0"
echo "present working directory: $PWD"
echo "user running the script: $USER"
echo "current home directory: $HOME"
echo "process instance ID of current process: $$"
sleep 10 &
echo "background PID: $!"
echo "exit code of previous command: $?"
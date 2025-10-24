#!/bin/bash

#Create a temporary log file /tmp/bw.log
LOG_FILE="/tmp/bw.log"

#Generate the random traffic for bw.log
gen_traffic(){
  while true; do
    # Get the current network traffic in KB/s
    TRAFFIC=$(ifstat -i en0 1 1 | awk 'NR==3){print $1}')
    echo "$TRAFFIC" >> "$LOG_FILE"
    sleep 1
  done
}

# Clean up the log file on exit
file_cleanup(){
  rm -f "$LOG_FILE"
  exit 0
}
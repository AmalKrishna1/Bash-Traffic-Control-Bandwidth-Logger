#!/bin/bash

#Create a temporary log file /tmp/bw.log
LOG_FILE="/tmp/bw.log"

#Generate the random traffic for bw.log
gen_traffic(){
  while true; do
    # Get the current network traffic in KB/s
    #ifstat command is used to get the network traffic
    # The interface 'en0' is based on system "MAC"
    # 1 1 means to sample once every second for one time
    TRAFFIC=$(ifstat -i en0 1 1 | awk 'NR==3 {print $1}')
    echo "$TRAFFIC" >> "$LOG_FILE"
    sleep 1
  done
}

# Clean up the log file on exit
file_cleanup(){
  rm -f "$LOG_FILE"
  exit 0
}

# Trap SIGINT and SIGTERM to clean up the log file
trap file_cleanup SIGINT SIGTERM

# Start generating traffic in the background
gen_traffic &
GEN_PID=$!

for i in {1..6}; do
  sleep 10
  TRAFFIC=$(tail -n 1 "$LOG_FILE")
  TIMESTAMP=$(date "+%H:%M:%S")
  printf "%s: current traffic = %s KB/s \n" "$TIMESTAMP" "$TRAFFIC"
done

kill $GEN_PID
file_cleanup
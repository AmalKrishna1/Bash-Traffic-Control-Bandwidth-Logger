#!/bin/bash

#Create a temporary log file /tmp/bw.log
LOG_FILE="/tmp/bw.log"

#Generate the random traffic for bw.log
gen_traffic(){
  while true; do
    # Simulate traffic between 100 and 1099 KB/s
    TRAFFIC=$((RANDOM % 1000 + 100))
    # Append traffic to log file
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

# Human Readable traffic showing current time and simulated traffic values
for i in {1..6}; do
  sleep 10 # Wait for 10 seconds
  TRAFFIC=$(tail -n 1 "$LOG_FILE") # Get the last traffic value that was written into the log file
  TIMESTAMP=$(date +"%H:%M:%S")
  printf "%s: current traffic = %s KB/s \n" "$TIMESTAMP" "$TRAFFIC" # Print the human-readable output
done

kill $GEN_PID # Stop the background traffic generation
file_cleanup # Clean up the log file on exit
#!/usr/bin/env bats

setup(){
  export LOG_FILE="/tmp/bw.log"
}

teardown(){
  rm -f "$LOG_FILE"
}

@test "LOG FILE is successfully created" { 
  # run the bwlog.sh script in the background
  run bash bwlog.sh &
  # time to creat the log file
  sleep 5
  # check if the log file exists
  [ -f "$LOG_FILE" ]
  kill $!
}

@test "LOG FILE has written traffic data" {
  run bash bwlog.sh &
  sleep 5
  # check if the log file has data written from the simulated traffic
  [-s "$LOG_FILE" ]
  kill $!
}
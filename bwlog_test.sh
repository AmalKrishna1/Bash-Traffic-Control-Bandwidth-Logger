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
  [ -s "$LOG_FILE" ]
  kill $!
}

@test "LOG FILE simulated traffic data are valid numbers" {
  run bash bwlog.sh &
  sleep 15

  # -q = suppressed output to the terminal, so no unnecessary output is shown
  # -v = invert the match, so we are looking for lines that do NOT match the pattern
  # -E = use extended regular expressions
  # [^0-9]+$ = ^ represents start of the line, 0 - 9 represents any digit, + means one or more of the preceding element, $ represents end of the line
  # (\.[0-9]+)?$ = matches optional decimal point followed by one or more digits
  # -qvE = combining the logic above, this command checks if there are any lines in the LOG_FILE that do NOT consist solely of digits (0-9)
  if grep -qvE '^[0-9]+(\.[0-9]+)?$' "$LOG_FILE"; then
    kill $!
    echo "LOG FILE contains invalid traffic data"
  fi

  kill $!
}

@test "Output to the terminal is in HH:MM:SS: current traffix = XXXX KB/s format" {
  run bash bwlog.sh &
  sleep 65
  
  #Fill In the rest

}

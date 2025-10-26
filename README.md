# Bash-Traffic-Control-Bandwidth-Logger

**A bash script that simulates and logs network traffic**

**Motivation:** Simulating and logging bandwidth usage is a key step towards implementing the Cybercafe's traffic control features, which are essential for monitoring and enforcing fair usage policies. This directly informs user stories focused on providing transparent usage data to users and administrators.

## Features:

- **Simulated Network Traffic:** The program creates random simulated traffic values.
- **Background Processes:** Simulated traffic generation runs in the background.
- **Human-Readable Network Output:** Current network traffic is displayed every ten seconds in a minute period for easy monitoring.
- **File Cleanup:** Upon completion or interruption, temporary log file is removed.

## Getting Started:

### Prerequisites:

- A bash environment is required to run the given script on Windows
- The script can be run on Linux of MacOS using a Bash shell

### Initial Setup:

1. Clone the repository or download the 'bwlog.sh' script to your machine
2. **Make the script executable:**
   '''Bash
   chmod +x bwlog.sh

### Running the Script:

Execute the script in the terminal:

```Bash
./bwlog.sh
```

**Note:** The script runs for a one minute period. Every ten seconds, there will be an output to terminal of current network traffic.

#### Sample Expected Output:

```Code
14:49:13: current traffic = 425 KB/s
14:49:23: current traffic = 594 KB/s
14:49:33: current traffic = 581 KB/s
14:49:43: current traffic = 1059 KB/s
14:49:53: current traffic = 0.00 KB/s
14:50:03: current traffic = 0.99 KB/s
```

#### How to view the LOG FILE:

While the script is running the following command will show generated traffic in the LOG File -
`tail -f /tmp/bw.log`

## Program Flow:

1. **LOG FILE Creation:** A temporary log file is created at `/tmp/bw.log` to store the simulated traffic data.
2. **Simulated Traffic Generation:** The `gen_traffic` bash fucntion is a background process that is initiated to generate traffic data.
3. **Traffic Monitoring:** The script runs for a one minute period. Every ten seconds, the script reads the most recent line from the log file.
4. **File Cleanup:** Once the script is complete or interrupted the LOG FILE is cleaned up. The `trap` is created to ensure the file is removed even upon interruption.

## Important Pieces of the Script:

- **Background Processes (`&`):** Background processes allow the main script to continue with execution. Looking at the current script this prevents issues such as infinite looping.
- **FILE I/O:** `>>` helps with appending data to a file, `tail` helps with reading the last lines of a file
- **Arithmetic Expension (`$(...)`):** Performs calculations within the shell and provides easy attribution to 'variables'
- **Formatted Output (`printf`):** Displays the strings in user-defined format. This is used in the current sprint for substition of attributes `TIMESTAMP` and `TRAFFIC`
- **Temporary LOG FILES:** Temporary files like `/tmp/bw.log/` are used for data storage during script execution but NOT after.
- **Trapping(`trap`):** Assists the system for graceful termination. In the script ensures proper cleanup occurs upon termination of script.

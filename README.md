# Bash-Traffic-Control-Bandwidth-Logger
Motivation: Simulating and logging bandwidth usage is a key step towards implementing the CyberCafe's traffic control features, which are essential for monitoring and enforcing fair usage policies. This directly informs user stories focused on providing transparent usage data to users and administrators.

## Acceptance Criteria:
- A functional `bwlog.sh` script is committed to the team's repository.
- The script generates a temporary file (`/tmp/bw.log`) with random traffic values in the background.
- It reads the last value from `/tmp/bw.log` every 10 seconds.
- It prints a human-readable line showing the current time and traffic value (e.g., "HH:MM:SS: current traffic = XXXX KB/s").
- The script stops after 1 minute (6 iterations) and cleans up the temporary file.
- A 1-page cheat sheet or documentation explaining background jobs (`&`), `tail`, arithmetic, `printf`, and temporary files is added to the team's wiki/repo.

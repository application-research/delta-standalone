# Delta Standalone Installer

This repo provides scripts to set up a standalone instance of Delta quickly and easily.
## Prerequisites
Please ensure the following are installed before beginning.

- Go v1.19 or greater (https://go.dev/doc/install)
- Nodejs v1.18 or greater (https://nodejs.org/en/download/)
- Rust v1.49 or greater (https://www.rust-lang.org/tools/install)
- Git (https://git-scm.com/downloads)


## Quick-start
Run everything in one command using the boostrapper gist. This will set everything up for you in a directory called `delta-standalone`. No additional steps required.

```bash
curl -s https://gist.githubusercontent.com/jcace/66d3c733c58cc53c2c692af547c875c7/raw/delta-standalone-bootstrap.sh?_=$(uuidgen) \
| bash
```

 > or, run the script contained in this repo `./install.sh` 
Make sure you save the **API KEY** output as you'll need it to interact with Delta

```bash
| obtaining a new api key
| your DELTA API key is: ESTXXX-XXX-XXXARY # <- Save this ! 
| >> Please save this key for future requests
```

Then, access the Delta UI at `http://localhost:3000` 

## Updating
Run the script `./delta-standalone/update.sh` to update all repositories to the latest version. It will also rebuild and restart the services. 


## Stopping Delta Standalone
`./stop.sh`

## Restarting Delta Standalone
`./start.sh`

## Important Files
- `delta.env` contains the exported Delta API key. Back up this file. When running any Delta command-line operations, source this file first i.e `source delta.env` 
- `delta-dm.db` is the sqlite db file for Delta DM. Ensure this file is backed up!
- `delta.db` is the sqlite db file for Delta. Ensure this file is backed up!

## Default URLs
- Delta: http://localhost:1414
- Delta-DM: http://localhost:1314
- Delta-DM frontend: http://localhost:3000


## Troubleshooting
### Check if apps are running
`ps -aux | grep delta`

You should see three processes running - `delta`, `delta-dm` and `delta-nextjs-client`
```bash
root     3540536 1013  0.0 8625752 654032 pts/1  Sl   14:46   5:03 ./delta/delta daemon --mode=standalone
root     3540835  0.1  0.0 1167796 20312 pts/1   Sl   14:46   0:00 ./delta-dm/delta-dm daemon
root     3540908  7.2  0.0 11134732 73124 pts/1  Sl   14:46   0:00 node /mnt/mnt_2/delta-standalone/delta-nextjs-client/node_modules/.bin/next start
```
# Delta Standalone Installer

## Prerequisites

- Go v1.19 or greater (https://go.dev/doc/install)
- Nodejs v1.18 or greater (https://nodejs.org/en/download/)
- Rust v1.49 or greater (https://www.rust-lang.org/tools/install)
- Git (https://git-scm.com/downloads)


## Installation
Run the install script `install.sh` . This will clone all repositories, then build and run them.

It will also generate an API key and output it to the terminal. Save this API key as you'll need it when interacting with Delta.

## Important Files
- `delta.env` contains the exported Delta API key. Back up this file as you'll need this key to 
- `delta-dm.db` is the sqlite db file for Delta DM. Ensure this file is backed up!
- `delta.db` is the sqlite db file for Delta. Ensure this file is backed up!

## Updating
Run the script `update.sh` to update all repositories to the latest version. It will also rebuild and restart the services. 

#!/bin/bash
echo "| starting apps"
echo "| please wait - this will take a few seconds"

DELTA_ENV=delta.env
source $DELTA_ENV

nohup ./delta/delta daemon --mode=standalone >/dev/null 2>&1 &
sleep 20
nohup ./delta-dm/delta-dm daemon >/dev/null 2>&1 &
sleep 5
cd ./delta-ui && nohup npm run start >/dev/null 2>&1 &

echo "| apps started"

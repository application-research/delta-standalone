#!/bin/bash
echo "| starting apps"
echo "| please wait - this will take a few seconds"

DELTA_ENV=./delta.env
export $(grep -v '^#' $DELTA_ENV | xargs)

nohup ./delta/delta daemon --mode=standalone &
sleep 20
nohup ./delta-dm/delta-dm daemon >/dev/null 2>&1 &
sleep 5
cd ./delta-nextjs-client && nohup npm run start >/dev/null 2>&1 &

echo "| apps started"
#!/bin/bash
echo "| starting apps"

DELTA_ENV=delta.env
source $DELTA_ENV

nohup ./delta/delta daemon --mode=standalone >/dev/null &
sleep 20
nohup ./delta-dm/delta-dm daemon >/dev/null &
sleep 5
cd ./delta-nextjs-client && nohup npm run start >/dev/null &
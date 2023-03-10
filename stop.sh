#!/bin/bash
echo "| killing delta processes"
DELTA_PID=$(ps -h -o pid -C delta)
DDM_PID=$(ps -h -o pid -C delta-dm)
UI_PID=$(ps -ef | grep '[d]elta-nextjs-client' | awk '{print $2}')

kill $DELTA_PID
kill $DDM_PID
kill $UI_PID

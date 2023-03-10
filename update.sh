#!/bin/bash
DELTA_ENV=delta.env

echo "Δ Delta update"

source $DELTA_ENV

echo "| pulling latest changes"
(cd delta && git pull && make build >/dev/null 2>&1)
(cd delta-dm && git pull && make build >/dev/null 2>&1)
(cd delta-nextjs-client && git pull && npm install && npm run build >/dev/null 2>&1)


source ./stop.sh

source ./start.sh

echo "Δ Delta update complete!"
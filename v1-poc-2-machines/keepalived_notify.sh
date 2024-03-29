#!/bin/bash

set -e

# TODO: logfile handling; insecure permissions, rotation

ENDSTATE=$3
NAME=$2
# TYPE=$1 unused

HETZNER_USER='__username__'
HETZNER_PASS='__redacted__'
# Check the IP address based on instance $NAME
FAILOVER_IP="$NAME"
LOGFILE='/tmp/keepalived.log'

date >> "$LOGFILE"

echo "Executing Failover IP switch script for Hetzner Bare metal"
if [ "$ENDSTATE" == "MASTER" ] ; then
    HOST_IP=$(ip route get 8.8.8.8 | awk '{print $7 }')
    echo "setting Failover IP: $FAILOVER_IP to Server IP:  $HOST_IP" >> "$LOGFILE"
    curl -s -u "$HETZNER_USER:$HETZNER_PASS" "https://robot-ws.your-server.de/failover/$FAILOVER_IP" -d "active_server_ip=$HOST_IP" >> "$LOGFILE" 2>&1
fi

date >> $LOGFILE

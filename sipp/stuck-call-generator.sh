#!/bin/bash

set -o errexit
set -o nounset

cd $(dirname "$0")

SIPP_IP=127.0.0.1    # Trigger Asterisk localhost SIP peer for our sipp client
TARGET_IP=127.0.0.1  # From localhost to localhost
EXTEN=5555555555
SCENARIO=stuck-call-generator.xml
TOTAL_CALLS=${TOTAL_CALLS:-1}
CPS=${CPS:-1}
MAX_CONCURRENT=1


date
echo begin $CPS CPS
touch /tmp/timestamp$CPS
sipp -s $EXTEN -sf $SCENARIO -r $CPS -m $TOTAL_CALLS -l $MAX_CONCURRENT \
  -trace_err -trace_screen -trace_calldebug -trace_shortmsg \
  -trace_msg \
  -i $SIPP_IP -p 8836 $TARGET_IP \
  || echo SIPp failed with exit code $?
date
echo end $CPS CPS


pwd
find . -type f -newer /tmp/timestamp$CPS

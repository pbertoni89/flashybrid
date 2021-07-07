#!/bin/bash

# TODO something ?
# echo "XNEXT mountro..."
# /usr/sbin/mountro

logFn=/etc/xspectra/delay-mountro.txt
logFn=/dev/null  # PB why? Because broken? Checkout service's StandardOutput

function echo_log()  { echo -e "<XNEXT-DMRO-T> $(date) - ${*}"; }

echo_log "bye bye" | tee -a ${logFn}

exit 0

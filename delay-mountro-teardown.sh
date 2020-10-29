#!/bin/bash

# TODO something ?
# echo "XNEXT mountro..."
# /usr/sbin/mountro

logFn=/etc/xspectra/delay-mountro.txt
logFn=/dev/null

echo $(date) | tee -a ${logFn}
echo "XNEXT delay-mountro-teardown BYE BYE" | tee -a ${logFn}

exit 0

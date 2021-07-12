#!/bin/bash

logFn=/etc/xspectra/delay-mountro.txt
logFn=/dev/null  # PB why? Because broken? Checkout service's StandardOutput

function echo_log()  { echo -e "<XNEXT-DMRO-S> $(date) - ${*}"; }

# Forced iff ramstoring /dev. Cfr ramstore
# echo_log  " fixing devpts...."
# /usr/bin/umount /dev/pts                  | tee -a ${logFn}
# /usr/bin/mount devpts /dev/pts -t devpts  | tee -a ${logFn}

nDelay=1
date | tee -a ${logFn}

echo_log "sleeping ${nDelay}..." | tee -a ${logFn}
sleep ${nDelay}
unset nDelay

echo_log  "fusering..." | tee -a ${logFn}

/usr/bin/fuser -v -k -w -m /     2>&1 | tee -a ${logFn}

echo_log  "fusered ${?}. mountro..." | tee -a ${logFn}

/usr/sbin/mountro                2>&1 | tee -a ${logFn}

echo_log  "mountro return ${?}" | tee -a ${logFn}

/usr/bin/fuser -v -m       /     2>&1 | tee -a ${logFn}

echo_log  "bye bye" | tee -a ${logFn}

exit 0

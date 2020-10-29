#!/bin/bash


logFn=/etc/xspectra/delay-mountro.txt


# Forced iff ramstoring /dev. Cfr ramstore
echo "XNEXT fixing devpts...."
/usr/bin/umount /dev/pts                  | tee -a ${logFn}
/usr/bin/mount devpts /dev/pts -t devpts  | tee -a ${logFn}

nDelay=1
echo $(date) | tee -a ${logFn}
echo "XNEXT sleeping ${nDelay}..." | tee -a ${logFn}
sleep ${nDelay}
unset nDelay

echo "XNEXT fusering..." | tee -a ${logFn}

/usr/bin/fuser -v -k -w -m /     2>&1 | tee -a ${logFn}

echo "XNEXT fusered ${?}. mountro..." | tee -a ${logFn}

/usr/sbin/mountro                2>&1 | tee -a ${logFn}

echo "XNEXT mountro return ${?}" | tee -a ${logFn}

/usr/bin/fuser -v -m       /     2>&1 | tee -a ${logFn}

echo "XNEXT delay-mountro-setup bye bye" | tee -a ${logFn}

exit 0

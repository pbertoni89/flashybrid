#!/bin/bash

logFn=/mnt/data_ssd/dmro.txt
# logFn=/dev/null  # PB why? Because broken? Checkout service's StandardOutput

function dmro_echo() {
    echo -e "<DMRO> $(date) - ${*}" | tee -a ${logFn}
}


#
# COME SISTEMARE UN'INSTALLAZIONE DOVE AGGIUNGERE ECCEZIONI RAMSTORE ?
# https://www.cyberciti.biz/faq/howto-linux-get-list-of-open-files/
#
function dmro_test_fuser() {

    dmro_echo  "listing only"

    /usr/bin/fuser -v -m /     2>&1  |  grep Frc  # >> ${logFn}

    # adesso ho i PID che mi interessano, prendiamone uno e chiamiamolo `myPid`
    ls -l /proc/${myPid}/fd
    lsof -p ${myPid}  # piu' utile
}


#
# Return 0 if we CANNOT write on root filesystem (expected behaviour during boot). 1 otherwise
#
function dmro_test_write() {
    local touchFn=/a
    local lsFn=$(dirname ${touchFn})  # too much verbose
    lsFn=${touchFn}

    dmro_echo "*  *  *  *  *  *  *  *  *  *  *  *  *"
    ls -l ${lsFn} 2>&1 | tee -a ${logFn}

    if /usr/bin/touch ${touchFn}; then
        dmro_echo "touch success: test FAILURE"
        ls -l ${lsFn} 2>&1 | tee -a ${logFn}
        rv=1
    else
        dmro_echo "touch failure: test SUCCESS"
        rv=0
    fi

    if [[ -f ${touchFn} ]]; then
        dmro_echo "removing file"
        rm ${touchFn} 2>&1 | tee -a ${logFn}
        if [[ -f ${touchFn} ]]; then
            dmro_echo "removing file: FAILURE"
        fi
    fi

    return ${rv}
}

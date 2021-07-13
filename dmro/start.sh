#!/bin/bash


SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
	DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
	SOURCE="$(readlink "$SOURCE")"
	# if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
	[[ ${SOURCE} != /* ]] && SOURCE="$DIR/$SOURCE"
done

scriptDir="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
source ${scriptDir}/common.sh

rm ${logFn}  # clean file
dmro_echo "test_writing from service"
dmro_test_write
res=${?}
dmro_echo "test_write 1st returned ${res}"

if (( ${res} != 0 )); then

    # We used to pipe on | tee -a ${logFn} but `fuser` output pollutes the journal

    # Forced iff ramstoring /dev. Cfr ramstore
    # dmro_echo  " fixing devpts...."
    # /usr/bin/umount /dev/pts                  >> ${logFn} 2>&1
    # /usr/bin/mount devpts /dev/pts -t devpts  >> ${logFn} 2>&1

    sleepExecStartPre=8  # was in `ExecStartPre`, but it's useless to wait unconditionally
    dmro_echo "sleeping ${sleepExecStartPre}"
    sleep ${sleepExecStartPre}
    unset sleepExecStartPre

    dmro_echo  "fusering"

    /usr/bin/fuser -v -k -w -m /     >> ${logFn} 2>&1

    dmro_echo  "fusered ${?}. mountro"

    /usr/sbin/mountro                2>&1 | tee -a ${logFn}

    dmro_echo  "mountro return ${?}"

    /usr/bin/fuser -v -m       /     >> ${logFn} 2>&1

    dmro_test_write
    res=${?}
    dmro_echo "test_write 2nd returned ${res}"
fi

exit 0

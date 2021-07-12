#!/bin/bash

logFn=/mnt/data_ssd/xis-delay-mountro-test.txt
touchFn=/a

date +%T > ${logFn}

ls -l $(dirname ${touchFn}) >> ${logFn}

if /usr/bin/touch ${touchFn}; then
	echo "touch success: test failure" >> ${logFn}
	ls -l $(dirname ${touchFn}) >> ${logFn}
else
	echo "touch failure: test success" >> ${logFn}
fi

if [[ -f ${touchFn} ]]; then
	echo "removing file" >> ${logFn}
	rm ${touchFn}
fi

exit 0

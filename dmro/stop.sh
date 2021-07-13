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

# TODO something ?
# /usr/sbin/mountro

dmro_echo "stop just ran"

exit 0


#!/usr/bin/env bash

set -o errexit
set -o nounset

while :
do
    echo "Enter time zone/sub zone (e.g. America/Santiago):"
	read TIME_ZONE_SUB_ZONE
	if [[ -n "${TIME_ZONE_SUB_ZONE}" ]]; then
        timedatectl set-timezone "${TIME_ZONE_SUB_ZONE}"
		break
	fi
done

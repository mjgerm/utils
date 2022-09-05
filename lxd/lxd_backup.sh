#!/usr/bin/env bash
set -ex

BACKUP_DIR=/tank/backup/lxd
HOSTS=($(lxc list -c n --format csv))

for HOST in "${HOSTS[@]}"
do
    BACKUP_NAME=$(date +"%Y%m%d")-${HOST}
    lxc export ${HOST} ${BACKUP_DIR}/${BACKUP_NAME}.tar.gz
done

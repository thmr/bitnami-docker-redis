#!/bin/bash
. /opt/bitnami/base/functions
. /opt/bitnami/base/helpers

DAEMON=redis-server
USER=redis
EXEC=$(which $DAEMON)
ARGS="/opt/bitnami/redis/conf/redis.conf --daemonize no"

# log output to stdout
sed -i 's/^logfile /# logfile /g' /opt/bitnami/redis/conf/redis.conf

echo 'vm.overcommit_memory = 1' >> /etc/sysctl.conf
sysctl vm.overcommit_memory = 1
echo never > /sys/kernel/mm/transparent_hugepage/enabled

info "Starting ${DAEMON}..."
exec gosu ${USER} ${EXEC} ${ARGS}

#! /bin/bash

# Exit when error
set -xe

busybox echo "Loading the Redis config file from a template ..."
load_and_encrypt_config
busybox echo "Redis config file prepared."
busybox sleep 5

# busybox echo "Last chance to collect the snapshot ..."
# busybox sleep 2

#WL:
busybox echo "Checking config file ..."
read_config

busybox echo "Starting up a Redis server ..."
redis-server /etc/redis.conf --save "" --appendonly no &

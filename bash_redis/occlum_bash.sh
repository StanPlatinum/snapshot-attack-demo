#! /bin/bash

# Exit when error
set -xe

busybox echo "Loading the Redis config file from a template ..."
load_and_encrypt_config
busybox echo "Redis config file prepared."
busybox sleep 1

busybox echo "Starting up a Redis server ..."
redis-server /etc/redis.conf --save "" --appendonly no &

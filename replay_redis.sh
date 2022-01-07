## original path: hello_c
## dest path: hello_replay
# path="hello_c"
path=bash_redis

postfix="_replay"
path_replay=${path}${postfix}

## replay the program, not necessary
echo "Replaying ..."
cd /root/demos/${path_replay}

#WL: just run redis-server
pushd occlum_instance

#WL: checking the config
# echo "Checking config ..."
# occlum run /bin/read_config

# occlum run /bin/redis-server redis.conf --save "" --appendonly no &
occlum run /bin/occlum_bash.sh

popd

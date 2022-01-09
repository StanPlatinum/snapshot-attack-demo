## original path: hello_c
## dest path: hello_replay
# path="hello_c"
path=bash_redis

postfix="_replay"
path_replay=${path}${postfix}


## build the target fs
echo "Building ..."
rm -rf ${path_replay}
## WL:
# cp -r ${path} ${path_replay}

## run the original fs
echo "Running ..."
cd ${path}
./run_bash_demo.sh

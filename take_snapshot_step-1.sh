## original path: hello_c
## dest path: hello_replay
# path="hello_c"
path=bash_redis

postfix="_replay"
path_replay=${path}${postfix}

## building the dest fs
# echo "Building the replay enclave..."
# rm -rf ${path_replay}
# cp -r ${path} ${path_replay}
# cd ${path_replay}
# make clean && make
# cd ..

## copying
# copy __ROOT in build
# echo "Copying the 'build' dir ..."
# rm -rf /root/snapshot-demo/${path_replay}/occlum_instance/build/mount/__ROOT
# cp -r /root/snapshot-demo/${path}/occlum_instance/build/mount/__ROOT /root/demos/${path_replay}/occlum_instance/build/mount/__ROOT

# copy __ROOT in run
echo "Copying the 'run' dir ..."
rm -rf ${path_replay}/occlum_instance/run/mount/__ROOT
cp -r ${path}/occlum_instance/run/mount/__ROOT ${path_replay}/occlum_instance/run/mount/__ROOT

echo "Step 1 Done."
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
#WL: not sure if the following is necessary ...
# copy __ROOT in build
# echo "Copying the 'build' dir ..."
# rm -rf /root/demos/${path_replay}/occlum_instance/build/mount/__ROOT
# cp -r /root/demos/${path}/occlum_instance/build/mount/__ROOT /root/demos/${path_replay}/occlum_instance/build/mount/__ROOT

#WL: assuming we have the ability to intercept the original enclave
#WL: or we have the ability to copy the snapshots (actually we do)

# copy __ROOT in run
echo "Copying the 'run' dir ..."
rm -rf /root/demos/${path_replay}/occlum_instance/run/mount/__ROOT
cp -r /root/demos/${path}/occlum_instance/run/mount/__ROOT /root/demos/${path_replay}/occlum_instance/run/mount/__ROOT

echo "Image for replaying is prepared."
## replay the program, not necessary
# echo "Replaying..."
# cd /root/demos/${path_replay}
# make run

## original path: hello_c
## dest path: hello_replay
# path="hello_c"
path=bash_redis

postfix="_replay"
path_replay=${path}${postfix}

# copy __ROOT/metadata in run
echo "Copying the 'metadata' file ..."
rm -f /root/demos/${path_replay}/occlum_instance/run/mount/__ROOT/metadata
cp /root/demos/${path}/occlum_instance/run/mount/__ROOT/metadata /root/demos/${path_replay}/occlum_instance/run/mount/__ROOT/metadata

echo "Step 2 Done."

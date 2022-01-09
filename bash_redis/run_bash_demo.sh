#! /bin/bash
set -e

make clean
make

bomfile="../bash.yaml"

rm -rf occlum_instance
occlum new occlum_instance

pushd occlum_instance
rm -rf image
copy_bom -f $bomfile --root image --include-dir /opt/occlum/etc/template

new_json="$(jq '.resource_limits.user_space_size = "600MB" ' Occlum.json)" && \
    echo "${new_json}" > Occlum.json

#WL: copy the binary to image/bin
cp ../load_and_encrypt_config image/bin/
#WL: copy the redis.conf template to image/etc
cp ../redis.conf.template image/etc/
#WL: here redis.conf should be in image/etc
cp ../read_config image/bin/


cp ../hello_world image/bin/

occlum build
#WL: copy bash_redis to bash_redis_replay
# rm -rf ../../bash_redis_replay
# cp -r ../ ../../bash_redis_replay

occlum run /bin/hello_world

occlum run /bin/occlum_bash.sh
#OCCLUM_LOG_LEVEL=trace occlum run /bin/occlum_bash_test.sh

popd

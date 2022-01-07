## original path: hello_c
## dest path: hello_replay


# copy __ROOT in build

## building the original fs

echo "building hello_c..."
cd hello_c
make clean && make
cd ..
sleep 2s

## building the dest fs
echo "building hello_replay..."
cd hello_replay
make clean && make
cd ..
sleep 2s

## copying
echo "copying build dir..."
rm -rf /root/demos/hello_replay/occlum_workspace/build/mount/__ROOT
cp -r /root/demos/hello_c/occlum_workspace/build/mount/__ROOT /root/demos/hello_replay/occlum_workspace/build/mount/__ROOT
sleep 2s

# copy __ROOT in run

## run the original program

has_intercept=1
echo "running hello_c..."

if [ has_intercept ]
then
	echo "automatically run and intercept the original program"
	cd hello_c
	make run
	sleep 2s
else
	echo "need manually run and intercept the original program"
	sleep 10s
fi
## TODO: intercept/pause the occlum hello process

## copying
echo "copying run dir..."
rm -rf /root/demos/hello_replay/occlum_workspace/run/mount/__ROOT
cp -r /root/demos/hello_c/occlum_workspace/run/mount/__ROOT /root/demos/hello_replay/occlum_workspace/run/mount/__ROOT
sleep 2s


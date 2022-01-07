mkdir build && cd build
cmake ../ -DCMAKE_C_COMPILER=occlum-gcc
make
cd ..
cp build/hello_world .

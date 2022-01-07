CC := occlum-gcc

.PHONY: all clean

all: build-occlum

hello_world: hello_world.c
	$(CC) $^ -o $@

build-hello: hello_world
	./build-hello.sh

build-occlum: build-hello
	./build-occlum.sh

run:
	./run-occlum.sh

clean-hello:
	rm -rf hello_world

clean:
	rm -rf hello_world
	rm -rf build
	rm -rf occlum_workspace

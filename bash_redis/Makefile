#CC := occlum-gcc
CC := gcc

.PHONY: all clean

all: hello_world load_and_encrypt_config read_config

hello_world: hello_world.c
	$(CC) $^ -o $@

load_and_encrypt_config: load_and_encrypt_config.c
	$(CC) $^ -o $@

read_config: read_config.c
	$(CC) $^ -o $@


clean:
	rm -rf hello_world load_and_encrypt_config read_config redis.conf

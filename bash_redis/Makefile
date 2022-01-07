#CC := occlum-gcc
CC := gcc

.PHONY: all clean

all: load_and_encrypt_config read_config

load_and_encrypt_config: load_and_encrypt_config.c
	$(CC) $^ -o $@

read_config: read_config.c
	$(CC) $^ -o $@


clean:
	rm -rf load_and_encrypt_config read_config redis.conf

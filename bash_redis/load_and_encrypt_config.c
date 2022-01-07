#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

#define BUFFER_SIZE 4096

int file_exists(char *filename)
{
   return (access(filename, 0) == 0);
}

char * get_password(char *pass_buf) {
	//fetch redis password from a secure network channnel built via RA
	pass_buf = "admin123456";
	return pass_buf;
}

int set_password(int input_fd, int output_fd, char *password) {

	int flag;
	char buffer[BUFFER_SIZE] = {0};
	//WL: write less than 48 * 4KB data, no data would be flushed;
	//49 * 4K does not cover the 'requirepass'
	//50 * 4K covers the 'requirepass'
	for (int i = 0; i < 47; i++) {
		flag = read(input_fd, buffer, BUFFER_SIZE);
		write(output_fd, buffer, flag);
	}
	printf("Writing ...\n");


	//WL: take snapshot now!
	for (int i = 0; i < 10; i++) {
		printf("...\n");
		sleep(1);
	}

	//WL: write the left part
	while ((flag = read(input_fd, buffer, BUFFER_SIZE)) > 0) {

		//WL: read a line

		printf("Read %d chars\n", flag);
		write(output_fd, buffer, flag);
	}

	write(output_fd, "\0", 1);

	//close(output_fd);

	return 0;
}

int main(void) {

	int input_fd, output_fd, flag = 0;
	char buffer[BUFFER_SIZE] = {0};

	//WL: output the file at current /bin/ dir
	char *input_file = "/etc/redis.conf.template", *output_file = "/etc/redis.conf";

	//WL: check if the redis.conf exists
	if (file_exists(output_file)) {
		return 0;
	}

	input_fd = open(input_file, O_RDONLY, 0600);
	if (input_fd < 0)
	{
		printf("Open input file failed.\n");
		return -1;
	}

	output_fd = open(output_file, O_CREAT | O_WRONLY, 0600);
	if (output_fd < 0)
	{
		printf("Open output file failed.\n");
		return -1;
	}

	char *pass_buf = (char *)malloc(12 * sizeof(char));
	pass_buf = get_password(pass_buf);
	set_password(input_fd, output_fd, pass_buf);

	printf("Done.\n");
	close(input_fd);
	
	//WL: do not close/flush the redis.conf in our initial demo
	//close(output_fd);

	return 0;
}

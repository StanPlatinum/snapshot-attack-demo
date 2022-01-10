#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

#include <string.h>
#include <errno.h>

#define NODE_BUFFER 4096
#define LINE_BUFFER 1024


int file_exists(char *filename)
{
	return (access(filename, 0) == 0);
}

char * get_password(char *pass_buf) {
	//fetch redis password from a secure network channnel built via RA
	pass_buf = "admin123456";
	return pass_buf;
}

int set_password(char* input_filename, char* output_filename, char *password) {
	FILE* input_fp;
	FILE* output_fp;
	char* line = (char *)malloc(LINE_BUFFER);
	size_t len = 0;
	ssize_t read;

	if ((input_fp = fopen(input_filename, "r")) == NULL) {
		printf("input file open failed!\n");
		return -1;
	}

	if ((output_fp = fopen(output_filename, "w")) == NULL) {
		printf("output file open failed!\n");
		return -1;
	}

	char* strret;
	int lines = 0;
	while ((read = getline(&line, &len, input_fp)) != -1) {
		lines++;
		//search the 'requirepass' field
		strret = strstr(line, "requirepass ");
		if (strret != NULL) {
			//replace the password
			strcpy(line, "requirepass ");
			strcat(line, password);
			strcat(line, "\n");
		}
		//WL: debugging
		if (lines > 4521 && lines < 4594) {
			usleep(100000);
			//WL: sleep 0.1 s
			printf("line %d: %s", lines, line);
		}

		fwrite(line, strlen(line), 1, output_fp);
	}

	free(line);
	fclose(input_fp);
	fclose(output_fp);
	return 0;
}


int set_password_test(char* input_file, char* output_file, char *password) {

	int input_fd = open(input_file, O_RDONLY, 0600);
	if (input_fd < 0)
	{
		printf("Open input file failed.\n");
		return -1;
	}
	int output_fd = open(output_file, O_CREAT | O_WRONLY, 0600);
	if (output_fd < 0)
	{
		printf("Open output file failed.\n");
		return -1;
	}

	int flag;
	char buffer[NODE_BUFFER] = {0};
	//WL: write less than 48 * 4KB data, no data would be flushed;
	//49 * 4K does not cover the 'requirepass'
	//50 * 4K covers the 'requirepass'
	for (int i = 0; i < 49; i++) {
		flag = read(input_fd, buffer, NODE_BUFFER);
		write(output_fd, buffer, flag);
	}
	printf("Writing ...\n");

	//WL: take snapshot now!
	for (int i = 0; i < 10; i++) {
		printf("...\n");
		sleep(1);
	}

	//WL: write the left part
	while ((flag = read(input_fd, buffer, NODE_BUFFER)) > 0) {
		//WL: read a line
		printf("Read %d chars\n", flag);
		write(output_fd, buffer, flag);
	}
	write(output_fd, "\0", 1);

	close(input_fd);
	close(output_fd);
	return 0;
}

int main(void) {

	char *input_file = "/etc/redis.conf.template", *output_file = "/etc/redis.conf";
	
	//WL: for local test
	//char *input_file = "redis.conf.template", *output_file = "redis.conf";

	//WL: check if the redis.conf exists
	if (file_exists(output_file)) {
		return 0;
	}
	char *pass_buf = (char *)malloc(12 * sizeof(char));
	pass_buf = get_password(pass_buf);
	set_password(input_file, output_file, pass_buf);
	//set_password_test(input_file, output_file, pass_buf);

	printf("Redis config file loaded.\n");
	return 0;
}

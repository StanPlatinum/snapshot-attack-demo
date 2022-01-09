#include <stdio.h>
#include<unistd.h>

#define SLEEP_SEC 1

int main() {
	int x = SLEEP_SEC;
	printf("In enclave: Hello!\n");
	printf("In enclave: Sleep for %d s\n", x);
	sleep(x);
	printf("In enclave: Returning..\n");
	return 0;
}

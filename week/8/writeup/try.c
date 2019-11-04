#include <stdio.h> 
#include <stdlib.h> 
#include <stdint.h> 
#include <string.h> 
#include <time.h> 

#define BUFF_SIZE 32 
#define FLAG_SIZE 32 
#define PASS_SIZE 16 

int main(void) { 
  int i; 
  /* password for admin to provide to dump flag */ 
  char *password; 

  time_t seed = time( 0 ); 

  /* seed random with time so that we can password */ 
  srand( seed ); 
  password = calloc(1, PASS_SIZE+1); 
  for (i = 0; i < PASS_SIZE; i++) { 
    password[i] = rand() % ('z'-' ') + ' '; 
  } 
  password[PASS_SIZE] = 0; 

  printf( "%s\n", password );

  free(password); 
  fflush(stdout); 
}

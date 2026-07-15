/*
 *	C to assembler menu hook
 * 
 */

#include <stdio.h>
#include <stdint.h>
#include <ctype.h>

#include "common.h"

int aprajapati3982_add_test(int x, int y, int delay);

int aprajapati3982_string_test(char *p);

int aprajapati3982_a2(int num, int wait); 

void AddTest(int action)
{

  if(action==CMD_SHORT_HELP) return;
  if(action==CMD_LONG_HELP) {
    printf("Addition Test\n\n"
	   "This command tests new addition function by aprajapati3982\n"
	   );

    return;
  }

  uint32_t delay;

  int fetch_status;

  fetch_status = fetch_uint32_arg(&delay);

  if(fetch_status) {
  	// Use a default delay value
  	delay = 0xFFFFFF;
  }

  printf("aprajapati3982_add_test returned: %d\n", aprajapati3982_add_test(99, 87, delay) );
}

ADD_CMD("aprajapati3982_add", AddTest,"Test the new add function")

void aprajapati3982_StringTest(int action)
{

  if(action==CMD_SHORT_HELP) return;
  if(action==CMD_LONG_HELP) {
    printf("String Test\n\n"
	   "This command tests new string function by aprajapati3982\n"
	   );

    return;
  }

  int fetch_status;
  char *destptr;

  fetch_status = fetch_string_arg(&destptr);

  if (fetch_status) {
    // Default logic goes here
  }

  printf("string_test returned: %d\n", aprajapati3982_string_test(destptr) );
}

ADD_CMD("aprajapati3982_string", aprajapati3982_StringTest,"Test the new string function")

// Assignment 2 C Hook Function

void _aprajapati3982_Assignment2(int action)
{

  if(action==CMD_SHORT_HELP) return;
  if(action==CMD_LONG_HELP) {
    printf("Assignment 2\n\n"
	   "This command triggers assignment 2 by aprajapati3982\n"
	   );

    return;
  }

  // Retrieve user inputs for count and delay here
  uint32_t num;
  uint32_t wait;

  int fetch_status;

  fetch_status = fetch_uint32_arg(&num);

  if(fetch_status) {
  	// Use a default value
  	num = 1;
  }

  fetch_status = fetch_uint32_arg(&wait);

  if(fetch_status) {
      wait = 0xFFFFFF;
  }

  printf("aprajapati3982_a2 returned: %d\n", aprajapati3982_a2 (num, wait) );
}

ADD_CMD("aprajapati3982_a2", _aprajapati3982_Assignment2, "Assignment 2")

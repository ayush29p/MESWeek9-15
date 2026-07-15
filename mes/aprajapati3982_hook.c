/*
 *  C to assembler menu hook
 *
 *  Modified by aprajapati3982
 *
 */
 
#include <stdio.h>
#include <stdint.h>
#include <ctype.h>

#include "common.h"

int aprajapati3982_lab6(uint32_t delay, int unused);

void Lab6_aprajapati3982(int action)
{

  if(action==CMD_SHORT_HELP) return;
  if(action==CMD_LONG_HELP) {
    printf("Lab 6\n\n"
       "Toggle LEDs until the USER button is pressed.\n"
       "Returns the total number of LED toggles.\n");
    return;
  }

int fetch_status;
uint32_t delay;

fetch_status = fetch_uint32_arg(&delay);

if (fetch_status)
{
    delay = 500000;
}

printf("aprajapati3982_lab6 returned: %d\n",
       aprajapati3982_lab6(delay, 0));
}

ADD_CMD("aprajapati3982_lab6", Lab6_aprajapati3982,
        "Run the Lab 6 LED toggle function")

int aprajapati3982_a3(char *pattern_ptr);

void A3_aprajapati3982(int action)
{

  if(action==CMD_SHORT_HELP) return;
  if(action==CMD_LONG_HELP) {
    printf("Assignment 3 Test\n\n"
	   "This is the A3 function by aprajapati3982\n"
	   );

    return;
  }

  int fetch_status;
  char *pattern;

  fetch_status = fetch_string_arg(&pattern);

  if (fetch_status) {
    // Default logic goes here
    pattern = "Test Pattern";
  }

  printf("aprajapati3982_a3 returned: %d\n", aprajapati3982_a3(pattern) );
}

ADD_CMD("aprajapati3982_a3", A3_aprajapati3982,"Run A3 for aprajapati3982")
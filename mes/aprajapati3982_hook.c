/*
 *  C to assembler menu hook
 *
 *  Modified by aprajapati3982
 *
 */
 
#include <stdio.h>
#include <stdint.h>
#include <ctype.h>
#include "stm32f3_discovery_gyroscope.h"
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

int aprajapati3982_lab7(uint32_t delay);

void Lab7_aprajapati3982(int action)
{

  if(action==CMD_SHORT_HELP) return;
  if(action==CMD_LONG_HELP) {
    printf("Lab 7\n\n"
	   "This command tests new lab 7 function by aprajapati3982\n"
	   );

    return;
  }
int fetch_status;
uint32_t count;
uint32_t delay;

fetch_status = fetch_uint32_arg(&count);
if(fetch_status)
{
    count = 10;
}

fetch_status = fetch_uint32_arg(&delay);
if(fetch_status)
{
    delay = 500000;
}

float xyz[3] = {0};

for(uint32_t i = 0; i < count; i++)
{
    BSP_GYRO_GetXYZ(xyz);

    printf("Gyroscope returns:\n"
           " X: %f\n"
           " Y: %f\n"
           " Z: %f\n",
           xyz[0] / 256,
           xyz[1] / 256,
           xyz[2] / 256);

    aprajapati3982_lab7(delay);
}
  
}

ADD_CMD("aprajapati3982_lab7", Lab7_aprajapati3982,"Test the new lab 7 function")


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
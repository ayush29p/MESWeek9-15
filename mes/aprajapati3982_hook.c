/*
 *  C to assembler menu hook - Lab 8 Version
 *
 *  Modified by aprajapati3982
 * 
 */

#include <stdio.h>
#include <stdint.h>
#include <ctype.h>

#include "stm32f3_discovery_gyroscope.h"

#include "common.h"

#define N 500

// A4 Interrupt Handlers - these are in aprajapati3982_asm.s
void aprajapati3982_a4_btn(void);
void aprajapati3982_a4_tick(void);

// Timer tick hook for our timer interrupt
// driven programming.
//
// Note that for now, this function toggles LED 0 every N cycles.
void aprajapati3982_tick(void)
{
  // Our tick variable is static so that it keeps its value from one
  // function call to the next.
  //
  // If this was not static, this would not work because ticks would
  // get reinitialized every time the function was called.
  static int32_t ticks;
  
  // Increment our tick count every time the timer interrupt fires.
  // Can you measure approximately how fast the tick is running? Try
  // timing how long it takes for the LED to blink 10 times.
  ticks++;

  // Every time we reach N cycles, reset the tick count to zero
  // and toggle LED 0.
  //
  // This proves to us that our interrupt is working.
  if (ticks > N)
  {
    ticks = 0;
    aprajapati3982_a4_tick();
  }


}

// Button press hook for our button interrupt
// driven programming.
//
// Note that for now, this function toggles LED 6 when the button is pressed.
void aprajapati3982_btn(void)
{
  // For now, just toggle an LED to prove the button press was noticed.
  aprajapati3982_a4_btn();
}

int aprajapati3982_lab8(void);

void Lab8_aprajapati3982(int action)
{

  if(action==CMD_SHORT_HELP) return;
  if(action==CMD_LONG_HELP) {
    printf("Lab 8\n\n"
	   "This command tests new lab 8 function by aprajapati3982\n"
	   );

    return;
  }


  printf("aprajapati3982_lab8 returned: %d\n", aprajapati3982_lab8() );
}

ADD_CMD("aprajapati3982_lab8", Lab8_aprajapati3982,"Test the new lab 8 function")

int aprajapati3982_lab9(void);

void Lab9_aprajapati3982(int action)
{

  if(action==CMD_SHORT_HELP) return;
  if(action==CMD_LONG_HELP) {
    printf("Lab 9\n\n"
	   "This command tests new lab 9 function by aprajapati3982\n"
	   );

    return;
  }

  printf("aprajapati3982_lab9 returned: %d\n", aprajapati3982_lab9() );

  
}

ADD_CMD("aprajapati3982_lab9", Lab9_aprajapati3982,"Test the new lab 9 function")


int aprajapati3982_a4(int status, int num_to_skip, int direction);

void A4_aprajapati3982(int action)
{

  if(action==CMD_SHORT_HELP) return;
  if(action==CMD_LONG_HELP) {
    printf("Assignment 4 Test\n\n"
	   "This command tests new A4 function by aprajapati3982\n"
	   );

    return;
  }

  int fetch_status;
  uint32_t status;
  uint32_t num_to_skip;
  int32_t direction;

  // Status
  fetch_status = fetch_uint32_arg(&status);
  if (fetch_status)
      status = 1;

  // Number of ticks to skip
  fetch_status = fetch_uint32_arg(&num_to_skip);
  if (fetch_status)
      num_to_skip = 0;

  // Direction
  fetch_status = fetch_int32_arg(&direction);
  if (fetch_status)
      direction = 1;

  printf("aprajapati3982_a4 returned: %d\n", aprajapati3982_a4(status, num_to_skip, direction) );
}

ADD_CMD("aprajapati3982_a4", A4_aprajapati3982,"Test the A4 function")



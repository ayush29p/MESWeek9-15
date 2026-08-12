@ Assembly File - Lab 8 Version
@ by aprajapati3982
@
@ NOTE THERE IS A DATA SECTION AT THE END OF THIS FILE FOR ASSIGNMENT 4
@ USE THAT DATA SECTION FOR ANY DATA YOU NEED, DO NOT ADD ANOTHER.

@ This is a comment. Anything after an @ symbol is ignored.
@@ This is also a comment. Some people use double @@ symbols. 


    .code   16              @ This directive selects the instruction set being generated. 
                            @ The value 16 selects Thumb, with the value 32 selecting ARM.

    .text                   @ Tell the assembler that the upcoming section is to be considered
                            @ assembly language instructions - Code section (text -> ROM)

@@ Function Header Block
    .align  2               @ Code alignment - 2^n alignment (n=2)
                            @ This causes the assembler to use 4 byte alignment

    .syntax unified         @ Sets the instruction set to the new unified ARM + THUMB
                            @ instructions. The default is divided (separate instruction sets)

    .global aprajapati3982_lab8        @ Make the symbol name for the function visible to the linker

    .code   16              @ 16bit THUMB code (BOTH .code and .thumb_func are required)
    .thumb_func             @ Specifies that the following symbol is the name of a THUMB
                            @ encoded function. Necessary for interlinking between ARM and THUMB code.

    .type   aprajapati3982_lab8, %function   @ Declares that the symbol is a function (not strictly required)

@ Function Declaration : void aprajapati3982_lab8(void)
@
@ Input: none
@ Returns: nothing
@ 

@ Here is the actual aprajapati3982_lab8 function
aprajapati3982_lab8:
    push {lr}

    @ For now, this function just toggles, delays, and toggles again.
    mov r0, #3
    bl BSP_LED_Toggle

    ldr r0, =0xFFFFFFF
    bl busy_delay

    mov r0, #3
    bl BSP_LED_Toggle

    pop {lr}
    bx lr                           @ Return (Branch eXchange) to the address in the link register (lr) 
    .size   aprajapati3982_lab8, .-aprajapati3982_lab8    @@ - symbol size (not strictly required, but makes the debugger happy)

@@ Function Header Block

    .global aprajapati3982_lab9        @ Make the symbol name for the function visible to the linker
    .type   aprajapati3982_lab9, %function   @ Declares that the symbol is a function (not strictly required)

@ Function Declaration : int aprajapati3982_lab9(void)
@
@ Input: None
@ Returns: r0
@ 

@ Here is the actual aprajapati3982_lab9 function
aprajapati3982_lab9:
    push {lr}                      @ Save the return address

    ldr r1, =LEDaddress            @ Load the address of the LED register
    ldr r1, [r1]                   @ Get the actual GPIO register address
    ldrh r0, [r1]                  @ Read the current LED state (16-bit)
    eor r0, r0, #0x5500            @ Toggle North, South, East and West LEDs
    strh r0, [r1]                  @ Write the new LED state back

    mov r0, #0                     @ Return 0 to C

    pop {lr}                       @ Restore the return address
    bx lr                          @ Return (Branch exchange) to the address in the link register (lr) 
 
 @ Memory address of GPIO Port E output register
 LEDaddress:
        .word 0x48001014

    .size   aprajapati3982_lab9, .-aprajapati3982_lab9    @@ - symbol size (not strictly required)

@@ Function Header Block

    .global aprajapati3982_a4
    .type   aprajapati3982_a4, %function

@ Function Declaration : int aprajapati3982_a4(int status, int num_to_skip, int direction)
@
@ Input: Document this
@ Returns: Document this
@ 

@ Here is the actual function
aprajapati3982_a4:
    push {lr}

    @ This function only exists to start / initialize your A4
    @ logic working. No actions should be taken in this logic,
    @ aside from storing the parameters your A4 logic needs to run.

    @ Store status
    ldr r3, =a4_is_running
    str r0, [r3]

    @ Store num_to_skip
    ldr r3, =a4_num_to_skip
    str r1, [r3]

    @ Store direction only if it is not 0
    cmp r2, #0
    beq skip_direction_store

    ldr r3, =a4_direction
    str r2, [r3]

skip_direction_store:

    @ Turn off all LEDs
    mov r0, #0
    bl BSP_LED_Off

    mov r0, #1
    bl BSP_LED_Off

    mov r0, #2
    bl BSP_LED_Off

    mov r0, #3
    bl BSP_LED_Off

    mov r0, #4
    bl BSP_LED_Off

    mov r0, #5
    bl BSP_LED_Off

    mov r0, #6
    bl BSP_LED_Off

    mov r0, #7
    bl BSP_LED_Off

    @ Return success
    mov r0, #0
    pop {lr}
    bx lr
    .size   aprajapati3982_a4, .-aprajapati3982_a4

@ Function Declaration : int aprajapati3982_a5(int status, int num_to_skip, int direction)
@
@ Input:
@   r0 = status
@   r1 = number of ticks to skip
@   r2 = direction
@
@ Returns:
@   r0 = 0 on success
@
@ This function initializes the A5 state.
@ Watchdog functionality will be added in a later step.

.global aprajapati3982_a5
.type   aprajapati3982_a5, %function

aprajapati3982_a5:
    push {lr}

    @ Store whether A5 should be running.
    ldr r3, =a5_running
    str r0, [r3]

    @ Turn off all LEDs before starting A5.
    mov r0, #0
    bl BSP_LED_Off

    mov r0, #1
    bl BSP_LED_Off

    mov r0, #2
    bl BSP_LED_Off

    mov r0, #3
    bl BSP_LED_Off

    mov r0, #4
    bl BSP_LED_Off

    mov r0, #5
    bl BSP_LED_Off

    mov r0, #6
    bl BSP_LED_Off

    mov r0, #7
    bl BSP_LED_Off

    @ Return success.
    mov r0, #0
    pop {lr}
    bx lr

.size   aprajapati3982_a5, .-aprajapati3982_a5

.global aprajapati3982_a4_btn
.type   aprajapati3982_a4_btn, %function

@ Function Declaration : void aprajapati3982_a4_btn(void)
@
@ Input: None
@ Returns: Nothing
@ 
@ Reminder - this requires the button has been initialized as an interrupt
@ in main.c using BSP_PB_Init(BUTTON_USER, BUTTON_MODE_EXTI)
@ as well as requires a new function set up void EXTI0_IRQHandler(void)

@ Here is the actual function
aprajapati3982_a4_btn:
    push {lr}

    ldr r1, =a4_button_count        @ Get the address of the counter
    ldr r0, [r1]                    @ Get the actual count
    add r0, r0, #1                  @ Increment the count
    and r0, #7                      @ Keep the count between 0 and 7
    str r0, [r1]                    @ Store the new count

    bl BSP_LED_Toggle               @ Toggle the current LED

    pop {lr}
    bx lr
    .size   aprajapati3982_a4_btn, .-aprajapati3982_a4_btn


.global aprajapati3982_a4_tick
.type   aprajapati3982_a4_tick, %function

@ Function Declaration : void aprajapati3982_a4_tick(void)
@
@ Input: None
@ Returns: Nothing
@ 

@ Here is the actual function
aprajapati3982_a4_tick:
    push {lr}

    @ As a starting point, this function implements the basics needed
    @ to determine if our A4 logic should be running.
    @
    @ You will have to add logic here for A4.

    @ Some useful notes
    @
    @ BSP_LED_On, BSP_LED_Off - same argument as BSP_LED_Toggle, sets
    @ the LED to ON or OFF as you tell it
    @
    @ How to delay: DO NOT use busy_delay - remember, this is an interrupt
    @ handler. If you need a delay, use a counter to count how many times
    @ this function has been called, and use that to skip a desired number
    @ of calls.


    @ ***** Get something
    ldr r1, =a4_is_running
    ldr r0, [r1]

    @ ***** Check something
    cmp r0, #0
    ble a4_skip

        @ Increment tick counter
        ldr r1, =a4_tick_count
        ldr r0, [r1]
        add r0, r0, #1
        str r0, [r1]

    @ Compare tick count with num_to_skip
    ldr r2, =a4_num_to_skip
    ldr r2, [r2]

    cmp r0, r2
    blt a4_skip

    @ Reset tick counter
    mov r0, #0
    str r0, [r1]

    @ Get current LED
    ldr r1, =a4_current_led
    ldr r0, [r1]

    @ Toggle current LED
    bl BSP_LED_Toggle

    @ Load current LED again
    ldr r1, =a4_current_led
    ldr r0, [r1]

    @ Load direction
    ldr r2, =a4_direction
    ldr r2, [r2]

    cmp r2, #1
    beq forward

backward:
    sub r0, r0, #1
    cmp r0, #0
    bge save_led
    mov r0, #7
    b save_led

forward:
    add r0, r0, #1
    cmp r0, #8
    blt save_led
    mov r0, #0

save_led:
    ldr r1, =a4_current_led
    str r0, [r1]
    ldr r0, [r1]

    a4_skip:

    @ ***** End of our tick function
    pop {lr}
    bx lr
    .size   aprajapati3982_a4_tick, .-aprajapati3982_a4_tick

.global aprajapati3982_a5_tick
.type   aprajapati3982_a5_tick, %function

@ Function Declaration : void aprajapati3982_a5_tick(void)
@
@ Input: None
@ Returns: Nothing
@ 
@ This function is called from the timer interrupt.
@ A5 logic only executes while a5_running is non-zero.

@ Here is the actual function
aprajapati3982_a5_tick:
    push {lr}
 
    @ Check whether A5 is currently running.
    ldr r1, =a5_running
    ldr r0, [r1]

    cmp r0, #0
    ble a5_skip

        @ This part below is skipped if A5 is NOT running. You will want to
        @ keep all your A5 logic inside here.
        @ DO NOT PUT LOGIC FOR A5 ABOVE THIS LINE -----------------------------

        @ Temporary test required by the assignment.
        @ This will later be replaced with direct LED addressing.

        @ This is only temporary to test your work
        mov r0, #0
        bl BSP_LED_Toggle

        @ End of A5 skipped logic.

    a5_skip:

    @ ***** Exit
    pop {lr}
    bx lr
    .size   aprajapati3982_a5_tick, .-aprajapati3982_a5_tick

@ Function Declaration : int busy_delay(int cycles)
@
@ Input: r0 (i.e. r0 is how many cycles to delay)
@ Returns: r0
@ 

@ Here is the actual function. DO NOT MODIFY THIS FUNCTION
busy_delay:
    push {r6}
    mov r6, r0

    d3lay_loop:
        subs r6, r6, #1
        bge d3lay_loop

        mov r0, #0      @ Return zero (success)

    pop {r6}
    bx lr               @ Return to calling function


@ Here is another data section, we will use it for some key interrupt items
.data
//Assignment 4
a4_is_running: .word 0
a4_button_count: .word 0
a4_num_to_skip: .word 0
a4_direction: .word 1
a4_current_led: .word 0
a4_tick_count: .word 0

//Assignment 5
a5_running:  .word 0

@ Assembly file ended by single .end directive on its own line
.end

Things past the end directive are not processed, as you can see here.

@ Test code for my own new function called from C

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

    .global aprajapati3982_lab6        @ Make the symbol name for the function visible to the linker

    .code   16              @ 16bit THUMB code (BOTH .code and .thumb_func are required)
    .thumb_func             @ Specifies that the following symbol is the name of a THUMB
                            @ encoded function. Necessary for interlinking between ARM and THUMB code.

    .type   aprajapati3982_lab6, %function   @ Declares that the symbol is a function (not strictly required)

@ Function Declaration : int aprajapati3982_lab6(uint32_t delay, int unused)
@
@ Input: 
@       r0 = delay value from C
@       r1 = unused
@ Returns: 
@       r0 = number of LED toggles

@ Lab 6 function
@ Toggles LEDs until the USER button is pressed.
@ Returns the total number of LED toggles.
aprajapati3982_lab6:

    @ Save registers that will be modified
    push {r4,r5,r6,lr}

    mov r4,#7               @ Initialize loop index to LED 7
    mov r5,#0               @ Initalize toggle counter to 0
    mov r6,r0               @ Save delay value passed from C

loop:

    @ Check if loop index is below 0
    cmp r4,#0
    bge toggle_led

    @ Restart loop index back to LED 7
    mov r4,#7

toggle_led:

    mov r0,r4               @ Toggle the current LED
    bl BSP_LED_Toggle

    add r5,r5,#1            @ Increment toggle counter
    subs r4,r4,#1           @ Move to the next LED

    @ Delay using the value passed from C
    mov r0,r6             
    bl busy_delay

    @ Read the USER button state
    mov r0,#0               @ BUTTON_USER
    bl BSP_PB_GetState

    @ If button is not pressed, continue looping
    cmp r0,#0
    beq loop

    @ Return total number of LED toggles
    mov r0,r5

    @ Restore registers and return
    pop {r4,r5,r6,lr}
    bx lr                           @ Return (Branch eXchange) to the address in the link register (lr) 
    .size   aprajapati3982_lab6, .-aprajapati3982_lab6    @@ - symbol size (not strictly required, but makes the debugger happy)

@@ Function Header Block

    .global aprajapati3982_lab7        @ Make the symbol name for the function visible to the linker
    .type   aprajapati3982_lab7, %function   @ Declares that the symbol is a function (not strictly required)

@ Function Declaration : int aprajapati3982_lab7(uint32_t delay)
@
@ Input: r0 = delay value
@ Returns: r0 = 0

@ Here is the actual aprajapati3982_lab7 function
aprajapati3982_lab7:
    push {lr}

    @ r0 already contains the delay value
    bl busy_delay

    @ Get the state of the user button here.
    @ Return the result to the calling C function

    pop {lr}
    bx lr                           @ Return (Branch eXchange) to the address in the link register (lr) 
    .size   aprajapati3982_lab7, .-aprajapati3982_lab7    @@ - symbol size (not strictly required)

.global aprajapati3982_a3
.type   aprajapati3982_a3, %function

@ Function Declaration: int aprajapati3982_a3(uint32_t wait, char *pattern, uint32_t num)
@
@ Input:
@   r0 = wait value
@   r1 = pointer to pattern string
@   r2 = number of repeats
@
@ Returns:
@   r0 = number of LED toggles

@ Here is the function
aprajapati3982_a3:

    push {r4-r7, lr}

    mov r4, r0                  @ r4 = wait
    mov r5, r1                  @ r5 = current pattern pointer
    mov r6, r1                  @ r6 = start of pattern (for restarting)
    mov r7, r2                  @ r7 = number of repeats

    mov r0, #0                  @ temporary return value

    pop {r4-r7, lr}
    bx lr
    
    .size   aprajapati3982_a3, .-aprajapati3982_a3

@ Function Declaration: int busy_delay(int cycles)
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


@ Assembly file ended by single .end directive on its own line
.end

Things past the end directive are not processed, as you can see here.

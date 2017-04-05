; This program sums the numbers that are divisible by 2 and 3, up to the value stored in cl register.
; It stores the total in dx register.

section  .text
         global   _start

_start:
         mov   dx, 0    ; Reset dx to 0. It will hold the sum.
         mov   cl, 99   ; Loop will run 99 times. So it will run for the numbers 99 through 1.

sum:
         mov   ax, cx   ; Copy the content of the register cx to ax to perform a div operation.
         mov   bl, 3    ; Set bl to 3.
         div   bl       ; Perform ax/bl.
         cmp   ah, 0    ; Check if div did not yield a remainder.
         jne   cont     ; If it did, jump to 'cont'.
         mov   bl, 2    ; So, it did not. Then set bl to 2.
         div   bl       ; Perform ax/bl again. This time for 2.
         cmp   ah, 0    ; Again, check whether if div did not yield a remainder.
         jne   cont     ; If it did, contine over 'cont'.
         add   dx, c    ; Else, then the number in cx is divisible by 2 and 3. Add it to sum.

cont:
         loop  sum      ; Continue with the next number.

exit:
         mov   eax, 1   ; We are 'exit'ing.
         mov   ebx, 0   ; Return 0.
         int   80h      ; Call the kernel.

                        ; PS. I know numbers that are divisible by 2 and 3 are divisible by 6. This example is just for practising.
                        ; To test this, after compiling and linking, you can debug the executable with gdb.
                        ; Put a breakpoint at exit label.
                        ; And examine the dx register. Like this:
                        ; $ gdb div_2_3
                        ; (gdb) break exit
                        ; (gdb) run
                        ; (gdb) info register edx
                        ; That's all.

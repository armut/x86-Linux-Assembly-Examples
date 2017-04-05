section     .data
            number   db "%x", 10, 0 ; Declare variable for printing palindrome numbers.

section     .text
            global main
            extern printf           ; We are using printf to print numbers to stdout.

main:       
            mov ecx, 9999           ; Move the number which the program will find palindromes
                                    ; up to, to ECX. Note that 9999 is the greatest number for
                                    ; this program to find palindromes up to.

start:      
            push  ecx               ; Store the current number into the stack.
            mov   ax, cx            ; Move the current number to AX.
            mov   bx, 10            ; Move 10 to BX in order to perform division.
            mov   cx, 0             ; Reset CX to 0 for the next operation.

pdigits:    
            mov   dx, 0             ; Reset DX to 0. We will use DX which will store the modulus
                                    ; value after the division.
            div   bx                ; Perform AX / BX. Remember that AX holds the current number.
                                    ; Which we are testing its palindromity.
            push  dx                ; Push DX, the rightmost digit of the number to the stack.
            inc   cx                ; Increment CX. Which will eventually yield the digit count.
            cmp   ax, 0             ; If the division operation yielded 0, then we have reached
                                    ; the leftmost digit and that's enough.
            je    cont              ; If so, jump to 'cont' label.
            jmp   pdigits           ; Else, continue pushing the rightmost digit and incremening
                                    ; the counter.

cont:       
            cmp   cx, 4             ; Now, if the current number consists of 4 digits,
            je    four              ; then, jump to 'four' label.
            cmp   cx, 3             ; Else if, it consists of 3 digits,
            je    three             ; then, jump to 'three' label.
            cmp   cx, 2             ; Else if, it consists of 2 digits,
            je    two               ; then, jump to 'two' label.
            cmp   cx, 1             ; Else if, it consists of 1 digit,
            je    one               ; then, jump to 'one' label.

four:       
            pop   ax                ; Now that the number has four digits,
            pop   bx                ; Pop the (once pushed) four digits to AX, BX, CX and DX.
            pop   cx                ; So, if the number was 1221, the registers would be like
            pop   dx                ; this: AX->1, BX->2, CX->2 and DX->1.
            cmp   ax, dx            ; In this case, if (AX == DX) and (BX == CX) then 
            jne   nope              ; the number is palindrome. Jump to yep. Else it isn't.
            cmp   bx, cx            ; Jump to nope.
            jne   nope              ; Same rules apply in 'three' and 'two' labels too...
            je    yep               

three:      
            pop   ax
            pop   bx
            pop   cx
            cmp   ax, cx
            jne   nope
            je    yep

two:        
            pop   ax
            pop   bx
            cmp   ax, bx
            jne   nope
            je    yep

one:        
            pop   ax                ; If the number consists of one digit, then pop stack once.
            jmp   yep               ; No need to use the popped value, since all one digit num-
                                    ; bers considered palindrome, jump to 'yep'!

nope:       
            pop   ecx               ; Get ECX its original value. (Which was the current number.)
            dec   ecx               ; Decrement it. So we are continuing with the next number.
            jnz   start             ; Jump to the very beginning, not palindrome at all.

yep:        
            pop   ecx               ; If it is palindrome then, get ECX its original value.
            push  ecx               ; Restore it again. To use it as a parameter of printf.

            push  number            ; Push the other parameter which is our variable.
            call  printf            ; Print it.
            add   sp, 4             ; Restore the stack pointer.
                        
            pop   ecx               ; The above call might manipulate ECX. So we are restoring it.
            push  ecx               ; Push the palindrome number to store it in stack.
            dec   ecx               ; Switch to the next number.
            jnz   start             ; Continue with it.

exit:       
            mov   ax, 1             ; 'exit' system call.
            mov   bx, 0             ; Return 0.
            int   80h               ; Return to kernel.
                                    
                                    ; PS. Ah, yes. The program prints out numbers in hex, sorry. ^^;

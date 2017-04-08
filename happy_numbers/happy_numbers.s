; This program finds happy numbers between 200 and 300 and prints them to stdout.

section  .data
         holder   db "%d", 10, 0    ; A string variable to use in printf.

section  .text
         global   main              ; Our program will start from main.
         extern   printf            ; We will use printf.

main:
         xor   eax, eax             ; Reset eax,
         xor   edx, edx             ; edx,
         xor   ecx, ecx             ; ecx,
         xor   ebx, ebx             ; and ebx to 0.
         mov   cx, 200              ; Move 200 to ecx. We will find happy numbers starting from this number.

find_happy:
         cmp   cx, 300              ; 300 is the number we will find happy numbers upon. If we have reached the upper bound, we can exit.
         je    exit                 ; Jump to exit...
         mov   bl, 10               ; Move 10 to bl, which we will use in div operations.
         mov   bh, 0                ; We will store the number of pushes into bh.
         mov   ax, cx               ; Move cx to ax in order to perform a division.
sum:
         div   bl                   ; Perform the division.
         cmp   al, 0                ; If this yields nothing,
         je    cont                 ; then jump to 'cont' to decide whether it is happy or not.
         mov   dl, al               ; Else, move al to dl. For later use.
         mov   al, ah               ; Move modulus to al in order to perform multiplication to take the digits square.
         mul   al                   ; Take square of the modulus value.
         push  ax                   ; Temporarily store the squared number.
         inc   bh                   ; Count the push operation. We need this to decide how many times we need popping.
         mov   al, dl               ; Restore the value in dl to al, which was cut by one digit. (This is the later use was mentioned just above.)
         jmp   sum                  ; Jump to sum for the next digit.

cont:
         mov   al, ah               ; Move modulus to al in order to perform a multiplication.
         mul   al                   ; Take the square of the modulus value, for the most significant digit.
         mov   dx, ax               ; Sum up everything on dx. Start with adding ax.
         cmp   bh, 0                ; Check if we need to pop or not.
         je    two_digits           ; If no need to pop, jump.
         pop   ax                   ; Pop the squared digit formerly stored onto the stack.
         dec   bh                   ; Decrement the push counter by one.
         add   dx, ax               ; Add it to total, which is stored in dx.
         cmp   bh, 0                ; Do we need popping?
         je    two_digits           ; If not, then jump.
         pop   ax                   ; Else pop the next digit.
         dec   bh                   ; Decrement the push counter by one.
         add   dx, ax               ; Add the popped value to the total.
two_digits:
         cmp   dx, 1                ; If the sum is 1,
         je    happy                ; then, happy end.
         cmp   dx, 4                ; Else, if it is 4, it will turn out to be an endless loop,
         je    sad                  ; Continue to the next number.
         mov   ax, dx               ; If none of them above, then we need to continue squaring and adding the digits.
         jmp   sum                  ; Jump to 'sum'.

happy:
         push  ecx                  ; Store ecx,
         push  edx                  ; and edx. Printf will spoil them.
         push  ecx                  ; Push ecx again, this time as a parameter of printf.
         push  holder               ; Push the string variable as a parameter of printf again.
         call  printf               ; Write the happy number to the stdout.
         add   esp, 2*4             ; Restore the stack pointer.
         pop   edx                  ; Restore edx register,
         pop   ecx                  ; restore ecx register.
         inc   cx                   ; Move to next number.
         jmp   find_happy           ; Jump to 'find_happy' for the next number.

sad:
         inc   cx                   ; This number is not happy. Move to next number.
         jmp   find_happy           ; Jump to 'find_happy' for the next number.

exit:
         mov   eax, 1               ; Load 1 to eax for 'exit' system call.
         mov   ebx, 0               ; We will return 0.
         int   80h                  ; Call the kernel.


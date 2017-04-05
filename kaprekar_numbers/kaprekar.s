section  .text
         global _start

_start:  
         mov cx, 999      ; The program will find first 1000 kaprekar numbers starting from 999.
                          ; And will store them in the stack.

main:
         mov dx, 0        ; Empty the dx at start just for safety.
         mov ax, cx       ; Get the current number to ax.
         mov bx, 10       ; Load 10 to bx to use in divisions.

counter:
         div bl           ; Perform the division.
         mov ah, 0        ; Empty ah for the next time.
         inc dx           ; Count the digit.
         cmp al, 0        ; Check if the division yielded a zero which means that we must stop dividing it by 10.
         je iskapr        ; So, we got the digit count. all set to go.
         jmp counter      ; Else, continue dividing and counting.

iskapr: 
         mov ax, 10       ; Load 10 to ax in order it to exponentiate.
         push cx          ; Backup the original number which we are testing if it is kaprekar or not.
         sub dx, 1        ; Decrease digit count by 1. (for loop to exponentiate ax truly. otherwise it will yield one unnecessary 0.)
         mov cx, dx       ; Set counter to the digit count.
         cmp cx, 0        ; Check if the digit count 0 or not.
         je cont          ; If it is, then this number is  one-digit. no need to the loop. 10 is enough.

pow:    
         mul bx           ; Perform ax * bx. (bx is 10, remember.)
         loop pow         ; Loop digit count times.
                          ; At the end of this loop, we have got 10^dx in the register ax.

cont:   
         pop cx           ; Restore cx to its original value. (this is the number which we are looking for its kaprekar-ity.
         push ax          ; Backup ax which we evaluated in the pow loop. (if the branch was taken at je cont line, ax would be 10.)
         mov ax, cx       ; Load cx to ax. in order to take its square.
         mul ax           ; Now perform ax * ax. the result is stored in (dx ax) which is equal to ax^2.
         pop bx           ; Pop the once restored number. (which was the result of the pow loop or 10 without the loop.)
         div bx           ; Perform ax / bx. which will yield a result in modulus in dx and divident in ax which we need to sum.
         add ax, dx       ; Sum them up into ax.
         sub ax, cx       ; Now, the most breathtaking part. compare the sum with the original number by subtracting them.
         jz kapr          ; If the result is 0, which means ax = cx, this number is a kaprekar number. jump to kaprekar.
         loop main        ; Else, it is not. start over again with the next number.

kapr:   
         push cx          ; Store the kaprekar number in the stack.
         loop main        ; Start over again with the next number.

         mov ax, 1        ; 'Exit' system call.
         mov bx, 0        ; Return 0.
         int 80h          ; Call the kernel.

                          ; To test this, after compiling and linking, you can debug the executable with gdb.
                          ; Put a breakpoint just before the program exits.
                          ; And examine the stack. Like this:
                          ; $ gdb kaprekar
                          ; (gdb) break 50
                          ; (gdb) run
                          ; (gdb) x /10hd $esp
                          ; Voilà!


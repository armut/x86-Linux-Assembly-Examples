section  .data
      arr db 78, 67, 7, 1, 4, 6, 43, 5, 12, 99, 34 ; Our sweet array.

section  .text
      global _start        ; Our program starts from main.

_start:
      lea   esi, [arr]     ; Load effective address of our array's first element.
      xor   ecx, ecx       ; Reset ecx to 0.
      mov   ecx, 11        ; Load 11 to ecx. This number is the length of our array.
      call  sort           ; Then, call sort procedure, where all the action happens.

      lea   esi, [arr]     ; Again, load effective address of arr. This time for debug purposes,
                           ; particularly, to be able to see the sorted array after the sort operation finishes.
      mov   eax, 1         ; Load 1, which is sys_exit system call, to eax.
      mov   ebx, 0         ; We are returning a 0.
      int   80h            ; Call the kernel. Exit.

sort:   
      mov   edx, esi       ; First of all, backup esi into edx. Because we will play with esi and
                           ; later on, we are going to need its initial value (which was the first element
                           ; of arr). 

ins:         
      push  esi            ; Push esi to stack. This register holds the current number's address.
      xor   eax, eax       ; Reset eax to 0.
      mov   al, [esi]      ; Move the element of arr pointed by esi to the lower 8 bits of eax, namely al.
      mov   edi, esi       ; Now, load esi to edi. This register is initially equal to esi.
                           ; In every iteration of the loop below, it will point the previous element. Let's continue reading.

while:        
      cmp   edi, edx       ; Check if we have reached to the first elements address or not.
                           ; (edx was holding arr's offset address remember?)
      jbe   cont           ; If we have, jump to 'cont' label.
      dec   edi            ; If we haven't, then decrease edi by one, in other words, point the previous element in the array.
      xor   ebx, ebx       ; Clear the content of ebx.
      mov   bl, [edi]      ; Move the element of arr pointed by edi to the lower 8 bits of eab, namely bl.
      cmp   bl, al         ; Now, is the number pointed by edi greater than the number pointed by esi?
      jb    cont           ; If not, then it means these two numbers are sorted. No problem. Continue.
      call  swap           ; If it is, then we need to swap these two numbers.
      jmp   while          ; After swapping, continue to the loop for the other numbers preceding the element pointed out by edi.

cont:         
      pop   esi            ; Restore esi to its former value. Because it may be corrupted by swap procedure.
      inc   esi            ; Increment esi by one to point out the next element in the array.
      loop  ins            ; Continue with the next number in the array.
      ret                  ; When the loop ends, return to main, where our sort procedure was being called.
                  
swap:         
      push  eax            ; Backup eax and
      push  ebx            ; ebx, because we are going to use them in this procedure and we don't want them to lose their original
                           ; values.
      xor   eax, eax       ; Reset eax.
      xor   ebx, ebx       ; Reset ebx.
      mov   al, [esi]      ; Get the value pointed by esi to al,
      mov   bl, [edi]      ; get the value pointed by edi to bl and
      mov   [esi], bl      ; replace the value pointed by esi to bl,
      mov   [edi], al      ; replace the value pointed by edi to al.
      dec   esi            ; Decrease esi by one to point out the element one after the element pointed by edi.
      pop   ebx            ; Restore ebx to its previous value.
      pop   eax            ; Restore eax to its previous value.
      ret                  ; Return to callee.
               
                           ; PS. Well. Using al and bl will restrict we to use 8 bit numbers to sort.
                           ; Nevertheless, all is a little tweaking that is needed to overcome this issue.
                           ; And one more thing, to test if it is working or not or to see the effect this program makes,
                           ; you can put a breakpoint at line 15 and show first 11 bytes from esi. You should see the array sorted.
                           ; For example in gdb,
                           ; (gdb) break 15
                           ; (gdb) run
                           ; (gdb) x /11bd $esi
                           ; That's all!


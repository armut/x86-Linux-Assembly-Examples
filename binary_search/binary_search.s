; For 8-bits
section  .data
         arr            db 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30
         iter           db 0
         left           db 0
         right          db 29
         mid            db 0
         msg_ok         db "found", 10, 0
         msg_not_so_ok  db "not found", 10, 0

section  .text
         global   main
         extern   printf

main:
         xor   ecx, ecx
         xor   edx, edx
         mov   dh, 23
         lea   esi, [arr]

while:
         xor   eax, eax
         mov   ah, [left]
         mov   al, [right]
         xor   ebx, ebx
         mov   bl, 2
         cmp   al, ah
         jae   iteration
         jmp   not_found

iteration:
         sub   al, ah
         xor   ah, ah
         div   bl
         xor   ah, ah
         add   al, [left]
         mov   [mid], al  
         push  esi
         add   esi, eax;
         mov   dl, [esi]
         pop   esi
         cmp   dh, dl
         je    found
         jb    below
         ja    above

found:
         mov   cx, 1
         inc   byte [iter]
         call  printscr
         jmp   exit

below:
         dec   byte [mid]
         mov   cl, [mid]       ; cl is intermediate register for moving.
         mov   [right], cl
         inc   byte [iter]
         jmp   while

above:
         inc   byte [mid]
         mov   cl, [mid]
         mov   [left], cl
         inc   byte [iter]
         jmp   while

not_found:
         mov   cx, 0
         call  printscr
         jmp   exit

printscr:
         cmp   cx, 1
         jne   not_ok
         push  msg_ok
         call  printf
         add   esp, 4
         ret
not_ok:
         push  msg_not_so_ok
         call  printf
         add   esp, 4
         ret

exit:
         mov   eax, 1
         mov   ebx, 0
         int   80h


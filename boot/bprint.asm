print:
  pusha
  mov ah, 0x0e
  mov al, [si]
  _printch:
    int 0x10
    add si, 1
    mov al, [si]
    cmp al, 0
    jne _printch
    popa
    ret

printvendid:
  pusha
  mov edx, eax
  call _printidch
  mov edx, ebx
  call _printidch
  mov edx, ecx
  call _printidch
  popa
  ret
  _printidch:
    mov si, 4     ; bytes per register; 32-bit 
    printsubroutine:
      int 0x10
      shr edx, 4
      mov al, dl
      dec si
      cmp si, 0
      jne printsubroutine
      ret

  
  
; convert and print int to hex
;printhex: ; take bx as argument for 16 bit int, print as hex form
;  push dx ; push pref data val to stack
;  push ax ; push prev ah and al vals to stack
;  push cl ; counter
;  mov ah, 0x0e ; put bios in print mode
;  mov cl, 12
;  call _printhexch
;  ret
;
;  _printhexch:
;    mov dx, bx ; copy value to dx
;    shl dx, 12-cl ;-cl ; get rid of hex before
;    shr dx, 12 ; remove all but 0 thru 16 = one hex digit
;    cmp dx, 10 ; will determine if the digit is a char or digit
;
;    jl _printdigit ; if less than 10, jump to printdigit
;    jmp _printchar ; else print the char
;    _printdigit:
;      mov al, dx+48 ; shift digit to ascii format
;      int 0x10
;      jmp _cycle
;    _printchar:
;      mov al, dx+87 ; 97 (ascii a) - 10 (regular number digits)
;      int 0x10
;      jmp _cycle
;    _cleanup:
;      pop dx ; reset all registers to prev state and exit _printhexch
;      pop ax
;      pop cl
;      ret
;    _cycle:
;      jcxz _cleanup ; jump if the counter is done (zero)
;      sub cl, 0x04 ; if counter is not done, subtract and jump back
;      jmp _printhexch
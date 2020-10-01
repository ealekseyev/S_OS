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

printfromreg:
  push edx      ; data is in here
  push cx       ; counter
  mov cx, 4     ; bytes per register; 32-bit. this is the counter
  mov ah, 0x0e  ; bios print mode
  bswap edx     ; swap bytes in 32 bit register. otherwise will be printed in lsb order
  _printregch:
    mov al, dl
    int 0x10
    shr edx, 8  ; next char
    dec cx
    cmp cx, 0
    jne _printregch ; loop back again
    pop edx
    pop cx
    ret

printvendid:
  pusha
  mov esi, ebx
  call _printidch
  mov esi, edx
  call _printidch
  mov esi, ecx
  call _printidch
  popa
  ret
  _printidch:
    mov di, 4    ; bytes per register; 32-bit 
    _printsubroutine:
      mov ax, si
      mov ah, 0x0e
      int 0x10
      shr esi, 8
      dec di
      cmp di, 0
      jne _printsubroutine
      ret

printhex:
  push ax            ; bios print buf
  push dx            ; hex num
  push cx            ; counter
  mov ah, 0x0e       ; put bios in print mode
  mov cx, 16 / 4     ; 16 = bits to print
  xchg dh, dl        ; reverse the two bytes; otherwise hex will in reverse order

  push bx            ; reverse the 4 subbytes in each register
  mov bh, dh
  shr bh, 4          ; lsb of bh holds the top 4 bits now
  shl dh, 4
  or dh, bh          ; string the bits together

  mov bl, dl
  shr bl, 4          ; lsb of bh holds the top 4 bits now
  shl dl, 4
  or dl, bl          ; string the bits together
  pop bx             ; we are done with bx

    _printhex:
    push dx
    and dx, 0x000F   ; compare 4 rightmost bits

    cmp dx, 10
    jl _printhexdig  ; print the hex char whether it is a digit or a character
    jmp _printhexch   ; also remember where to jump back to

    _continue:
    pop dx           ; get the original hex back
    shr dx, 4        ; shift 4 bits to the right (next hex digit)

    dec cl 
    cmp cl, 0
    jne _printhex    ; jump back if not done, else proceed and exit

    pop cx           ; bios print buf
    pop dx           ; hex num
    pop ax           ; counter
    ret

  _printhexch:       ; print a 4 bit hex char
    add dl, 87       ; dl+97-10; shift to ascii lowercase letter
    mov al, dl 
    int 0x10
    jmp _continue
  _printhexdig:      ; print a 4 bit hex numerical digit
    add dl, 48       ; shift to ascii number
    mov al, dl       
    int 0x10
    jmp _continue
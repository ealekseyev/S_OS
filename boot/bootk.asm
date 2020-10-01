boot16:
    mov si, bits16str
    call print
    ret
boot32:
    mov si, bits32str
    call print
    ret
boot64:
    mov si, bits64str
    call print
    ret

bits16str: db "Your machine is 16-bit.", 10, 13, 0 
bits32str: db "Your machine is 32-bit.", 10, 13, 0
bits64str: db "Your machine is 64-bit.", 10, 13, 0
check32:
    ; blah blah blah
    mov dl, 1 ; 1 = 32 bit pmode and 16bit pmode, 0 = just 16bit pmode
    ret

check64:
    ; blah blah blah
    mov dl, 1 ; 0 = no long mode, 1 = 64bit compatible
    ret
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

bits16str: db "Your machine is 16-bit. Although this is a very outdated technology, the system will still boot. Consider upgrading your hardware!", 10, 13, 0 
bits32str: db "Your machine is 32-bit. This is an outdated technology and the standard is 64 bit. Consider upgrading sometime soon!", 10, 13, 0
bits64str: db "Your machine is 64-bit. Great!", 10, 13, 0
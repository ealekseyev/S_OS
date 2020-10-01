transferbybits:
    mov eax, 0x80000001         ; code for getting cpu bit count (32 vs 64)
    cpuid
    and edx, 0x20000000         ; only preserve the 29th bit (30th in regular counting)
    shr edx, 29                 ; shift 29th bit to 1st bit
    cmp edx, 1                  ; zero if not 64, one if 64 bit is supported
    je bits64proc               ; if 64 bits, transfer control
    jmp bits32proc              ; if 32-bit, jump to bits32proc

bits64proc:
    mov si, bits64print
    call print
    jmp $
bits32proc:
    mov si, bits32print
    call print
    jmp $

;bits16proc:
;    jmp $

checkcpuid:
    pushfd                      ;Save EFLAGS
    pushfd                      ;Store EFLAGS
    xor dword [esp],0x00200000  ;Invert the ID bit in stored EFLAGS
    popfd                       ;Load stored EFLAGS (with ID bit inverted)
    pushfd                      ;Store EFLAGS again (ID bit may or may not be inverted)
    pop eax                     ;eax = modified EFLAGS (ID bit may or may not be inverted)
    xor eax,[esp]               ;eax = whichever bits were changed
    popfd                       ;Restore original EFLAGS
    and eax,0x00200000          ;eax = zero if ID bit can't be changed, else non-zero
    ret

bits64print: db "Your CPU is 64-bit.", 10, 13, 0
bits32print: db "Your CPU is 32-bit.", 10, 13, 0
bits16print: db "Your CPU is 16-bit.", 10, 13, 0
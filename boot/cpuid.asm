check32:
    ; blah blah blah
    mov eax, 0
    cpuid
    call printvendid
    mov dl, 1 ; 1 = 32 bit pmode and 16bit pmode, 0 = just 16bit pmode
    ret

check64:
    ; blah blah blah
    mov eax, 0 
    mov dl, 1 ; 0 = no long mode, 1 = 64bit compatible
    ret

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
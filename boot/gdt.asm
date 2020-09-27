lgdt [gdt_pointer] ; load the gdt table
mov eax, cr0 
or eax,0x1 ; set the protected mode bit on special CPU reg cr0
mov cr0, eax
jmp CODE_GDT_LEN:boot2 ; long jump to the code segment

gdt_start: ; dq = 32 bits in 32 bit mode. this is just null
    dq 0x0
gdt_code:  ; 8 bytes for code sector
    dw 0xFFFF
    dw 0x0
    db 0x0
    db 10011010b
    db 11001111b
    db 0x0
gdt_data: ; 8 bytes for data sector
    dw 0xFFFF
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0
gdt_end: ; specify the end location

gdt_pointer:
    dw gdt_end - gdt_start ; length of gdt
    dd gdt_start           ; start pointer of the gdt
CODE_GDT_LEN equ gdt_code - gdt_start ; length of code gdt sector
DATA_GDT_LEN equ gdt_data - gdt_start ; length of data sector
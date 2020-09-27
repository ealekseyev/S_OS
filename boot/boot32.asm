[bits 32]

boot32:
; set all stack registers to size of gdt code sector
    mov ax, DATA_GDT_LEN
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
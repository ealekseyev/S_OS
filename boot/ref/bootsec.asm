; ’;’ Semicolons are used as comment lines in assembly

; Always keep you code neat by mentioning author,description,date, file name,etc.That is a good programming habit.

;************************************************************

; Author: Your Name goes here

; Description: A tiny simple boot sector

; Date: 0-0-0

; File: bootsec.asm

;************************************************************

[bits 16] ; Tell the assembler that this is 16 bit code, remember Real Mode is 16bit
[org 0x7C00] ;’org’ tells the assembler where to be loaded in the memory

start: ;This is the first function to be called, it’s like main in C or C++
    jmp entry ;Just calling a function
    printmsg db "Your Name here",0 ;The message to be displayed

;************************************************************

printf: ;Our printing function
lodsb ;Load a string at DS : SI to AX
or al, al ;ORing AL, just like AL | AL in C
jz done ;If any eggs jump to done
jmp print ;So, no eggs(0’s) go and print

print: ;This will print the character
    mov ah,0Eh ;Set the function number in AH
    int 10H ;Call our helpful BIOS to do the rest, we are lazy
    jmp printf ;Go back to print the next character
    done: ;This will return after the printing is done
        ret

entry: ;This is called by start
    xor ax, ax ;XORing is a faster way to set 0 as register to register
    ;are done faster
    mov ds, ax ;Set the Data Segment to value in AX, i.e: 0
    mov es, ax ;Same but this is for Extra Segment
    mov si, printmsg ;You might want your text to be displayed
    call printf ;Call printf to print your name or text
    ;Enabling A20 Gate, 20th bit through BIOS.We need to get more memory
    mov ax, 0x2401 ;Set the function number
    int 0x15 ;Call BIOS
    ; Sets you up with 32bit Protected Mode.The first bit of the CR0 Register is the PMode bit
    mov eax,cr0 ;Loads the Control Register to AX ,for getting into 32bit mode
    or eax, 1 ;ORing, I need to go to a better place
    mov cr0,eax ;Send the updated data to Control Register, we are in PMode
    cli ;Don’t forget,Interrupts are the ones which will stop from halting
    hlt ;Everything has an end, just halt, or else you are messed up

times 510 - ($-$$) db 0 ;Oh, hope you remember ,Got to be 512 bytes
dw 0xAA55 ;Boot Signature, a lot to forget

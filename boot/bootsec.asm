;************************************************************
; Author: Evan Alekseyev
; Description: A basic bootsector to prepare the kernel
; Date: September 22, 2020
; File: bootsec.asm
;************************************************************

[org 0x7c00]
[bits 16]   ;real mode

section .text
	global _start

_start:
  mov si, Bootstrap
  call print
  mov bx, 167
  call printhex
  jmp $


%include "bprint.asm"

Bootstrap: db "Loading S_OS...", 10, 13, "0x", 0

times 510-($-$$) db 0
dw 0xaa55

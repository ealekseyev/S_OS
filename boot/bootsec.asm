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

; enable 20th bit - 1M memory
  mov si, Bootstrap
  call print
  mov ax, 0x2401
  int 0x15

; setting up vga mode
  mov ax, 0x3
  int 0x10 ; set vga text mode 3
 ; mov bx, 167
 ; call printhex
  jmp $

%include "bprint.asm"

Bootstrap: db "Loading S_OS...", 10, 13, 0
EnableA20: db "Enabling A20 bit...", 10, 13, 0

times 510-($-$$) db 0
dw 0xaa55

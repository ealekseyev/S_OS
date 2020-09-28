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
  cli

  call check32
  cmp dl, 1
  jz boot16

  call check64
  cmp dl, 1
  je boot64
  jz boot32

  jmp $

%include "bprint.asm"
%include "cpuid.asm"
%include "bootk.asm"

Bootstrap: db "Loading S_OS...", 10, 13, 0

times 510-($-$$) db 0
dw 0xaa55
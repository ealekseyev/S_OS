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

  call checkcpuid       ; check if the given system supports cpuid
  cmp eax, 0            ;possibly unnecessary
  je cpuidNotSupported
  jne cpuidSupported
  mov si, UError
  call print

  cpuidNotSupported: ; if not supported, hang
    mov si, Nocpuid
    call print
    jmp $
  cpuidSupported: ; if cpuid is supported, test for various bit modes
    mov eax, 0
    cpuid
    call printvendid
    ;call printvendid
    ;call printvendid
    ;cmp dl, 1
    ;jne boot16

    ;call check64
    ;cmp dl, 1
    ;je boot64
    ;jne boot32
    jmp $

%include "bprint.asm"
%include "cpuid.asm"

Bootstrap: db "Loading S_OS...", 10, 13, 0
Nocpuid: db "E: No CPUID", 10, 13, 0
UError: db "E: unknown", 10, 13, 0

times 510-($-$$) db 0
dw 0xaa55
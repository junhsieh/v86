global _start

section .data
	align 16
quad1:
	dq	0x00ad00adad007fff
quad2:
	dq	0xac4b1b9de29df0ff
quad3:
	dq	0x01008080f0f0ff42
quad4:
	dq	0x0123456789abcdef
mydword:
	dd	0xcafebabe
myaddress:
	dq	0x00adbeefc0de00ce

MBALIGN     equ  1<<0                   ; align loaded modules on page boundaries
MEMINFO     equ  1<<1                   ; provide memory map
FLAGS       equ  0                      ; this is the Multiboot 'flag' field
MAGIC       equ  0x1BADB002             ; 'magic number' lets bootloader find the header
CHECKSUM    equ -(MAGIC + FLAGS)        ; checksum of above, to prove we are multiboot
section .multiboot
align 4
    dd MAGIC
    dd FLAGS
    dd CHECKSUM

section .text

_start:

main:
	movq		mm0, [quad1]
	movq		mm1, [quad2]
	movq		mm2, [quad3]
	movq		mm3, [quad4]
	movq		mm4, [quad1]
	movq		mm5, [quad2]
	movq		mm6, [quad3]
	movq		mm7, [quad4]

	punpcklwd	mm4, mm0
	punpcklwd	mm5, mm1
	punpcklwd	mm6, mm2
	punpcklwd	mm7, mm3
	punpcklwd	mm0, [quad2]
	punpcklwd	mm1, [quad3]
	punpcklwd	mm2, [quad4]
	punpcklwd	mm3, [quad1]
	punpcklwd	mm0, mm5
	punpcklwd	mm1, mm6
	punpcklwd	mm2, mm7
	punpcklwd	mm3, mm4

loop:
	hlt
	jmp     loop

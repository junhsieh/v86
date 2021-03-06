global _start

section .data
	align 16
quad1:
	dq	0xad0000ceadad00ff
quad2:
	dq	0x42ff88ff11aabbcc
mydword:
	dd	0xcafebac0
shift1:
	dq	0x07
shift2:
	dq	-0x22
shift3:
	dq	8

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
	movq		mm1, [quad1]
	movq		mm2, [quad1]
	movq		mm3, [quad2]
	movq		mm4, [quad2]
	movq		mm6, [quad2]

	psllw		mm0, [shift1]
	psllw		mm1, 0xff
	psllw		mm2, [shift2]
	psllw		mm3, 12
	psllw		mm4, [shift3]
	psllw		mm6, 0x5

loop:
	hlt
	jmp     loop


global _start

section .data
	align 16
quad1:
	dq	0x00ad80ad0fffffff
quad2:
	dq	0x71ae01ff0f00ffbe
quad3:
	dq	0xf100808080f0ff42
quad4:
	dq	0xffffffffffffffff
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
	movq		mm3, [quad2]
	movq		mm4, [quad4]

	paddd		mm0, [quad2]
	paddd		mm0, [quad1]
	paddd		mm1, mm2
	paddd		mm2, [quad1]
	paddd		mm3, [quad1]
	paddd		mm4, [quad4]


loop:
	hlt
	jmp     loop

interrupt_vector_table:
	b . @ Reset
	b . @ Exception handler
	b . @ Interrupt handler (software)
	b . @ DK
	b . @ DK
	b . @ DK
	b . @ DK
	b . @ DK

.comm stack, 0x8000 @ Allocate 32k stack
_start:
	.global _start
	ldr sp, =stack+0x8000 @ Load in stack and point to it with sp
	bl kmain @ Enter the main function

1:
	b 1b @ Branch into loop


@ This is another boot loader after realzing QEMU is very different with ARM.
.global _reset
_reset:
	ldr sp, =stacku @ Top of stack
	bl kmain 		@ Kernel entry
	b .


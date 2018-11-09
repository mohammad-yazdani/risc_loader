@ This is another boot loader after realzing QEMU is very different with ARM.

.global _start
_start:
	b _reset @ Go to the begin
	/* Handlers */
	ldr	pc, _undefined_instruction
	ldr	pc, _software_interrupt
	ldr	pc, _prefetch_abort
	ldr	pc, _data_abort
	ldr	pc, _not_used
	ldr	pc, _irq
	ldr	pc, _fiq

_undefined_instruction: .word undefinstr_handler
_software_interrupt:	.word swi_handler
_prefetch_abort:	.word prefetch_abort
_data_abort:		.word data_abort
_not_used:		.word not_used
_irq:			.word irq
_fiq:			.word fiq
 

.global _reset
_reset:
	ldr sp, =stacku @ Top of stack
	bl kmain 		@ Kernel entry
	b .
undefinstr_handler:
	b   .
 
swi_handler:
	b software_interrupt @ Call C defined interrupt handler
 
prefetch_abort:
	b   .
 
data_abort:
	b   .
 
not_used:
	b   .
 
irq:
	b   .
 
fiq:
	b   .


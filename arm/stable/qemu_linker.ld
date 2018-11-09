ENTRY(_reset)
SECTIONS
{
	. = 0x10000; /* Apparently QEMU starts here */
	.boot . : { boot.o(.text) }
	.text : { *(.text) }
	.data : { *(.data) }
	.bss : { *(.bss COMMON) }
	. = ALIGN(8);
	. = . + 0x1000; /* Size of stack */
	stacku = .;
}



/* Same as SPARC, this here says where start is */
ENTRY (_start)

SECTIONS
{
	/* Here we don't need to set headers, we just define the init address space */
	. = 0;
    .text : { *(.text*) *(.rodata*) }
    .data : { *(.data*) }
    .bss : { *(.bss*) *(COMMON*) }

}

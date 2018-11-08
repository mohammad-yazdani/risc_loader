OUTPUT_FORMAT(binary)
ENTRY(_start)
 
SECTIONS
{
    . = 0x3980;
    .main : 
    {
    	/* Here we are setting the headers manually*/

        LONG(0x01030107); /* a.out signature */
        
        LONG(_boot_end - _boot_start); /* Size of .text */
        
        /* Headers not used */
        LONG(0);
        LONG(0);
        LONG(0);
        LONG(0);
        LONG(0);
        LONG(0);
		
		/* Set up the stack (note starting in '.text') */
		_boot_start = .;
		*(.text*)
		*(.rodata*)
		*(.data*)
		*(.bss*)
		_boot_end = .;
    }
}

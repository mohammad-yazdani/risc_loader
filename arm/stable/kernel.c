// Configure Serial I/O
// TODO : DOCUMENT
#define SERIAL_BASE 0x16000000 // VERY machine dependent. This is the base for UART serial0 on VersatilePB 
#define SERIAL_FLAG_REGISTER 0x18 // UARTFR : The uart flag register for serial I/O
#define SERIAL_BUFFER_FULL (1 << 5)

// This function prints chars one by one by pushing to serial buffer
void 
putc (char c)
{
	// TODO : TEMP solution
	volatile unsigned int * const UART_serial0 = (unsigned int *)0x101f1000;

	// Wait till buffer has empty spots
	while(* (volatile unsigned long *) 
			(SERIAL_BASE + SERIAL_FLAG_REGISTER) & (SERIAL_BUFFER_FULL));

	// Push c into buffer
	*UART_serial0 = (unsigned int)(c); // Temp solution
	// *(volatile unsigned long *) SERIAL_BASE = c;

	// For newline, need to reset cursor to zero
	if (c == '\n') {
		putc('\r');
	}
}

// Push a char array (string) to serial I/O.
void
puts(const char * str)
{
	while(* str) {
		putc(*str++);
	}
}

// System prints a line with this
void
sysprintln(const char * buff)
{
	const char * who = "SYS: ";
	puts(who);
	puts(buff);
	putc('\n');
}

int
kmain() 
{
	sysprintln("Yeeeee budddd!");
	return 0;
}

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
	puts(buff);
	putc('\n');
}

void software_interrupt () __attribute__ ((interrupt ("SWI")));

void
software_interrupt() {
	volatile unsigned int call_id;
	// Fetch system call number
	asm("ldr r0, [lr, #-4]");
	asm("bic r0, #0xFF000000");
	asm("mov %0, r0":"=r"(call_id):);

	switch (call_id) {
		case 1:
			sysprintln("System call 1 :)");
			break;
		case 2:
			sysprintln("Syscall 2 :/");
			break;
		default:
			sysprintln("Sysca ... oh come on!");
			break;
	}
}

int
kmain() 
{
	char * icon = "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n@@@@@@@@@@@@@/,@@@@@@@@@@@@@@@@@@@@@@@@\n@@@@@@@@@@@@@,(,@@@@@@@@,,,@@@@@@@@@@@@\n@@@@@@@@@@@@@,@,,@@@@@@,/,@@@@@@@@@@@@@\n@@@@@@@@@@@@@,,@,@@@@@,@,@@@@@@@@@@@@@@\n@@@@@@@@@@@@@@,*,@,*@,,,@@@@@@@@@@@@@@@\n@@@@@@@@@@@@@@@,,,,,,,,@@@@@@@@@@@@@@@@\n@@@@@@@@@@@@@@,,,,,,,,,,@@@@@@@@@@@@@@@\n@@@@@@@@@@@@@@,,,,,,,,,,@@@@@@@@@@@@@@@\n@@@@@@@@@@@@@,(@@&,,@@@,/@@@@@@@@@@@@@@\n@@@@@@@@@@@@@@,,,,,,,,,,@@@@@@@@@@@@@@@\n@@@@@@@@@@@@@@,,,#@@,,,,@@@@@@@@@@@@@@@\n@@@@@@@@@@@@@@@&@@@@@@,@@@@@@@@@@@@@@@@\n@@@@@@@@@@@@@@@,@,@@*@,@@@@@@@@@@@@@@@@\n@@@@@@@@@@@@@@@@,#&&%&@@@@@@@@@@@@@@@@@\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@";
	
	sysprintln(icon);
	sysprintln("SYS: Yeeeee budddd!");

	sysprintln("Now let's do some system calls...");



	asm volatile ("SVC 0x1"); // SVC is a supervisor call and causes a SWI
	asm volatile ("SVC 0x2");
	asm volatile ("SVC 0x5"); 

	while(1) {}
	return 0;
}

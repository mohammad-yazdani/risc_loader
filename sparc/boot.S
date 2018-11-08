! CS 850 SPARC bootloader

.section .text ! The loader jumps to text section

.align 16 ! SYS ALIGN 16
.global _start ! The global start point

_start:
		call 1f ! Enter stack
			mov %o7, %l0 ! Load the return value into reg[10]

1:		mov 0x60, %l3 ! Set address of putstr in reg[13]
		add %l3, %o0, %l3 ! Actual address

		ld [%l3], %l5 ! Load function pointer to reg[15]

		mov bytearr - _start, %l4 ! Load data offset relative 
								  ! to function return
		add %l4, %l0, %l4 ! Absolute address of data

		mov %l4, %o0 ! Now we put the data pointer to the 
					 ! first argument to openfirmware client
		mov 0x0b, %o1 ! Second arg being length

		call %l5 ! Actually calling function
			nop ! No use for this return

2:
		call 2b ! Kernel loop
			nop

bytearr:
	.byte '\n' ,'H', 'e', 'l', 'l', 'o', 'S', 'P', 'A', 'R', 'C', 0


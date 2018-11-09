interrupt_vector_table:
    b . @ Reset entry point
    b . @ Exception hanlder
    b . @ sw interrupts
    b . @ TODO : Find out
    b . @ TODO : Find out
    b . @ TODO : Find out
    b . @ TODO : Find out
    b . @ TODO : Find out

.comm stack, 0x10000 @ Reserve 64k stack allcoated
_start:
    .global _start
    ldr sp, =stack+0x10000 @ Point to beginning of stack
    bl kmain @ Enter kernel kmain function
1: 
    b 1b @ Loop branching

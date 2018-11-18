AS=arm-elf-as
ASFLAGS=-g -o
CC=arm-none-eabi-gcc
CCFLAGS=-g -c -nostdlib -o
LD=arm-elf-ld
LDFLAGS=-Tqemu_linker.ld -o
GDB=arm-none-eabi-gdb
 
all: bootable
 
boot.o: boot.S
	${AS} ${ASFLAGS} boot.o boot.S
 
kernel.o: kernel.c
	${CC} ${CCFLAGS} kernel.o kernel.c
 
bootable: kernel.o boot.o
	${LD} ${LDFLAGS} bootable boot.o kernel.o
 
debug: bootable
	qemu-system-arm -M versatilepb -m 128M -serial stdio -kernel bootable
 
gdb: bootable
	${GDB} bootable
 
clean:
	rm *.o bootable
	rm *.bin

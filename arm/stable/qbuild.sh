
arm-none-eabi-as -mcpu=arm926ej-s -g boot.S -o boot.o
arm-none-eabi-gcc -c -mcpu=arm926ej-s -g kernel.c -o kernel.o
arm-none-eabi-ld -T qemu_linker.ld kernel.o boot.o -o boot.elf
arm-none-eabi-objcopy -O binary boot.elf kernel.bin


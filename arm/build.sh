
arm-none-eabi-as -o start.o start.S
arm-none-eabi-gcc -Wall -Wextra -Werror -nostdlib -nostartfiles -ffreestanding -std=gnu99 -c kernel.c
arm-none-eabi-ld -T link_script.ld -o arm_kernel start.o kernel.o

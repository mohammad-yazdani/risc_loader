# Build bin

sparc-elf-as boot.S -o boot.o
sparc-elf-ld boot.o -o boot.bin -T sparcboot.ld

# After some research, seems like the start of the 'disk' is used for boot load
dd if=/dev/zero of=bootblock.bin bs=2048 count=4
dd if=boot.bin of=bootblock.bin bs=512 seek=1 conv=notrunc

# Finally make .iso image
mkisofs -o helloworld.iso -G bootblock.bin ./cdc

# Start qemu SPARC
qemu-system-sparc -cdrom helloworld.iso



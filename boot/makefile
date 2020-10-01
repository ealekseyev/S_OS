bootsec.bin: cpuid.asm bprint.asm bootk.asm
	nasm -f bin bootsec.asm -o bootsec.bin
clean:
	rm -f *.bin 
run:
	qemu-system-x86_64 bootsec.bin
run32:
	qemu-system-i386 bootsec.bin

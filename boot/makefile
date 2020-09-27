bootsec.bin: bprint.asm bdisk.asm bloadk.asm
	nasm -f bin bootsec.asm -o bootsec.bin
clean:
	rm -f *.bin 
run:
	qemu-system-x86_64 bootsec.bin

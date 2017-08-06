all: clean hello1 hello2 hello3 hello4

clean:
	rm -f *.o *.bin *.tap

hello1: hello_world_1.asm
	z80asm +zx hello_world_1.asm

hello2: hello_world_2.asm
	z80asm +zx hello_world_2.asm

hello3: hello_world_3.asm
	z80asm -b -o=hello_world_3.bin -r=33000 hello_world_3.asm
	appmake +zx -b hello_world_3.bin --org 33000

hello4: hello_world_4.asm
	z80asm -b -o=hello_world_4.bin -r=33000 hello_world_4.asm
	appmake +zx -b hello_world_4.bin --org 33000

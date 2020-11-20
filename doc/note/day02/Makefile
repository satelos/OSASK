.PHONY: build
build:
	nasm -f bin hellos.asm -o hellos.img

.PHONY: run
run: build
	qemu-system-i386 hellos.img

.PHONY: build-ipl
build-ipl:
	nasm -f bin ipl.asm -o ipl.img

.PHONY: run-ipl
run-ipl: build-ipl
	qemu-system-i386 ipl.img

.PHONY: clean
clean:
	rm -f *.img
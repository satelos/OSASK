.PHONY: build
build:
	nasm -f bin hellos.asm -o hellos.img

.PHONY: run
run: build
	qemu-system-i386 hellos.img

.PHONY: build-hex
build-hex:
	nasm -f bin hellos-hex.asm -o hellos-hex.img

.PHONY: run-hex
run-hex: build-hex
	qemu-system-i386 hellos-hex.img

.PHONY: clean
clean:
	rm -f *.img
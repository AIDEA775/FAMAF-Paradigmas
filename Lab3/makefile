all:
	ocamlbuild -I src guerraFuncional.native
	mv _build/src/guerraFuncional.native bin
	rm -R _build
	rm guerraFuncional.native

clean:
	rm bin/guerraFuncional.native

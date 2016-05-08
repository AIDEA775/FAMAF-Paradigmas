all:
	ocamlbuild -I src guerraFuncional.native
	mv _build/src/guerraFuncional.native bin
	rm -R _build
	rm guerraFuncional.native

dbg:
	ocamlbuild -I src guerraFuncional.d.byte
	mv _build/src/guerraFuncional.d.byte bin
	rm -R _build
	rm guerraFuncional.d.byte
	ocamldebug bin/guerraFuncional.d.byte

clean:
	rm -rf bin/*
	rm -rf _build

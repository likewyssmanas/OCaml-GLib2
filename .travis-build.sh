sh .travis-libffi.sh
sh .travis-ocaml.sh
export OPAMYES=1
eval `opam config env`
opam install ocamlfind
opam install base
opam install ounit
opam install ctypes
opam install ctypes-foreign
opam install jbuilder
sh .travis-gobject-introspection.sh
jbuilder build # jbuilder runtest when tests will be started.
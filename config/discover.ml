open Base
open Stdio
module C = Configurator

let write_sexp fn sexp =
  Out_channel.write_all fn ~data:(Sexp.to_string sexp)

let () =
  C.main ~name:"GLib" (fun c ->
      let default : C.Pkg_config.package_conf =
        { libs   = ["-lglib-2.0"] ;
          cflags = ["-O2"; "-Wall"; "-Wextra"; "-Wno-unused-parameter";
                    "-pthread"; "-I/usr/include/glib-2.0";
                    "-I/usr/lib/glib-2.0/include"]
        }
      in
      let default_ffi : C.Pkg_config.package_conf =
        { libs   = [] ;
          cflags = []                  (* default ubuntu *)
        }
      in
      let conf =
        match C.Pkg_config.get c with
        | None -> default
        | Some pc ->
          let query = C.Pkg_config.query pc ~package:"libffi" in
          let libffi = Option.value query ~default:default_ffi in
          let query = C.Pkg_config.query pc ~package:"glib-2.0" in
          let glib = Option.value query ~default in
          let  module P = C.Pkg_config in
          { libs =
              (libffi.P.libs @ glib.P.libs);
            cflags =
              (libffi.P.cflags @ glib.P.cflags)
          }
      in
      let list_of_string_to_sexp = sexp_of_list sexp_of_string in
      write_sexp "c_flags.sexp"         (list_of_string_to_sexp conf.cflags);
      write_sexp "c_library_flags.sexp" (list_of_string_to_sexp conf.libs))

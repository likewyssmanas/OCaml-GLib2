open Ctypes

type t = Do_not_use_this_unsupported_flag | Treat_cdata_as_text | Prefix_error_position | Ignore_qualified
type t_list = t list

val of_value:
  Unsigned.uint32 -> t

val to_value:
  t -> Unsigned.uint32

val list_of_value:
  Unsigned.uint32 -> t_list

val list_to_value:
  t_list -> Unsigned.uint32

val t_list_view : t_list typ


let rec leer_letra unit : char =
  let s = read_line() in
  match String.length s with
  | 0 -> leer_letra()
  | _ -> s.[0]


let rec leer_palabra unit : string =
  let s = read_line() in
  match String.length s with
  | 0 -> leer_palabra()
  | _ -> s


(* debug *)
let () =
  let open Printf in
  printf ">>> Palabra: %s\n" (leer_palabra () );
  printf ">>> Letra: %c\n" (leer_letra() );;

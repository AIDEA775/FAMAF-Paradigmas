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

let limpiar unit : unit = print_string "\x1B[2J";;

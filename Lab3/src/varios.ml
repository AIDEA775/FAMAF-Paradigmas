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

let rec at k = function
  | [x] -> x (* tiene que ser *)
  | h::t -> if k = 1 then h else at (k-1) t;;

let rec insert x n = function
  | [] -> [x]
  | h::t as l -> if n = 0 then x::l else h::insert x (n-1) t;;

let rec remove n = function
  | [] -> []
  | h::t -> if n = 0 then t else h::remove (n-1) t;;

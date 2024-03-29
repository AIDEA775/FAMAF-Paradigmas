let rec leer_letra unit : char =
  let s = read_line() in
  match String.length s with
  | 0 -> leer_letra()
  | _ -> s.[0];;

let rec leer_palabra unit : string =
  let s = read_line() in
  match String.length s with
  | 0 -> leer_palabra()
  | _ -> s;;

let leer_nada unit : unit =
  read_line();
  print_endline "";;

let set_pos x y =
  print_string ("\x1b[" ^ string_of_int y ^ ";" ^ string_of_int x ^ "H");;

let limpiar unit : unit = print_string "\x1B[2J";;

let limpiar_linea x y =
  set_pos x y;
  print_string "                                                        ";
  set_pos x y;;

let titulo unit : unit =
  set_pos 0 2;
  print_string "     ={---{--{-{{GUERRA FUNCIONAL}}-}--}---}=\n\n";;

let rec at k = function
  | [] -> assert false
  | [x] -> x (* tiene que ser *)
  | h::t -> if k = 0 then h else at (k-1) t;;

let rec insert x n = function
  | [] -> [x]
  | h::t as l -> if n = 0 then x::l else h::insert x (n-1) t;;

let rec remove n = function
  | [] -> []
  | h::t -> if n = 0 then t else h::remove (n-1) t;;

(* Snake Game by OCaml                      *)
(* see) http://newral.info/publics/index/79 *)
(*      column No.19 - No.23                *)

let cls () = print_string "\x1B[2J";;

let set_pos (x,y) =
  print_string ("\x1b[" ^ string_of_int y ^ ";" ^ string_of_int x ^ "H");;

let show_board () =
  set_pos (0,0);
  print_endline "+-----+";
  print_endline "|     |";
  print_endline "|     |";
  print_endline "|     |";
  print_endline "|     |";
  print_endline "|     |";
  print_endline "+-----+";;

let show_snake snake =
  ignore(List.map (fun (x,y) -> set_pos(x+1, y+1); print_char '*') snake);;

let show_apple (x,y) = set_pos(x+1, y+1); print_char 'O';;

let show_game apple snake =
  cls ();
  show_board();
  show_apple apple;
  show_snake snake;
  set_pos(0,8);;

type move = Up | Down | Right | Left;;

let rec get_move () =
  let s = read_line() in
  if String.length s = 0 then
    get_move()
  else
    match s.[0] with
      'w' -> Up | 's' -> Down | 'a' -> Left | 'd' -> Right
    | _ -> get_move();;

let rec new_apple snake =
  let x = (Random.int 5) + 1 and
      y = (Random.int 5) + 1 in
  if List.mem (x,y) snake then
    new_apple snake
  else
    (x,y);;

let add_head move snake =
  match snake with
    [] -> []
  | ((x, y) :: _) ->
    match move with
      Up    -> (x,y-1) :: snake
    | Down  -> (x,y+1) :: snake
    | Right -> (x+1,y) :: snake
    | Left  -> (x-1,y) :: snake;;    

let drop_tail = function
    [] -> [];
  | snake -> List.rev (List.tl (List.rev snake));;

let is_eated apple snake =
  match snake with
    [] -> false
  | (head :: body) -> head = apple;;

let update_state move snake apple =
  let snake' = add_head move snake in
  if is_eated apple snake' then
    (snake', new_apple snake')
  else
    (drop_tail snake', apple);;

let is_gameover = function
    [] -> false
  | ((x,y) as head :: body) ->
      x = 0 || x = 6 || y = 0 || y = 6 || List.mem head body;;

(* input >> update >> show loop *)
let rec game_loop snake apple =
  let move = get_move() in
  let (snake', apple') = update_state move snake apple in
  show_game apple' snake';
  if is_gameover snake' then
    print_endline ("Game over snake length:" ^
                    string_of_int (List.length snake'))
  else
    game_loop snake' apple';;

(* main function *)
let () =
  Random.self_init();
  let snake = [(1,1)] in
  let apple = new_apple snake in
  show_game apple snake;
  game_loop snake apple;;

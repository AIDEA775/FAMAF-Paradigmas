open Cartas

type jugador = {nombre : string; puntos : int};;

let jugador_nuevo s = {nombre=s; puntos=0};;

let jugador_nombre {nombre=n; _} = n ^ "";;

let jugador_puntos {puntos=p; _} = p;;

let jugador_act_puntos j =
  let p=j.puntos in
  {j with puntos=p+1};;

let jugador_juega j = true;;

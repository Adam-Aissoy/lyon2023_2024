(**
test pour conctenation d'une chaine de caractère    
*)

let test_concatenation () =
  assert_equal "helloworld" ("hello" @ "world")

let suite = "Test Suite" >::: ["test concatenation" >:: test_concatenation]
let _ = run_test_tt_main suite
;;
(** une fonction somme int  *)
let rec somme (l : int list) : int = 
  match l with
  | [] -> 0
  | x::l -> x + somme l;;
  
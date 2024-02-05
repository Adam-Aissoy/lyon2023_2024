let paragraphe_bottles (nb_bottles : int) : string =
  match nb_bottles with
  | 0 ->
    "No more bottles of beer on the wall, no more bottles of beer.\n" ^
    "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
  | 1 ->
    "1 bottle of beer on the wall, 1 bottle of beer.\n" ^
    "Take it down and pass it around, no more bottles of beer on the wall.\n"
  | 2 ->
    "2 bottles of beer on the wall, 2 bottles of beer.\n" ^
    "Take one down and pass it around, 1 bottle of beer on the wall.\n"
  | n ->
    string_of_int n ^ " bottles of beer on the wall, " ^ string_of_int n ^ " bottles of beer.\n" ^
    "Take one down and pass it around, " ^ string_of_int (n - 1) ^ " bottles of beer on the wall.\n"
;;

(* Exemples d'utilisation *)
print_string (paragraphe_bottles 5);
print_string (paragraphe_bottles 2);
print_string (paragraphe_bottles 1);
print_string (paragraphe_bottles 0);
(*test Adam Aysoy *)

let paragraphe_bottles n =
  match n with
  | 0 -> "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"
  | 1 -> "1 bottle of beer on the wall, 1 bottle of beer.\nTake one down and pass it around, no more bottles of beer on the wall.\n"
  | 2 -> "2 bottles of beer on the wall, 2 bottles of beer.\nTake one down and pass it around, 1 bottle of beer on the wall.\n"
  | _ -> (string_of_int n) ^ " bottles of beer on the wall, " ^ (string_of_int n) ^ " bottles of beer.\nTake one down and pass it around, " ^ (string_of_int (n-1)) ^ " bottles of beer on the wall.\n"


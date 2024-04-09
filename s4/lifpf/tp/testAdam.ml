let renverse = 
  let rec renverse_ajoute (lr :int list)(lc : int list ): int list =
    match lr with
    | [] -> lc
    | n::lr' -> renverse_ajoute lr' (n::lc) 
  in fun (l : int list) renverse_ajoute l []
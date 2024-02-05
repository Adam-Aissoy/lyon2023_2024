module AssocList = struct
  type key = string
  type 'a t = (string * 'a) list

  let empty : 'a t = []
  let put (k : key) (v : 'a) (a : 'a t) : 'a t = (k, v) :: a
  let get : key -> 'a t -> 'a option = List.assoc_opt

  let keys (a : 'a t) : key list =
    List.fold_left
      (fun acc (k, v) ->
        if List.mem k acc then acc else k :: acc)
      [] a
end

module type SAssoc = sig
  type key
  type 'a t

  val empty : 'a t
  val put : key -> 'a -> 'a t -> 'a t
  val get : key -> 'a t -> 'a option
  val keys : 'a t -> key list
end

module AssocTreePb : SAssoc = struct
  type key = string
  type 'a t = Vide | Noeud of (string * 'a * 'a t * 'a t)

  let empty = Vide

  let rec put k v a =
    match a with
    | Vide -> Noeud (k, v, Vide, Vide)
    | Noeud (k', v', fg, fd) ->
        if k = k' then Noeud (k, v, fg, fd)
        else if k < k' then Noeud (k', v', put k v fg, fd)
        else Noeud (k', v', fg, put k v fd)

  let rec get k a =
    match a with
    | Vide -> None
    | Noeud (k', v', fg, fd) ->
        if k = k' then Some v'
        else if k < k' then get k fg
        else get k fd

  let rec keys =
    let rec aux a ks =
      match a with
      | Vide -> ks
      | Noeud (k, _, fg, fd) -> k :: aux fg (aux fd ks)
    in
    fun a -> aux a []
end

let a = AssocTreePb.put "toto" 3 AssocTreePb.empty

module AssocTree : SAssoc with type key = string = struct
  type key = string
  type 'a t = Vide | Noeud of (string * 'a * 'a t * 'a t)

  let empty = Vide

  let rec put k v a =
    match a with
    | Vide -> Noeud (k, v, Vide, Vide)
    | Noeud (k', v', fg, fd) ->
        if k = k' then Noeud (k, v, fg, fd)
        else if k < k' then Noeud (k', v', put k v fg, fd)
        else Noeud (k', v', fg, put k v fd)

  let rec get k a =
    match a with
    | Vide -> None
    | Noeud (k', v', fg, fd) ->
        if k = k' then Some v'
        else if k < k' then get k fg
        else get k fd

  let rec keys =
    let rec aux a ks =
      match a with
      | Vide -> ks
      | Noeud (k, _, fg, fd) -> k :: aux fg (aux fd ks)
    in
    fun a -> aux a []
end

module Assoc : SAssoc with type key = string = AssocList

module Factures = struct
  type facture = (int * float) Assoc.t

  let ajoute (article : string) (quantite : int) (prix : float)
      (f : facture) : facture =
    match Assoc.get article f with
    | None -> Assoc.put article (quantite, prix) f
    | Some (q', _) -> Assoc.put article (quantite + q', prix) f

  let string_of_item fact article =
    match Assoc.get article fact with
    | None -> ""
    | Some (qte, px) ->
        article ^ "(" ^ string_of_int qte ^ "): "
        ^ string_of_float px ^ "€"

  let string_of_facture (f : facture) : string =
    Assoc.keys f
    |> List.map (string_of_item f)
    |> List.fold_left (fun acc s -> acc ^ "\n" ^ s) ""
end

module Factures (Assoc : SAssoc with type key = string) = struct
  type facture = (int * float) Assoc.t

  let ajoute (article : string) (quantite : int) (prix : float)
      (f : facture) : facture =
    match Assoc.get article f with
    | None -> Assoc.put article (quantite, prix) f
    | Some (q', _) -> Assoc.put article (quantite + q', prix) f

  let string_of_item fact article =
    match Assoc.get article fact with
    | None -> ""
    | Some (qte, px) ->
        article ^ "(" ^ string_of_int qte ^ "): "
        ^ string_of_float px ^ "€"

  let string_of_facture (f : facture) : string =
    Assoc.keys f
    |> List.map (string_of_item f)
    |> List.fold_left (fun acc s -> acc ^ "\n" ^ s) ""
end

module FacturesTree = Factures (AssocTree)

let _ =
  FacturesTree.string_of_facture
    (FacturesTree.ajoute "trombones" 100 0.01 AssocTree.empty)

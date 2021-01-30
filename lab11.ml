(*
                             CS51 Lab 11
                              Synthesis
 *)

(* Objective:

This lab is intended to provide a review and synthesis of the first
half of the course.
 *)

(*====================================================================
Part 1. Functional fundamentals

......................................................................
Exercise 1. Each subproblem below consists of two definitions
involving a single expression (for instance, the expression `2 * 3 *
7` in the first example) -- one concerns the *type* of the expression
and one concerns its *value*. Each of the definitions includes a ???
to replace. The pair of definitions are initially commented out.

For each of the expressions below, determine if the expression is
well-typed. If so, uncomment the pair of definitions, and replace the
first ??? with the expression's type. If the expression is not
well-typed, simply leave the whole part -- the pair of definitions --
commented out, and move on to the next expression.

Then, for each of *the typable expressions only*, replace the second
??? with to replace the second ??? with the expression's value if any,
or replace it with the string "NO VALUE".  (For function values give
the value simply as the string "<fun>" and for abstract values use the
string "<abstr>", mimicking the OCaml \repl.)

We've done the first expression for you as an example.

Try these without using the REPL before typing them into the REPL to
check your answers.
....................................................................*)

(*
  let typing1 () : ??? = 2 * 3 * 7 ;;
  let value1 () = ??? ;;
 *)

(* ANSWER: After uncommenting and replacing the ???s: *)

let typing1 () : int = 2 * 3 * 7 ;;
let value1 () = 42 ;;

(*
let typing2 () : ??? = let rec f = fun x -> if x = 1 then pred x
                                            else f (pred x) in
                       f 1000 ;;
let value2 () = ??? ;;
 *)

(*
let typing3 () : ??? = List.fold_left (||) false [true] ;;
let value3 () = ??? ;;
 *)

(*
let typing4 () : ??? = Some None ;;
let value4 () = ??? ;;
 *)

(*
let typing5 () : ??? = let rec f g h = f g h in f ;;
let value5 () = ??? ;;
 *)

(*
let typing6 () : ??? = let rec f g h = h f g in f ;;
let value6 () = ??? ;;
 *)

(*
let typing7 () : ??? = let rec f g h = f h g in f ;;
let value7 () = ??? ;;
 *)
        
(*
let typing8 () : ??? = let x = 2.0 in
                       let x = "2.0" in
                       x ^ x ;;
let value8 () = ??? ;;
 *)

(*
let typing9 () : ??? = let x = 5 in
                       if x > 10 then true else raise Exit ;;
let value9 () = ??? ;;
 *)

(*
let typing10 () : ??? = if if true then false else true then false else true ;;
let value10 () = ??? ;;
 *)
     
(*....................................................................
Exercise 2. Without using any functions from the `List` module, define
a function `copies : int -> string -> string` such that `copies n str`
returns a string composed of `n` copies of the given string `str`. If
`n` is negative, the function should return the empty string. For
example:

  # copies 4 "abc" ;;
  - : string = "abcabcabcabc"
  # copies (-2) "abc" ;;
  - : string = ""
  # copies 12 "o_O " (* a crowd *) ;;
  - : string = "o_O o_O o_O o_O o_O o_O o_O o_O o_O o_O o_O o_O "
....................................................................*)

let copies : int -> string -> string =
  failwith "copies not implemented" ;;

(*====================================================================
Part 2. Multisets

A multiset is a mathematical object much like a set -- that is, an
unordered collection of elements -- except that a multiset, unlike a
set, can contain more than one instance of the same element. Natural
operations on multisets include adding and dropping elements and
determining the count of how many occurrences of an element (zero or
more) exist in a multiset, as well as union and intersection of
multisets. In this section, you'll work with a multiset module
signature and its implementation. But first, a short digression.

2.1 Comparing values

Recall the definition of the `COMPARABLE` module signature from the
textbook that packages together a type with an ordering function over
elements of the type. (Note that the `compare` function here uses a
different convention for its return value than the one from the
previous section; it returns an `order`, not an `int`.)

We repeat the module signature here for your reference: *)
   
module type COMPARABLE =
  sig
    type t
    type order = Less | Equal | Greater
    val compare : t -> t -> order
  end ;;

(*....................................................................
Exercise 3. Define a module called `IntComparable` that satisfies the
`COMPARABLE` signature where the type `IntComparable.t` is `int`. Your
definition should allow for behavior like

  # IntComparable.compare 3 4 ;;
  - : IntComparable.order = IntComparable.Less
  # IntComparable.compare 5 5 ;;
  - : IntComparable.order = IntComparable.Equal

Make sure to apply an appropriate module signature to
`IntComparable`. This module will be useful in the later parts of this
section.
....................................................................*)

module IntComparable = struct end ;;

(* 2.2  A multiset signature and its implementation

A signature for a multiset abstract data type is the following: *)

module type MULTISET =
  sig
    type element  (* the type of elements of the multiset *)
    type t        (* the type of the multiset itself *)
           
    (* an empty multiset *)
    val empty_set : t
    (* empty_p mset -- Returns `true` if and only if `mset`
       is empty *)
    val empty_p : t -> bool
    (* add elt mset -- Returns a multiset like `mset` with
       one more `elt` *)
    val add : element -> t -> t
    (* drop elt mset -- Returns a multiset with one `elt`
       removed from `mset` *) 
    val drop : element -> t -> t
    (* count elt mset -- Returns the number of `elt`s in
       `mset` *)
    val count : element -> t -> int
    (* union mset1 mset2 -- Returns a multiset containing
       the elements of both argument multisets *)
    val union : t -> t -> t
    (* intersection elt mset -- Returns a multiset containing
       the elements that are in both argument multisets *)
    val intersection : t -> t -> t
  end ;;

(*....................................................................
Exercise 4: Below is an implementation of the signature as a functor
`MakeMultiset` that generates modules implementing the `MULTISET`
signature whose elements are taken from a `COMPARABLE` module. In this
implementation, the multiset is internally represented as a list of
pairs of an element and the count of how many times the element occurs
in the multiset. It obeys the invariants that counts are always
positive and the pairs are kept sorted by the element.

You'll notice that in the second line of the functor implementation,
there's a comment where the signature of the module that the functor
generates should go. What ought to go there to specify the signature
of modules generated by the `MakeMultiset` functor? Replace the
comment with the proper specification of the module signature.
....................................................................*)

module MakeMultiset (Element : COMPARABLE)
               (* : ...the module signature goes here... *)  =
  struct
    type element = Element.t

    (* multisets are implemented as an association list of elements
       and their count, sorted by element according to the
       comparison function *)
    type t = (element * int) list
                             
    let empty_set = []
                      
    let empty_p mset = mset = empty_set

    let rec adjust fn elt mset =
      match mset with
      | [] -> let newcount = fn 0 in
              if newcount = 0 then mset
              else (elt, newcount) :: mset
      | (current, curcount) :: rest ->
         match Element.compare elt current with
         | Less -> let newcount = fn 0 in
                   if newcount = 0 then mset
                   else (elt, newcount) :: mset
         | Equal -> let newcount = fn curcount in
                    if newcount = 0 then rest
                    else (elt, newcount) :: rest
         | Greater -> (current, curcount) :: adjust fn elt rest

    let add elt mset =
      adjust succ elt mset

    let drop elt mset =
      adjust (fun count -> max 0 (pred count)) elt mset

    let rec count elt mset =
      match mset with
      | [] -> 0
      | (current, curcount) :: rest ->
         match Element.compare elt current with
         | Less -> 0
         | Equal -> curcount
         | Greater -> count elt rest
         
    let adjustmultiple elt adjustment mset =
      adjust ((+) adjustment) elt mset

    let rec union mset1 mset2 =
      match mset1 with
      | [] -> mset2
      | (current, curcount) :: rest ->
           adjustmultiple current curcount (union rest mset2)

    let rec intersection mset1 mset2 =
      match mset1 with
      | [] -> []
      | (current, curcount) :: rest ->
         adjustmultiple current (min curcount (count current mset2))
                        (intersection rest mset2)
  end ;;

(*....................................................................
Exercise 5: Using the `MakeMultiset` functor, define a module
`IntMultiset` for multisets of integers.
....................................................................*)

(* Place the definition of IntMultiset here. *)
     
(*....................................................................
Exercise 6: In a sentence, explain the advantage of using a *functor*
to generate (monomorphic) implementations of the `MULTISET` signature,
as above, over providing a single (polymorphic) *module*.
....................................................................*)

(* Place your explanation here and call over a staff member to talk
it through. *)
     
(* For the remaining problems in this section, we will open the
`IntMultiset` module for your convenience. *)

open IntMultiset ;;

(*....................................................................
Exercise 7: Now define an integer multiset `m` that contains two 5s
and a 1.
....................................................................*)

let m = failwith "multiset not implemented" ;;

(*....................................................................
Exercise 8: Give an expression of type `bool` that evaluates to `true`
just in case the multiset `m` has more 5s than 1s. Give it the name
`morefives`.
....................................................................*)

let morefives = failwith "morefives not implemented" ;;

(*====================================================================
Part 3. The royal succession

    In this part, you should feel free to make idiomatic use of
    library functions such as `map`, `fold_left`, `fold_right`, and
    `filter` and other functions from the the `List` module and the
    `Stdlib` module. For brevity, we've opened the `List` module. *)

open List ;;
  
(* The royal succession is the sequencing of members of the British
royal family as to what order they will ascend to the throne.  As of
the passing of the Succession to the Crown Act 2013, the succession
order is based on ``absolute primogeniture'', a traversal of the
family tree of the monarch with the parent at the root of the tree
coming before the children's families and with siblings ordered by
age. (Sex and membership in the Catholic Church are no longer
factors.) Thus, for instance, for the Windsor (partial) family tree
depicted in Figure~\ref{fig:windsors}, the order of succession begins
at the root of the tree with Elizabeth, then succeeding to the oldest
child Charles and his family (in primogeniture order -- William,
George, Charlotte, etc.), then Anne and her family, and finally Andrew
and Edward's families.

We can represent a royal family tree using the following type
definition, a record type that contains the name and age of a royal,
together with a list of children: *)

type royal = {name : string;
              age : int;
              children : royal list} ;;

(* The Windsor family (or at least a portion of it) is then given by
this definition of `windsors`, which is used below. *)

let windsors =
  {name = "Elizabeth";
   age = 93;
   children =
     [{name = "Anne";
       age = 69;
       children = [{name = "Peter";
                    age = 42;
                    children = [] (* eliding two children *) };
                   {name = "Zara";
                    age = 38;
                    children = [] (* eliding two children *) }]};
      {name = "Andrew";
       age = 60;
       children = [] (* eliding two children *)};
      {name = "Charles";
       age = 71;
       children = [{name = "William";
                    age = 37;
                    children = [{name = "Louis";
                                 age = 1;
                                 children = []};
                                {name = "George";
                                 age = 6;
                                 children = []};
                                {name = "Charlotte";
                                 age = 4;
                                 children = []}]};
                   {name = "Harry";
                    age = 35;
                    children = [{name = "Archie";
                                 age = 0;
                                 children = []}]}]};
      {name = "Edward";
       age = 55;
       children = [] (* eliding two children *)}]} ;;  
  
(* Recall that the `Stdlib` function `compare : int -> int -> int`
compares two integers `x` and `y` using the following convention: It
returns `0` if `x` is equal to `y`, a negative integer if `x` is less
than `y`, and a positive integer if `x` is greater than `y`.  (This is
just the convention expected by the `List.sort : ('a -> 'a -> int) ->
'a list -> 'a list` function.)

......................................................................
Exercise 9: Define a function `compare_age : royal -> royal -> int`
that uses the same convention to compare the ages of two royals. That
is, it returns a negative integer if the first of the two royals is
younger, zero if the same age, and a positive integer if the first of
the two is older.
....................................................................*)

let compare_age : royal -> royal -> int =
  failwith "compare_age not implemented" ;;

(*....................................................................
Exercise 10: Is your definition of `compare_age` curried or uncurried?
Select the correct value of the provided enumeration type `exercise10`
for your answer and use it to define `exercise10answer`.
....................................................................*)

type exercise10 =
  | Unanswered
  | Curried
  | Uncurried
  | Neither ;;

let exercise10answer = Unanswered ;;

(*....................................................................
Exercise 11: Define a function `count_royals` that returns the number
of royals in its argument royal family tree. For instance,

  # count_royals windsors ;;
  - : int = 13
....................................................................*)

let count_royals royals =
  failwith "count_royals not implemented" ;;

(*....................................................................
Exercise 12: What is the type of `count_royals`? 
....................................................................*)  

(* Place your conclusion here and call over a staff member to verify
it. *)
   
(*....................................................................
Exercise 13: Define a function `primogeniture : royal -> string
list`, which returns a list of the names of the members of a royal
family in primogeniture order (that is, according to the succession
traversal derived above). For instance, the computation

  # primogeniture windsors ;;
  - : string list =
  ["Elizabeth"; "Charles"; "William"; "George"; "Charlotte"; "Louis";
   "Harry"; "Archie"; "Anne"; "Peter"; "Zara"; "Andrew"; "Edward"]

shows that 6-year-old George is the third in line to the throne after
Charles and William.

Feel free to make use of functions you've implemented in previous
problems as well as `List` library functions.  Keep in mind that
the `royal` data structure might not have the children listed in
age order (for instance, as in the `windsors` definition above).
....................................................................*)

let primogeniture family =
  failwith "primogeniture not implemented" ;;

(*
                              END OF LAB
*) 

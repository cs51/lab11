(*
                             CS51 Lab 11
                              Synthesis
 *)

open List ;;
  
(* Objective:

This lab is intended to provide a review and synthesis of the first
half of the course.
 *)

(*====================================================================
Part 1. Finger exercises

......................................................................
Exercise 1a. Provide a succinct definition of a function named
`add_three` that returns the sum of three and its integer argument.
....................................................................*)

let add_three = failwith "add_three not implemented" ;;

(*....................................................................
Exercise 1b. Define a curried function named `power` that returns its
first argument (an integer) raised to the power of its second argument
(also an integer, which you can assume is nonnegative), returning an
integer result.
....................................................................*)

let power = failwith "power not implemented" ;;

(*....................................................................
Exercise 1c. Now define an uncurried version of `power`, called
`power_uncurried`.
....................................................................*)

let power_uncurried = failwith "power_uncurried not implemented" ;;

(*====================================================================
Part 2. Types of subexpressions in context

Consider this snippet of code, which defines an algebraic data type
`'a combine` and a function `f`:

    type 'a combine =
      | Combine of ('a -> 'a) * ('a combine)
      | Base of ('a -> 'a) * ('a option) ;;

    let rec f (x : 'a combine) (a : 'a) : 'a =
      match x with
      | Base (f, None) -> f a
                          ^^^ -----------a
      | Base (f, Some x) -> f x
                            ^ -----------b 
      | Combine (g, r) -> f r (g a) ;;
                          ^ -------------c
                          ^^^ -----------d
                              ^^^^^ -----e

For each of the subexpressions underlined with ^^^ and labeled with a
letter, specify the type of the subexpression in the context in which
it appears. If the unerlined element is not a single subexpression (and
therefore has no type), answer "no type".

......................................................................
Exercise 2a: What is the type of the expression `f a` that is labeled
"a"? Provide your answer as a string as the value of `exercise2a`:
....................................................................*)

let exercise2a = "exercise2a not provided" ;;

(*....................................................................
Exercise 2b: What is the type of the expression `f` that is labeled
"b"?
....................................................................*)

let exercise2b = "exercise2b not provided" ;;

(*....................................................................
Exercise 2c: What is the type of the expression `f` that is labeled
"c"?
....................................................................*)

let exercise2c = "exercise2c not provided" ;;

(*....................................................................
Exercise 2d: What is the type of the expression `f r` that is labeled
"d"?
....................................................................*)

let exercise2d = "exercise2d not provided" ;;

(*....................................................................
Exercise 2e: What is the type of the expression `(g a)` that is labeled
"e"?
....................................................................*)

let exercise2e = "exercise2e not provided" ;;

(*====================================================================
Part 3. Short answer questions

Each of the code snippets below has a blank in it, marked with a long
underline. Your job is to insert a single OCaml pattern or expression
that can fill the blank such that the variable `exercise3x` is defined
to be `42`.

(Note that the expressions may reference and make use of earlier
definitions and functions in the exam.)

For example, if we provide the snippet

    let f x = x + 3 ;;
    let exercise3a = f _______________ ;;

you could replace the underline with `39` or `3 * 13` or any of a wide
variety of other expressions, like this:

    let f x = x + 3 ;;
    let exercise3a = f 39 ;;

If no such expression exists, replace the entire definition of
`exercise3n` with the integer `0`, that is,

    let exercise3a = 0 ;;

......................................................................
Exercise 3b
....................................................................*)

let exercise3b = 
  let setup = _____________ in
  match setup with 
  | [] -> 21
  | hd :: _tl -> hd ;;

(*....................................................................
Exercise 3c
....................................................................*)

let exercise3c =
  let setup pair = _____________ in
  let (x, y) = setup (14, 42) in
  x + y + setup (14, 0) ;;

(*....................................................................
Exercise 3d
....................................................................*)

let exercise3d =
  let setup = _____________ in
  setup (setup 21) ;;

(*....................................................................
Exercise 3e
....................................................................*)

type various = {first : int; second : bool} ;;

let exercise3e =
  let {first; second} = _____________ in
  first + if not second then ~- first 
          else first * first ;;
   
(*====================================================================
Part 4. Higher-order functional programming

The following problems ask you to define simple functions. Each
solution should nontrivially use **one** of the `List` module
higher-order functions for mapping, folding, and filtering **exactly
once** to implement the function (in addition to constructs from the
base OCaml language). We've opened the `List` module above for your
convenience.

......................................................................
Exercise 4a: The `tower` function takes a list of integers `[a1; a2;
a3; ...; an]` and returns their nested exponentiation

    a_1 ^ a_2 ^ a_3 ^ ... ^ a_n         .

For example,

    # tower [2; 2] ;;
    - : int = 4
    # tower [2; 3] ;;
    - : int = 8
    # tower [2; 3; 2] ;;
    - : int = 512

(Notice that the last example computes 2 ^ (3^2) = 512 and not (2^3)^2
= 64.)

Implement `tower` (using map/fold/filter as specified above). You may
assume that all of the exponents are nonnegative. You may assume
availability of a correct implementation of the `power` function as
described in Exercise 1b as well. Your implementation may handle the
empty list however you see fit.

Hint: a ^ 1 = a
....................................................................*)

let tower = failwith "tower not implemented" ;;
     
(*....................................................................
Exercise 4b: The `List.find` function is described as follows in the
`List` module documentation:

    `val find : ('a -> bool) -> 'a list -> 'a`
    `find p l` returns the first element of the list `l` that satisfies the predicate `p`.
    Raises `Not_found` if there is no value that satisfies `p` in the list `l`.

It has the following behavior:

    # find ((=) 4) [1; 3; 5; 7] ;;
    Exception: Not_found.
    # find ((=) 4) [1; 3; 4; 7] ;;
    - : int = 4
    # find ((<) 4) [1; 3; 5; 1] ;;
    - : int = 5

Implement `find` (using only one map/fold/filter as specified above).
....................................................................*)

let find = failwith "find not implemented" ;;

(*====================================================================
Part 5. Circuits of resistors

This problem concerns circuits of electrical resistors, but you don't
need to know anything about the topic; we'll cover everything you need
to know about resistors here.

In an electrical circuit, a _resistor_ is a component that impedes the
flow of electricity by a certain amount, called its _resistance_, and
measured in _ohms_. We depict a resistor whose resistance is R ohms
with a graphic like the one in Figure 1(a).

    The figure is available at <https://url.cs51.io/lab11-1>.

    **Figure 1: Circuits of resistors: (a) A resistor of R
      ohms. (b) A circuit of two resistors of 2 ohms and 4 ohms in
      series. (c) A circuit of two resistors of 2 ohms and 4 ohms
      in parallel. (d) A more complex circuit made of four
      resistors, three combined in parallel followed by one in
      series.**

A resistor can serve all by itself as a simple circuit. But circuits
can also be combined to form more complex circuits.  Circuits are
formed by combining simpler circuits (including individual resistors)
using one of two modes of combination: series or parallel. For
instance, Figure 1(b) depicts a circuit formed from two resistors
(with resistances 2 and 4 ohms, respectively) combined in series, and
Figure 1(c) depicts one formed from combining the same resistors in
parallel. By combining circuits with other circuits in series and in
parallel, we can generate more complex circuits, like the one in
Figure 1(d). The three-way parallel circuit can be thought of as
constructed by two nested parallel circuits.

The resistance R of a circuit formed by combining two circuits of
resistance R_1 and R_2 in series is simply the sum of the
resistances:

    R = R_1 + R_2

So the resistance of the series circuit in Figure 1(b) is 2 + 4 = 6
ohms.

The resistance R of a circuit formed by combining two circuits of
resistance R_1 and R_2 in parallel is

                1 
         ---------------
    R =     1       1
          ----- + ----- 
           R_1     R_2

So the resistance of the parallel circuit in Figure 1(c) is
1 / (1/2 + 1/4) = 4/3 ohms.  *)
   
(*....................................................................
Exercise 5a: Define an algebraic data type `circuit` for circuits that
can be composed of a single resistor (with its resistance given as a
`float`) or composed of a pair of circuits connected either in series
or in parallel.

So that later problems use the same type definition, after you've
defined the type, check it against our intended type definition at
<http://url/cs51/io/lab11-2>.
....................................................................*)

type circuit = NotImplemented ;;

(*....................................................................
Exercise 5b: Define a value `circ_a` of type `circuit` that represents
a single resistor of 3 ohms.
....................................................................*)
   
let circ_a = failwith "circ_a not implemented" ;;

(*....................................................................
Exercise 5c: Define a value `circ_c` of type `circuit` that represents
the circuit in Figure 1(c).
....................................................................*)
   
let circ_c = failwith "circ_a not implemented" ;;

(*....................................................................
Exercise 5d: Define a value `circ_d` of type `circuit` that represents
the circuit in Figure 1(d).
....................................................................*)
   
let circ_d = failwith "circ_a not implemented" ;;

(* Here we've taken advantage of the previous definition of `circ_c`
   for the innermost parallel circuit. *)

(*....................................................................
Exercise 5e: Define a function `resistance : circuit -> float` that
returns the total resistance of its `circuit` argument.
....................................................................*)

let resistance _ = failwith "resistance not implemented" ;;
   
(*====================================================================
Part 6. A functor for finite sequences

We'll define a finite sequence as a series of elements, finite in
number, all of a single type starting with some initial element and
with each succeeding element being generated from the previous one by
a _next_ function. For instance, here is a length-5 sequence of
natural numbers (implemented in OCaml as an `int list`):

    [0; 1; 2; 3; 4]

The initial element is `0` and the generating _next_ function is the
successor function.

A signature for modules that provide a finite sequence is as
follows: *)

module type SEQUENCE =
  sig
    type t
    val sequence : int -> t list
  end ;;

(* The signature requires that the module have a type `t` of the
elements of the sequence and a function `sequence` that, given an
integer length generates a sequence of that length as a list of
elements of type `t`.

Here is a (partial) implementation of a module `Natnums` for sequences
of natural numbers. (In addition to defining `t` and `sequence` as
called for in the `SEQUENCE` module signature, it also defines a
function `sequence_from` that is useful as an auxiliary function in
defining `sequence`.)

    module Natnums : ____________________ =
      struct
        type t = ____________________
        let rec sequence_from from length =
          if length = 0 then []
          else from :: sequence_from (succ from) (length - 1)
        let sequence length = ____________________
      end ;;

With this module, we should be able to generate behavior like:

    # Natnums.sequence 5 ;;
    - : int list = [0; 1; 2; 3; 4]
    # Natnums.sequence 10 ;;
    - : int list = [0; 1; 2; 3; 4; 5; 6; 7; 8; 9]
 *)
   
(*....................................................................
Exercise 6a: We've left out a few things in the implementation of the
`Natnums` module, marked with the underline blanks. Replace the
underlines with what should go in the blanks.
...................................................................*)

module Natnums : ____________________ =
  struct
    type t = ____________________
    let rec sequence_from from length =
      if length = 0 then []
      else from :: sequence_from (succ from) (length - 1)
    let sequence length = ____________________
  end ;;
  
(*....................................................................
Exercise 6b: Similarly, we provide a (partial) implementation of a module
`Diminishing` for a sequence where each `float` element is half of the
preceding one. It should have behavior like

    # Diminishing.sequence 3 ;;
    - : Diminishing.t list = [1.; 0.5; 0.25]
    # Diminishing.sequence 5 ;;
    - : Diminishing.t list = [1.; 0.5; 0.25; 0.125; 0.0625]

Again, we've left out a few things in the implementation of the
`Diminishing` module for you to fill in.
...................................................................*)

module Diminishing : ____________________ =
  struct
    type t = ____________________
    let rec sequence_from from length =
      if length = 0 then []
      else from :: sequence_from ____________________ (length - 1)
    let sequence length = ____________________
  end ;;

(*....................................................................
Exercise 6c: There's a lot of commonality between `Natnums` and
`Diminishing`. They differ only in the _type_ of their respective
elements, the _initial_ element, and the function for generating
_next_ elements. Consequently, we can package up those differences
into a module obeying a signature called, let's say,
`ELEMENT`. Provide a definition of this `ELEMENT` module type.
...................................................................*)

module type ELEMENT = sig end ;;

(*....................................................................
Exercise 6d: Now, we'll define a functor `Sequence` to generate
`SEQUENCE` modules based on `ELEMENT` modules. We provided the
skeleton of that functor definition. You'll need to fill in the
blanks.
...................................................................*)

module Sequence (Element : ____________________)
              : ____________________ =
  struct
    type t = ____________________
    let rec sequence_from from length =
      if length = 0 then []
      else ____________________
    let sequence length = ____________________
  end ;;

(*....................................................................
Exercise 6e: Define a module `Natnums_2` by making use of the `Sequence`
functor. It should have the same behavior as the definition for
`Natnums` as shown above. Here's a start; you just
need to fill in the blank.
....................................................................*)

module Natnums_2 =
  Sequence (struct
             ____________________
           end) ;;

(*....................................................................
Exercise 6f: Define a module `Diminishing_2` by making use of the
`Sequence` functor. It should have the same behavior as the definition
for `Diminishing` given above.
....................................................................*)

module Diminishing_2 = struct end ;;

(*
                              END OF LAB
 *) 

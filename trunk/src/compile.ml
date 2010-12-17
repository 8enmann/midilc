open Ast
open Bytecode

module StringMap = Map.Make(String)

(* Symbol table: Information about all the names in scope *)
type env = {
    function_index : int StringMap.t; (* Index for each function *)
    global_index   : int StringMap.t; (* "Address" for global variables *)
    local_index    : int StringMap.t; (* FP offset for args, locals *)
  }

(* val enum : int -> 'a list -> (int * 'a) list *)
let rec enum stride n = function
    [] -> []
  | hd::tl -> (n, hd) :: enum stride (n+stride) tl

(* val string_map_pairs StringMap 'a -> (int * 'a) list -> StringMap 'a *)
let string_map_pairs map pairs =
  List.fold_left (fun m (i, n) -> StringMap.add n i m) map pairs

(** Note map, used to map from note literals to pitch integers *)
let note_map = StringMap.add "C" 0 StringMap.empty
(* Rest is given value of -500; pitches less than 0 are not printed in the end. *)
let note_map = StringMap.add "R" (-500) note_map
let note_map = StringMap.add "D" 2 note_map
let note_map = StringMap.add "E" 4 note_map
let note_map = StringMap.add "F" 5 note_map
let note_map = StringMap.add "G" 7 note_map
let note_map = StringMap.add "A" 9 note_map
let note_map = StringMap.add "B" 11 note_map
let note_map = StringMap.add "w" 16 note_map
let note_map = StringMap.add "h" 8 note_map
let note_map = StringMap.add "q" 4 note_map
let note_map = StringMap.add "e" 2 note_map
let note_map = StringMap.add "s" 1 note_map

(** Returns the pitch, duration of a note *)
let int_of_note n =
  let a = Array.make 4 0 in
  a.(0) <- StringMap.find (String.sub n 0 1) note_map;
  for i = 1 to (String.length n) - 1 do
    (* check for an accidental *)
    if n.[i] == 'b' then a.(0) <- a.(0) - 1;
    if n.[i] == '#' then a.(0) <- a.(0) + 1;
    (* check for an octave *)
    if String.contains "0123456789" n.[i] then
      (a.(0) <- a.(0) + 12 * ((int_of_char n.[i])  - (int_of_char '0') + 1);
      a.(2) <- 1); (* mark octave as set *)
    (* check for a duration *)
    if String.contains "whqes" n.[i] then
      (a.(1) <- StringMap.find (String.sub n i 1) note_map;
      a.(3) <- 1) (* mark duration as set *)
  done;
  (* Set default octave *)
  if a.(2) == 0 then a.(0) <- a.(0) + 12 * 5;
  (* Set default duration *)
  if a.(3) == 0 then a.(1) <- 4;
  (*return*)
  (a.(0), a.(1))
  

(** Translate a program in AST form into a bytecode program.  Throw an
    exception if something is wrong, e.g., a reference to an unknown
    variable or function *)
let translate (globals, functions) =

  (* Allocate "addresses" for each global variable *)
  let global_indexes = string_map_pairs StringMap.empty (enum 1 0 globals) in

  (* Assign indexes to function names; built-in "play" and "set_tempo" are special *)
    (** Built in functions play (to play a sequence), set tempo, constructors for Sequence and Chord
        rand, and set_instrument *)
  let built_in_functions = StringMap.add "play" (-1) StringMap.empty in
  let built_in_functions = StringMap.add "set_tempo" (-2) built_in_functions     in
  let built_in_functions = StringMap.add "new_sequence" (-3) built_in_functions in
  let built_in_functions = StringMap.add "new_chord" (-4) built_in_functions in
  let built_in_functions = StringMap.add "rand" (-5) built_in_functions in
  let built_in_functions = StringMap.add "set_instrument" (-6) built_in_functions in
  let function_indexes = string_map_pairs built_in_functions
      (enum 1 1 (List.map (fun f -> f.fname) functions)) in

  (* Translate a function in AST form into a list of bytecode statements *)
  let translate env fdecl =
    (* Bookkeeping: FP offsets for locals and arguments *)
    let num_formals = List.length fdecl.formals
    and num_locals = List.length fdecl.locals
    and local_offsets = enum 1 1 fdecl.locals
    and formal_offsets = enum (-1) (-2) fdecl.formals in
    let env = { env with local_index = string_map_pairs
		  StringMap.empty (local_offsets @ formal_offsets) } in

    let rec expr = function
	Literal i -> [Num i]
	    | NoteLiteral n -> [Not (int_of_note n)]
		| StringLiteral s -> [Stn s]
      | Id s ->
	  (try [Lfp (StringMap.find s env.local_index)]
          with Not_found -> try [Lod (StringMap.find s env.global_index)]
          with Not_found -> raise (Failure ("undeclared variable " ^ s)))
      | Cast (t, s) -> expr (Id(s)) @ [Cst t]
      (* probably need to do type checking here *)
      | Binop (e1, op, e2) -> expr e1 @ expr e2 @ [Bin op]
      (* check that expr is of type Number *)
      | ElementOp (s, e) -> expr e @ expr (Id(s)) @ [Ele]
      | LElementOp (s, e1, e2) -> expr e2 @ expr e1 @ expr (Id(s)) @ [Leo] @
	  (try [Sfp (StringMap.find s env.local_index)]
  	  with Not_found -> try [Str (StringMap.find s env.global_index)]
	  with Not_found -> raise (Failure ("undeclared variable " ^ s)))
      | MemberOp (s, field) -> expr (Id(s)) @ [Mem field]
      | LMemberOp (s, field, e) -> expr e @ expr (Id(s)) @ [Lmo field] @
	  (try [Sfp (StringMap.find s env.local_index)]
  	  with Not_found -> try [Str (StringMap.find s env.global_index)]
	  with Not_found -> raise (Failure ("undeclared variable " ^ s)))
      | Assign (s, e) -> expr e @
	  (try [Sfp (StringMap.find s env.local_index)]
  	  with Not_found -> try [Str (StringMap.find s env.global_index)]
	  with Not_found -> raise (Failure ("undeclared variable " ^ s)))
      | Call (fname, actuals) -> (try
	  (List.concat (List.map expr (List.rev (if fname="new_chord" then [Literal (List.length actuals)] @ actuals else actuals)))) @
	  [Jsr (StringMap.find fname env.function_index) ]
        with Not_found -> raise (Failure ("undefined function " ^ fname)))
      | Noexpr -> []

    in let rec stmt = function
	Block sl     ->  List.concat (List.map stmt sl)
      | Expr e       -> expr e @ [Drp]
      | Return e     -> expr e @ [Rts num_formals]
      (** Break and Continue use Sjp command. 1 for break, 2 for continue*)
      | Break -> [Sjp(0,0,1)]
      | Continue -> [Sjp(0,0,2)];
      | If (p, t, f) -> let t' = stmt t and f' = stmt f in
	expr p @ [Beq(2 + List.length t')] @
	t' @ [Bra(1 + List.length f')] @ f'
      | For (e1, e2, e3, b) ->
	  stmt (Block([Expr(e1); While(e2, Block([b; Expr(e3)]), List.length (stmt b))]))
      | While (e, b,l) -> 
	  let b' = stmt b and e' = expr e in
	  [Sjp((if l<0 then List.length b' else l), List.length b' + List.length e', 0)] @ [Bra (1+ List.length b')] @ b' @ e' @
	  [Bne (-(List.length b' + List.length e'))] @ [Sjp(0,0,3)]

    in [Ent num_locals] @      (* Entry: allocate space for locals *)
    stmt (Block fdecl.body) @  (* Body *)
    [Num 0; Rts num_formals]   (* Default = return 0 *)

  in let env = { function_index = function_indexes;
		 global_index = global_indexes;
		 local_index = StringMap.empty } in

  (* Code executed to start the program: Jsr main; halt *)
  let entry_function = try
    [Jsr (StringMap.find "main" function_indexes); Hlt]
  with Not_found -> raise (Failure ("no \"main\" function"))
  in
    
  (* Compile the functions *)
  let func_bodies = entry_function :: List.map (translate env) functions in

  (* Calculate function entry points by adding their lengths *)
  let (fun_offset_list, _) = List.fold_left
      (fun (l,i) f -> (i :: l, (i + List.length f))) ([],0) func_bodies in
  let func_offset = Array.of_list (List.rev fun_offset_list) in

  { num_globals = List.length globals;
    (* Concatenate the compiled functions and replace the function
       indexes in Jsr statements with PC values *)
    text = Array.of_list (List.map (function
	Jsr i when i > 0 -> Jsr func_offset.(i)
      | _ as s -> s) (List.concat func_bodies))
  }

type bstmt =
    Num of int              (* Push a literal *)
  | Cho of int list         (* Push a Chord [len; dur; start; p; p; p...] *)
  | Seq of int list list    (* Push a sequence [[cur;len];[cho];[cho]...] *)
  | Not of (int * int)      (* Push a Note (pitch, duration) *)
  | Stn of string           (* Push a string literal *)
  | Ele                     (* access an element of a sequence *)
  | Leo                     (* Assign to an element of a sequence *)
  | Sjp of (int * int * int)(* Set/get jump points *)
  | Cst of string           (* Cast to a different type *)
  | Mem of string           (* access a member of a data type using the field name *)
  | Lmo of string           (* Assign to a member of a data type *)
  | Drp                     (* Discard a value *)
  | Bin of Ast.op           (* Perform arithmetic on top of stack *)
  | Lod of int    (* Fetch global variable *)
  | Str of int    (* Store global variable *)
  | Lfp of int    (* Load frame pointer relative *)
  | Sfp of int    (* Store frame pointer relative *)
  | Jsr of int    (* Call function by absolute address *)
  | Ent of int    (* Push FP, FP -> SP, SP += i *)
  | Rts of int    (* Restore FP, SP, consume formals, push result *)
  | Beq of int    (* Branch relative if top-of-stack is zero *)
  | Bne of int    (* Branch relative if top-of-stack is non-zero *)
  | Bra of int    (* Branch relative *)
  | Hlt           (* Terminate *)

type prog = {
    num_globals : int;   (* Number of global variables *)
    text : bstmt array; (* Code for all the functions *)
  }
  
let string_of_list l = 
  let rec help_string_of_list l s = match l
  with [] -> s ^ "]"
  | head :: tail -> help_string_of_list tail (s ^ (string_of_int head) ^ ";") in
  help_string_of_list l "["
    
let string_of_list_list l =
  let rec help_string_of_list_list l s = match l
  with [] -> s ^ "]"
  | head :: tail -> help_string_of_list_list tail (s ^ (string_of_list head) ^ ";") in help_string_of_list_list l "["
    
let print_sequence m = 
  let rec help_print_sequence l s = match l 
  with [] -> s 
  | head :: tail -> help_print_sequence tail 
	s^(let b = 
	  (List.fold_left (fun t e->t^"\n"^e) "" 
	     (let i = List.tl head in 
	     let duration = List.hd i in 
	     let k = List.tl i in 
	     let start = List.hd k in 
	     (List.map 
		(fun pitch -> if pitch > 0 then
		  (string_of_int start) ^ "," ^ 
		  (string_of_int duration) ^ "," ^ 
		  (string_of_int pitch) else ""))
	       (List.tl k))) in 
	(String.sub b 1 (String.length b - 1)))
      ^"\n" in 
  help_print_sequence (List.rev (List.tl m)) ""
    
let string_of_stmt = function
    Num(i) -> "Num " ^ string_of_int i
  | Not(i,j) -> "Not " ^ "(" ^ string_of_int i ^ "," ^ string_of_int j ^ ")"
  | Cho(l) -> "Cho " ^ (string_of_list l)
  | Seq(s) -> "Seq " ^ (print_sequence s)
  | Stn(s) -> "Stn " ^ s
  | Cst(t) -> "Cst " ^ t
  | Drp -> "Drp"
  | Bin(Ast.Add) -> "Add"
  | Bin(Ast.Sub) -> "Sub"
  | Bin(Ast.Mult) -> "Mul"
  | Bin(Ast.Div) -> "Div"
  | Bin(Ast.Mod) -> "Mod"
  | Bin(Ast.DotAdd) -> "Dad"
  | Bin(Ast.DotSub) -> "Dsu"
  | Bin(Ast.Or) -> "Or"
  | Bin(Ast.And) -> "And"
  | Bin(Ast.Equal) -> "Eql"
  | Bin(Ast.Neq) -> "Neq"
  | Bin(Ast.Less) -> "Lt"
  | Bin(Ast.Leq) -> "Leq"
  | Bin(Ast.Greater) -> "Gt"
  | Bin(Ast.Geq) -> "Geq"
  | Ele -> "Ele"
  | Leo -> "Leo"
  | Sjp(i,j,k) -> "Sjp (" ^ string_of_int i ^ "," ^ string_of_int j ^ "," ^ string_of_int k ^ ")"
  | Mem(s) -> "Mem " ^ s
  | Lmo(s) -> "Lmo " ^ s
  | Lod(i) -> "Lod " ^ string_of_int i
  | Str(i) -> "Str " ^ string_of_int i
  | Lfp(i) -> "Lfp " ^ string_of_int i
  | Sfp(i) -> "Sfp " ^ string_of_int i
  | Jsr(i) -> "Jsr " ^ string_of_int i
  | Ent(i) -> "Ent " ^ string_of_int i
  | Rts(i) -> "Rts " ^ string_of_int i
  | Bne(i) -> "Bne " ^ string_of_int i
  | Beq(i) -> "Beq " ^ string_of_int i
  | Bra(i) -> "Bra " ^ string_of_int i
  | Hlt    -> "Hlt"

let string_of_prog p =
  string_of_int p.num_globals ^ " global variables\n" ^
  let funca = Array.mapi
      (fun i s -> string_of_int i ^ " " ^ string_of_stmt s) p.text
  in String.concat "\n" (Array.to_list funca)

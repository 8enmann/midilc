type bstmt =
    Num of int              (* Push a literal *)
  | Cho of int list         (* Push a Chord *)
  | Seq of int list list    (* Push a sequence *)
  | Not of (int * int)      (* Push a Note *)
  | Ele                     (* access an element of a sequence *)
  | Mem of string   (* access a member of a data type using the field name *)
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
  
let rec print_list l s = match l
  with [] -> s ^ "]"
  | head :: tail -> print_list tail (s ^ (string_of_int head) ^ ";")
  
let rec print_list_list l s = match l
  with [] -> s ^ "]"
  | head :: tail -> print_list_list tail (s ^ (print_list head "[") ^ ";")

let string_of_stmt = function
    Num(i) -> "Num " ^ string_of_int i
  | Not(i,j) -> "Not " ^ "(" ^ string_of_int i ^ "," ^ string_of_int j ^ ")"
  | Cho(l) -> "Cho " ^ (print_list l "[")
  | Seq(s) -> "Seq " ^ (print_list_list s "[")
  | Drp -> "Drp"
  | Bin(Ast.Add) -> "Add"
  | Bin(Ast.Sub) -> "Sub"
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
  | Mem(s) -> "Mem " ^ s
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

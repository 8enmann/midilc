type bstmt =
    Num of int list list    (* Push a literal *)
  | Cho of int list list    (* Push a Chord *)
  | Seq of int list list
  | Not of int list list
  | Drp of int list list    (* Discard a value *)
  | Bin of Ast.op           (* Perform arithmetic on top of stack *)
  | Lod of int list list    (* Fetch global variable *)
  | Str of int list list    (* Store global variable *)
  | Lfp of int list list    (* Load frame pointer relative *)
  | Sfp of int list list    (* Store frame pointer relative *)
  | Jsr of int list list    (* Call function by absolute address *)
  | Ent of int list list    (* Push FP, FP -> SP, SP += i *)
  | Rts of int list list    (* Restore FP, SP, consume formals, push result *)
  | Beq of int list list    (* Branch relative if top-of-stack is zero *)
  | Bne of int list list    (* Branch relative if top-of-stack is non-zero *)
  | Bra of int list list    (* Branch relative *)
  | Hlt           (* Terminate *)

type prog = {
    num_globals : int;   (* Number of global variables *)
    text : bstmt array; (* Code for all the functions *)
  }

let string_of_stmt = function
    Lit(i) -> "Lit " ^ string_of_int i
  | Drp -> "Drp"
  | Bin(Ast.Add) -> "Add"
  | Bin(Ast.Sub) -> "Sub"
  | Bin(Ast.DotPlus) -> "Dpl"
  | Bin(Ast.DotMinus) -> "Dmi"
  | Bin(Ast.Or) -> "Or"
  | Bin(Ast.And) -> "And"
  | Bin(Ast.Equal) -> "Eql"
  | Bin(Ast.Neq) -> "Neq"
  | Bin(Ast.Less) -> "Lt"
  | Bin(Ast.Leq) -> "Leq"
  | Bin(Ast.Greater) -> "Gt"
  | Bin(Ast.Geq) -> "Geq"
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

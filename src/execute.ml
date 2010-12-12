open Ast
open Bytecode

(* Stack layout just after "Ent":

              <-- SP
   Local n
   ...
   Local 0
   Saved FP   <-- FP
   Saved PC
   Arg 0
   ...
   Arg n *)

let execute_prog prog =
  let stack = Array.make 1024 (Num(0))
  and globals = Array.make prog.num_globals (Num(0)) in

  let rec exec fp sp pc = match prog.text.(pc) with
    Num i  -> stack.(sp) <- (Num(i)) ; exec fp (sp+1) (pc+1)
  | Mem s  -> raise (Failure ("not implemented yet"))
  | Cst s  -> raise (Failure ("not implemented yet"))
  | Not (p, d) -> stack.(sp) <- (Not(p,d)) ; exec fp (sp+1) (pc+1)
  | Cho (l) -> raise (Failure ("not implemented yet"))
  | Seq (ll) -> raise (Failure ("not implemented yet"))
  | Ele    -> raise (Failure ("not implemented yet"))
  | Drp    -> exec fp (sp-1) (pc+1)
  | Bin op -> let opA = stack.(sp-2) and opB = stack.(sp-1) in     
      stack.(sp-2) <- (let boolean i = if i then Num(1) else Num(0) in
      match op with
        Add		  -> (match (opA, opB) with (Num op1, Num op2) -> Num(op1 + op2)
            | _ -> raise (Failure ("unexpected types for +")))
      | Sub     -> (match (opA, opB) with (Num op1, Num op2) -> Num(op1 - op2)
            | _ -> raise (Failure ("unexpected types for -")))
      | DotAdd  -> (match (opA, opB) with (Not (p, d), Num op2) -> Not(p + op2, d) (* add pitch of Note to Number *)
            | _ -> raise (Failure ("unexpected types for .+")))
      | DotSub  -> (match (opA, opB) with (Not (p, d), Num op2) -> Not(p - op2, d) 
            | _ -> raise (Failure ("unexpected types for .-")))
      | And     -> (match (opA, opB) with (Num op1, Num op2) -> boolean (op1 != 0 && op2 != 0)
            | _ -> raise (Failure ("unexpected types for &&")))
      | Or      -> (match (opA, opB) with (Num op1, Num op2) -> boolean (op1 == 1 || op2 == 1)
            | _ -> raise (Failure ("unexpected types for ||")))
      | Equal   -> (match (opA, opB) with (Num op1, Num op2) -> boolean (op1 =  op2)
            | _ -> raise (Failure ("unexpected types for =")))
      | Neq     -> (match (opA, opB) with (Num op1, Num op2) -> boolean (op1 != op2)
            | _ -> raise (Failure ("unexpected types for !=")))
      | Less    -> (match (opA, opB) with (Num op1, Num op2) -> boolean (op1 <  op2)
            | _ -> raise (Failure ("unexpected types for <")))
      | Leq     -> (match (opA, opB) with (Num op1, Num op2) -> boolean (op1 <= op2)
            | _ -> raise (Failure ("unexpected types for <=")))
      | Greater -> (match (opA, opB) with (Num op1, Num op2) -> boolean (op1 >  op2)
            | _ -> raise (Failure ("unexpected types for >")))
      | Geq     -> (match (opA, opB) with (Num op1, Num op2) -> boolean (op1 >= op2)
            | _ -> raise (Failure ("unexpected types for >="))));
      exec fp (sp-1) (pc+1)
  | Lod i   -> stack.(sp)   <- globals.(i)  ; exec fp (sp+1) (pc+1)
  | Str i   -> globals.(i)  <- stack.(sp-1) ; exec fp sp     (pc+1)
  | Lfp i   -> stack.(sp)   <- stack.(fp+i) ; exec fp (sp+1) (pc+1)
  | Sfp i   -> stack.(fp+i) <- stack.(sp-1) ; exec fp sp     (pc+1)
  (** this is the print command. change it to set tempo and play *)
  | Jsr(-2) -> (match stack.(sp-1) with Num i ->  print_endline (string_of_int i); exec fp sp (pc+1)
            | _ -> raise (Failure ("unexpected type for set_tempo")))
  | Jsr(-1) -> (match stack.(sp-1) with Seq s ->  print_endline (string_of_list_list s "["); exec fp sp (pc+1)
            | _ -> raise (Failure ("unexpected type for set_tempo")))
  | Jsr i   -> stack.(sp)   <- (Num(pc + 1))       ; exec fp (sp+1) i
  | Ent i   -> stack.(sp)   <- (Num(fp))           ; exec sp (sp+i+1) (pc+1)
  | Rts i   -> let new_fp = stack.(fp) and new_pc = stack.(fp-1) in
               stack.(fp-i-1) <- stack.(sp-1) ; exec 
                 (match new_fp with Num nfp -> nfp  
                   | _ -> raise (Failure ("unexpected types for return"))) 
                 (fp-i) 
                 (match new_pc with Num npc -> npc  
                   | _ -> raise (Failure ("unexpected types for return")))
  | Beq i   -> exec fp (sp-1) (pc + if 
    (match stack.(sp-1) with Num temp -> temp =  0 
      | _ -> raise (Failure ("unexpected types for return"))) then i else 1)
  | Bne i   -> exec fp (sp-1) (pc + if 
    (match stack.(sp-1) with Num temp -> temp !=  0 
      | _ -> raise (Failure ("unexpected types for return"))) then i else 1)
  | Bra i   -> exec fp sp (pc+i)
  | Hlt     -> ()

  in exec 0 0 0

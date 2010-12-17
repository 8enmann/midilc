{ open Parser }

rule token = parse
  [' ' '\t' '\r' '\n'] { token lexbuf } (* Whitespace *)
| "/*"     { comment lexbuf }           (* Comments *)
| '('      { LPAREN }
| ')'      { RPAREN }
| '{'      { LBRACE }
| '}'      { RBRACE }
| '['      { LBRACKET }
| ']'	   { RBRACKET }
| ';'      { SEMI }
| ','      { COMMA }
| '+'      { PLUS }
| '-'      { MINUS }
| '*'      { TIMES }
| '/'      { DIVIDE }
| '='      { ASSIGN }
| "=="     { EQ }
| "!="     { NEQ }
| '<'      { LT }
| "<="     { LEQ }
| ">"      { GT }
| ">="     { GEQ }
| "as"     { AS } 
| "if"     { IF }
| "else"   { ELSE }
| "for"    { FOR }
| "while"  { WHILE }
| "continue" { CONTINUE }
| "return" { RETURN }
| "break"  { BREAK }
| "&&"	   { AND }
| "||"	   { OR }
| '.'	   { DOT }
| ".+" 	   { DOTPLUS }
| ".-"     { DOTMINUS }
| "%"      { MOD }
| "duration" | "pitch" | "length" | "current" | "start" as s { SELECT(s) }
| "Number" | "Note" | "Chord" | "Sequence" | "Void" as typ  { TYPE(typ) }
| ['A'-'G' 'R']['b' '#']?['0'-'9']?['w' 'h' 'q' 'e' 's']? as note { NOTE(note) }
| ['0'-'9']+ as lxm { LITERAL(int_of_string lxm) }
| '\"'['0'-'9' 'A'-'Z' ' ' 'a'-'z']+'\"' as stng { STRLIT(String.sub stng 1 ((String.length stng) - 2)) }
| ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_']* as lxm { ID(lxm) }
| eof { EOF }
| _ as char { raise (Failure("illegal character " ^ Char.escaped char)) }

and comment = parse
  "*/" { token lexbuf }
| _    { comment lexbuf }

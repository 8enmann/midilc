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
| '='      { ASSIGN }
| "=="     { EQ }
| "!="     { NEQ }
| '<'      { LT }
| "<="     { LEQ }
| ">"      { GT }
| ">="     { GEQ }
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
| "Number" { NUMBER }
| "Note"   { NOTE }
| "Chord"  { CHORD }
| "Sequence" { SEQUENCE }
| "Void"     { VOID }
| ['A'-'G' 'R']['b' '#']?['0'-'9']?['w' 'h' 'q' 'e' 's']? as note { NOTE_LITERAL(note) }
| ['0'-'9']+ as lxm { LITERAL(int_of_string lxm) }
| ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_']* as lxm { ID(lxm) }
| eof { EOF }
| _ as char { raise (Failure("illegal character " ^ Char.escaped char)) }

and comment = parse
  "*/" { token lexbuf }
| _    { comment lexbuf }

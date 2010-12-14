%{ open Ast %}

%token SEMI LPAREN RPAREN LBRACE RBRACE COMMA LBRACKET RBRACKET CAST
%token PLUS MINUS ASSIGN DOTPLUS DOTMINUS MOD
%token EQ NEQ LT LEQ GT GEQ
%token AND OR DOT AS
%token RETURN IF ELSE FOR WHILE BREAK CONTINUE
%token <int> LITERAL
%token <string> ID
%token <string> SELECT
%token <string> NOTE
%token <string> TYPE
%token EOF

%nonassoc NOELSE
%nonassoc ELSE
%right ASSIGN
%left AS
%left OR
%left AND
%left EQ NEQ
%left LT GT LEQ GEQ
%left PLUS MINUS DOTPLUS DOTMINUS

%start program
%type <Ast.program> program

%%

program:
   /* nothing */ { [], [] }
 | program vdecl { ($2 :: fst $1), snd $1 }
 | program fdecl { fst $1, ($2 :: snd $1) }

fdecl:
    ID LPAREN formals_opt RPAREN LBRACE vdecl_list stmt_list RBRACE
     { {
	 fname = $1;
	 formals = $3;
	 locals = List.rev $6;
	 body = List.rev $7 } }

formals_opt:
    /* nothing */ { [] }
  | formal_list   { List.rev $1 }

formal_list:
  ID                  { [$1]  }  /* List pair */
  | formal_list COMMA ID { $3 :: $1 } /* List pair */

vdecl_list:
    /* nothing */    { [] }
  | vdecl_list vdecl { $2 :: $1 }
 

vdecl:
   /* INT ID SEMI { $2 } */
   TYPE ID SEMI { $2 }
    
stmt_list:
    /* nothing */  { [] }
  | stmt_list stmt { $2 :: $1 }

stmt:
    expr SEMI { Expr($1) }
  | RETURN expr SEMI { Return($2) }
  | BREAK SEMI { Break }
  | CONTINUE SEMI { Continue }
  | LBRACE stmt_list RBRACE { Block(List.rev $2) }
  | IF LPAREN expr RPAREN stmt %prec NOELSE { If($3, $5, Block([])) }
  | IF LPAREN expr RPAREN stmt ELSE stmt    { If($3, $5, $7) }
  | FOR LPAREN expr_opt SEMI expr_opt SEMI expr_opt RPAREN stmt
     { For($3, $5, $7, $9) }
  | WHILE LPAREN expr RPAREN stmt { While($3, $5) }

expr_opt:
    /* nothing */ { Noexpr }
  | expr          { $1 }

expr:
    NOTE      { NoteLiteral($1) }
  | LITERAL          { Literal($1) }
  | ID               { Id($1) }
  | ID LBRACKET expr RBRACKET { ElementOp($1, $3) }
  | ID DOT SELECT { MemberOp($1, $3) }
  | ID AS TYPE { Cast($3, $1) }
  | expr DOTPLUS expr { Binop($1, DotAdd, $3) }
  | expr DOTMINUS expr { Binop($1, DotSub, $3) }
  | expr PLUS   expr { Binop($1, Add,   $3) }
  | expr MINUS  expr { Binop($1, Sub,   $3) }
  | expr EQ     expr { Binop($1, Equal, $3) }
  | expr NEQ    expr { Binop($1, Neq,   $3) }
  | expr LT     expr { Binop($1, Less,  $3) }
  | expr LEQ    expr { Binop($1, Leq,   $3) }
  | expr GT     expr { Binop($1, Greater,  $3) }
  | expr GEQ    expr { Binop($1, Geq,   $3) }
  | expr AND    expr { Binop($1, And,   $3) }
  | expr OR     expr { Binop($1, Or,    $3) }
  | expr MOD     expr { Binop($1, Mod,    $3) }
  | ID DOT SELECT ASSIGN expr { LMemberOp($1, $3, $5) }
  | ID LBRACKET expr RBRACKET ASSIGN expr { LElementOp($1, $3, $6) }
  | ID ASSIGN expr   { Assign($1, $3) }
  | ID LPAREN actuals_opt RPAREN { Call($1, $3) }
  | LPAREN expr RPAREN { $2 }

actuals_opt:
    /* nothing */ { [] }
  | actuals_list  { List.rev $1 }

actuals_list:
    expr                    { [$1] }
  | actuals_list COMMA expr { $3 :: $1 }

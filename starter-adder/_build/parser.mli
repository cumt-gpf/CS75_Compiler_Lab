type token =
  | NUM of (int)
  | ID of (string)
  | ADD1
  | SUB1
  | LPAREN
  | RPAREN
  | LET
  | IN
  | EQUAL
  | COMMA
  | EOF

val program :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Compile.expr

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

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
open Compile

# 20 "parser.ml"
let yytransl_const = [|
  259 (* ADD1 *);
  260 (* SUB1 *);
  261 (* LPAREN *);
  262 (* RPAREN *);
  263 (* LET *);
  264 (* IN *);
  265 (* EQUAL *);
  266 (* COMMA *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  257 (* NUM *);
  258 (* ID *);
    0|]

let yylhs = "\255\255\
\002\000\003\000\003\000\004\000\004\000\005\000\005\000\005\000\
\005\000\001\000\000\000"

let yylen = "\002\000\
\001\000\001\000\001\000\003\000\005\000\004\000\004\000\001\000\
\001\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\001\000\009\000\002\000\003\000\000\000\011\000\
\008\000\000\000\000\000\000\000\000\000\000\000\010\000\000\000\
\000\000\000\000\000\000\006\000\007\000\000\000\005\000"

let yydgoto = "\002\000\
\008\000\009\000\010\000\013\000\011\000"

let yysindex = "\003\000\
\255\254\000\000\000\000\000\000\000\000\000\000\007\255\000\000\
\000\000\005\255\011\000\003\255\006\255\255\254\000\000\255\254\
\255\254\009\255\008\255\000\000\000\000\007\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\011\255\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\250\255\247\255"

let yytablesize = 19
let yytable = "\003\000\
\004\000\005\000\006\000\001\000\018\000\007\000\019\000\020\000\
\012\000\014\000\015\000\016\000\000\000\017\000\021\000\023\000\
\000\000\022\000\004\000"

let yycheck = "\001\001\
\002\001\003\001\004\001\001\000\014\000\007\001\016\000\017\000\
\002\001\005\001\000\000\009\001\255\255\008\001\006\001\022\000\
\255\255\010\001\008\001"

let yynames_const = "\
  ADD1\000\
  SUB1\000\
  LPAREN\000\
  RPAREN\000\
  LET\000\
  IN\000\
  EQUAL\000\
  COMMA\000\
  EOF\000\
  "

let yynames_block = "\
  NUM\000\
  ID\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 17 "parser.mly"
        ( Number(_1) )
# 102 "parser.ml"
               : 'const))
; (fun __caml_parser_env ->
    Obj.repr(
# 20 "parser.mly"
         ( Add1 )
# 108 "parser.ml"
               : 'prim1))
; (fun __caml_parser_env ->
    Obj.repr(
# 21 "parser.mly"
         ( Sub1 )
# 114 "parser.ml"
               : 'prim1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 24 "parser.mly"
                  ( [(_1, _3)] )
# 122 "parser.ml"
               : 'binds))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'binds) in
    Obj.repr(
# 25 "parser.mly"
                              ( (_1, _3)::_5 )
# 131 "parser.ml"
               : 'binds))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'binds) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 28 "parser.mly"
                      ( Let(_2, _4) )
# 139 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'prim1) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 29 "parser.mly"
                             ( Prim1(_1, _3) )
# 147 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'const) in
    Obj.repr(
# 30 "parser.mly"
          ( _1 )
# 154 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 31 "parser.mly"
       ( Id(_1) )
# 161 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 34 "parser.mly"
             ( _1 )
# 168 "parser.ml"
               : Compile.expr))
(* Entry program *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let program (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Compile.expr)
;;

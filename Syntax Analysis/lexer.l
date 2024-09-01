%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include "y.tab.h"
   

// #define  T_AND 300
// #define  T_OR 301
// #define  T_NOT 302
// #define  T_PROGRAM 303
// #define  T_ELSE 304
// #define  T_INT 305
// #define  T_REAL 306
// #define  T_BOOLEAN 307
// #define  T_CHAR 308
// #define T_VARIABLE 309
// #define T_FOR 310
// #define T_DO 311
// #define T_WHILE 312
// #define T_ARRAY 313
// #define T_BEGIN 314
// #define T_END 315
// #define T_READ 316
// #define T_WRITE 317
// #define ID 318
// #define INTEGERNUMBER 319
// #define OB 320
// #define CB 321
// #define OBR 322
// #define CBR 323
// #define SEMI 324
// #define COLON 325
// #define COMMA 326
// #define DOT 327
// #define PLUS 328
// #define MINUS 329
// #define MUL 330
// #define DIV 331
// #define MOD 332
// #define EQ 333
// #define NEQ 334
// #define LT 335
// #define GT 336
// #define LTE 337
// #define GTE 338
// #define STR 339
// #define ASSIGN 340
// #define REALNUMBER 341

extern YYSTYPE yylval;
int lnctr = 0;

%}

%option yylineno
%option caseless
%%



"and"                    { strcpy(yylval.syntax_object.name, yytext); return T_AND; }
"or"                     { strcpy(yylval.syntax_object.name, yytext); return T_OR; }
"not"                    { strcpy(yylval.syntax_object.name, yytext); return T_NOT; }
"program"                { strcpy(yylval.syntax_object.name, yytext); return T_PROGRAM; }
"else"                   { strcpy(yylval.syntax_object.name, yytext); return T_ELSE; }
"integer"                { strcpy(yylval.syntax_object.name, yytext); return T_INT; }
"real"                   { strcpy(yylval.syntax_object.name, yytext); return T_REAL; }
"boolean"                { strcpy(yylval.syntax_object.name, yytext); return T_BOOLEAN; }
"char"                   { strcpy(yylval.syntax_object.name, yytext); return T_CHAR; }
"var"                    { strcpy(yylval.syntax_object.name, yytext); return T_VARIABLE; }
"for"                    { strcpy(yylval.syntax_object.name, yytext); return T_FOR; }
"to"                     { strcpy(yylval.syntax_object.name, yytext); return T_TO; }
"downto"                 { strcpy(yylval.syntax_object.name, yytext); return T_DOWNTO; }
"do"                     { strcpy(yylval.syntax_object.name, yytext); return T_DO; }
"if"                     { strcpy(yylval.syntax_object.name, yytext); return T_IF; }
"then"                   { strcpy(yylval.syntax_object.name, yytext); return T_THEN; }
"while"                  { strcpy(yylval.syntax_object.name, yytext); return T_WHILE; }
"array"                  { strcpy(yylval.syntax_object.name, yytext); return T_ARRAY; }
"of"                     { strcpy(yylval.syntax_object.name, yytext); return OF; }
"begin"                  { strcpy(yylval.syntax_object.name, yytext); return T_BEGIN; }
"end"                    { strcpy(yylval.syntax_object.name, yytext); return T_END; }
"read"                   { strcpy(yylval.syntax_object.name, yytext); return T_READ; }
"write"                  { strcpy(yylval.syntax_object.name, yytext); return T_WRITE; }
[a-zA-Z][a-zA-Z0-9_]*    { strcpy(yylval.syntax_object.name, yytext); return ID; }
[0-9]+                   { strcpy(yylval.syntax_object.name, yytext); return INTEGERNUMBER; }
[0-9]+\.[0-9]+           { strcpy(yylval.syntax_object.name, yytext); return REALNUMBER; }
"("                      { strcpy(yylval.syntax_object.name, yytext); return OB; }
")"                      { strcpy(yylval.syntax_object.name, yytext); return CB; }
"["                      { strcpy(yylval.syntax_object.name, yytext); return OSBRACKET; }
"]"                      { strcpy(yylval.syntax_object.name, yytext); return CSBRACKET; }
";"                      { strcpy(yylval.syntax_object.name, yytext); return SEMI; }
":"                      { strcpy(yylval.syntax_object.name, yytext); return COLON; }
","                      { strcpy(yylval.syntax_object.name, yytext); return COMMA; }
"."                      { strcpy(yylval.syntax_object.name, yytext); return DOT; }
".."                     { strcpy(yylval.syntax_object.name, yytext); return DOTDOT; }
"+"                      { strcpy(yylval.syntax_object.name, yytext); return PLUS; }
"-"                      { strcpy(yylval.syntax_object.name, yytext); return MINUS; }
"*"                      { strcpy(yylval.syntax_object.name, yytext); return MUL; }
"/"                      { strcpy(yylval.syntax_object.name, yytext); return DIV; }
"%"                      { strcpy(yylval.syntax_object.name, yytext); return MOD; }
":="                      { strcpy(yylval.syntax_object.name, yytext); return ASSIGN; }
"="                      { strcpy(yylval.syntax_object.name, yytext); return EQ; }
"<>"                     { strcpy(yylval.syntax_object.name, yytext); return NEQ; }
"<"                      { strcpy(yylval.syntax_object.name, yytext); return LT; }
">"                      { strcpy(yylval.syntax_object.name, yytext); return GT; }
"<="                     { strcpy(yylval.syntax_object.name, yytext); return LTE; }
">="                     { strcpy(yylval.syntax_object.name, yytext); return GTE; }
["].*["]                 { strcpy(yylval.syntax_object.name, yytext); return STR; }
[\n]                     { lnctr++; }
[\t]*                    { ; }
[" "]+                   { ; }
. { fprintf(stderr, "'%c' (0%o): illegal character at line %d\n", yytext[0], yytext[0], lnctr); }

%%


int yywrap() {
    return 1;
}

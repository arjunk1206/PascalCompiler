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



"and"                    {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return T_AND; }
"or"                     {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return T_OR; }
"not"                    {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return T_NOT; }
"program"                {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return T_PROGRAM; }
"else"                   {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return T_ELSE; }
"integer"                {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return T_INT; }
"real"                   {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return T_REAL; }
"boolean"                {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return T_BOOLEAN; }
"char"                   {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return T_CHAR; }
"var"                    {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return T_VARIABLE; }
"for"                    {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return T_FOR; }
"to"                     {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return T_TO; }
"downto"                 {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return T_DOWNTO; }
"do"                     {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return T_DO; }
"if"                     {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return T_IF; }
"then"                   {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return T_THEN; }
"while"                  {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return T_WHILE; }
"array"                  {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return T_ARRAY; }
"of"                     {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return OF; }
"begin"                  {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return T_BEGIN; }
"end"                    {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return T_END; }
"read"                   {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return T_READ; }
"write"                  {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return T_WRITE; }
[a-zA-Z][a-zA-Z0-9_]*    {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return ID; }
[0-9]+                   {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return INTEGERNUMBER; }
[0-9]+\.[0-9]+           {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return REALNUMBER; }
"("                      {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return OB; }
")"                      {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return CB; }
"["                      {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return OSBRACKET; }
"]"                      {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return CSBRACKET; }
";"                      {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return SEMI; }
":"                      {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return COLON; }
","                      {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return COMMA; }
"."                      {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return DOT; }
".."                     {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return DOTDOT; }
"+"                      {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return PLUS; }
"-"                      {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return MINUS; }
"*"                      {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return MUL; }
"/"                      {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return DIV; }
"%"                      {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return MOD; }
":="                      {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return ASSIGN; }
"="                      {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return EQ; }
"<>"                     {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return NEQ; }
"<"                      {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return LT; }
">"                      {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return GT; }
"<="                     {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return LTE; }
">="                     {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return GTE; }
["].*["]                 {  yylval.lexeme.name = strdup(yytext); yylval.lexeme.label = -1; return STR; }
[\n]                     { lnctr++; }
[\t]*                    { ; }
[" "]+                   { ; }
\/\/.*                   { ; }
. { fprintf(stderr, "'%c' (0%o): illegal character at line %d\n", yytext[0], yytext[0], lnctr); }

%%


int yywrap() {
    return 1;
}


void yyerror(const char *s) {
    fprintf(stderr, "Error: %s at line count: %d\n", s, lnctr + 1);
    fprintf(stderr, "Token causing the error: %s\n", yytext);
    exit(1);
}
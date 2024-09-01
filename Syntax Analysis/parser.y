%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include"lex.yy.c"

extern int yylex();
void yyerror(const char *s);
int yywrap();



%}

%union { struct var_name { 
            char name[100]; 
            struct node* nd;
        } syntax_object;
}

%token <syntax_object> T_AND
%token <syntax_object> T_OR
%token <syntax_object> T_NOT
%token <syntax_object> T_PROGRAM
%token <syntax_object> T_ELSE
%token <syntax_object> T_INT
%token <syntax_object> T_REAL
%token <syntax_object> T_BOOLEAN
%token <syntax_object> T_CHAR
%token <syntax_object> T_VARIABLE
%token <syntax_object> T_FOR
%token <syntax_object> T_DO
%token <syntax_object> T_WHILE
%token <syntax_object> T_IF
%token <syntax_object> T_THEN
%token <syntax_object> T_ARRAY
%token <syntax_object> T_BEGIN
%token <syntax_object> T_END
%token <syntax_object> T_READ
%token <syntax_object> T_WRITE
%token <syntax_object> ID
%token <syntax_object> INTEGERNUMBER
%token <syntax_object> REALNUMBER
%token <syntax_object> OB
%token <syntax_object> CB
%token <syntax_object> OSBRACKET
%token <syntax_object> CSBRACKET
%token <syntax_object> SEMI
%token <syntax_object> COLON
%token <syntax_object> COMMA
%token <syntax_object> DOT
%token <syntax_object> PLUS
%token <syntax_object> MINUS
%token <syntax_object> MUL
%token <syntax_object> DIV
%token <syntax_object> MOD
%token <syntax_object> ASSIGN
%token <syntax_object> EQ
%token <syntax_object> NEQ
%token <syntax_object> LT
%token <syntax_object> GT
%token <syntax_object> LTE
%token <syntax_object> GTE
%token <syntax_object> STR
%token <syntax_object> OF
%token <syntax_object> T_TO
%token <syntax_object> T_DOWNTO
%token <syntax_object> DOTDOT



%type <syntax_object> program var_decl_list var_decl_list_line var_decl type_name type_list var_list compound_stmt stmt_list stmt assign_stmt write_stmt read_stmt if_stmt while_stmt for_stmt expr 


%%

program : T_PROGRAM ID SEMI T_VARIABLE var_decl_list compound_stmt DOT;

var_decl_list : var_decl_list_line
              | var_decl_list var_decl_list_line
              ;

var_decl_list_line : var_list COLON type_name SEMI;

var_decl : ID
         | ID COMMA var_decl
         ;

var_list : var_decl
         | var_list COMMA var_decl
         ;
type_name : T_INT
          | T_REAL
          | T_BOOLEAN
          | T_CHAR
          | T_ARRAY OSBRACKET INTEGERNUMBER DOTDOT INTEGERNUMBER CSBRACKET OF type_list
          ;

type_list : T_INT
          | T_REAL
          | T_BOOLEAN
          | T_CHAR
          ;

compound_stmt : T_BEGIN stmt_list T_END;

stmt_list : stmt SEMI
          | stmt_list stmt SEMI
          ;

stmt : assign_stmt
     | write_stmt
     | read_stmt
     | if_stmt
     | while_stmt
     | for_stmt
     ;

assign_stmt : ID ASSIGN expr 
            ;

write_stmt : T_WRITE OB expr_list CB;



expr_list : expr 
          | expr COMMA expr_list
          ;

read_stmt : T_READ OB ID CB
          | T_READ OB ID OSBRACKET INTEGERNUMBER CSBRACKET CB
          | T_READ OB ID OSBRACKET ID CSBRACKET CB
          ;

if_stmt : T_IF expr T_THEN compound_stmt
        | T_IF expr T_THEN compound_stmt T_ELSE compound_stmt
        ;

while_stmt : T_WHILE expr T_DO compound_stmt;

for_stmt : T_FOR ID ASSIGN expr T_TO expr T_DO compound_stmt
         | T_FOR ID ASSIGN expr T_DOWNTO expr T_DO compound_stmt
         ;

expr : ID 
     | INTEGERNUMBER 
     | REALNUMBER    
     | STR    
     | ID OSBRACKET INTEGERNUMBER CSBRACKET
     | ID OSBRACKET ID CSBRACKET
     | expr PLUS expr 
     | expr MINUS expr 
     | expr MUL expr 
     | expr DIV expr 
     | expr MOD expr 
     | expr EQ expr 
     | expr NEQ expr 
     | expr LT expr 
     | expr GT expr 
     | expr LTE expr 
     | expr GTE expr 
     | expr T_AND expr 
     | expr T_OR expr 
     | T_NOT expr 
     | OB expr CB 
     ;

%%

int main(int argc, char *argv[]) {

    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        printf("Error opening file.\n");
        return 1; 
    }

    yyin = file;

    yyparse();
    printf("Completed Lexical Analysis\n");
    printf("Completed Syntax Analysis\n");

    fclose(file);
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s at line count: %d\n", s,lnctr+1 );
    fprintf(stderr, "Token causing the error: %s\n", yytext);
    exit(1);
}

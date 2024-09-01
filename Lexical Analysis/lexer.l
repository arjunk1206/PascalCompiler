%{
#include<stdio.h>
#include<string.h>
#include <stdlib.h>
#include<ctype.h>


int lnctr = 1;
%}

%x COMMENT
%option caseless

%%
\/\/.* {
    printf("%d\t\t%s\t\tCOMMENT\n", lnctr, yytext);
    BEGIN(COMMENT);
    }
<COMMENT>. {}
<COMMENT>[\n] {lnctr++;
                BEGIN(INITIAL);}

"and" { printf("%d\t\t%s\t\tT_AND\n", lnctr, yytext);}
"or" {  printf("%d\t\t%s\t\tT_OR\n",  lnctr,yytext);}
"not" { printf("%d\t\t%s\t\tT_NOT\n",lnctr, yytext);}
"program" { printf("%d\t\t%s\t\tT_PROGRAM\n", lnctr,yytext);}
"else" { printf("%d\t\t%s\t\tT_ELSE\n",lnctr, yytext);}
"integer" { printf("%d\t\t%s\t\tT_INT\n",lnctr, yytext);}
"real" { printf("%d\t\t%s\t\tT_REAL\n", lnctr,yytext);}
"boolean" { printf("%d\t\t%s\t\tT_BOOLEAN\n",lnctr, yytext);}
"char" { printf("%d\t\t%s\t\tT_CHAR\n",lnctr, yytext);}
"var" { printf("%d\t\t%s\t\tT_VARIABLE\n",lnctr, yytext);}
"for" { printf("%d\t\t%s\t\tT_FOR\n",lnctr, yytext);}
"do" { printf("%d\t\t%s\t\tT_DO\n", lnctr,yytext);}
"while" { printf("%d\t\t%s\t\tT_WHILE\n", lnctr,yytext);}
"array" { printf("%d\t\t%s\t\tT_ARRAY\n", lnctr,yytext);}
"of" {printf("%d\t\t%s\t\tARRAY_TYPE\n",lnctr,yytext);}
"begin" { printf("%d\t\t%s\t\tT_BEGIN\n",lnctr, yytext);}
"end" { printf("%d\t\t%s\t\tT_END\n",lnctr, yytext);}
"read" { printf("%d\t\t%s\t\tT_READ\n",lnctr, yytext);}
"write" { printf("%d\t\t%s\t\tT_WRITE\n",lnctr, yytext);}
[a-zA-Z][a-zA-Z0-9_]* {printf("%d\t\t%s\t\tID\n",lnctr,yytext);}
[0-9]+ {printf("%d\t\t%s\t\tINTEGERNUMBER\n",lnctr,yytext);}
[0-9]+\.[0-9]+ {printf("%d\t\t%s\t\tREALNUMBER\n",lnctr,yytext);}
"(" {printf("%d\t\t%s\t\tOBRACKET\n",lnctr,yytext); }
")" {printf("%d\t\t%s\t\tCBRACKET\n",lnctr, yytext);}
"{" {printf("%d\t\t%s\t\tOBRACE\n", lnctr,yytext);}
"}" {printf("%d\t\t%s\t\tCBRACE\n",lnctr,yytext);}
"[" {printf("%d\t\t%s\t\tOSBRACKET\n",lnctr,yytext);}
"]" {printf("%d\t\t%s\t\tCSBRACKET\n",lnctr,yytext);}
";" {printf("%d\t\t%s\t\tSEMICOLON\n",lnctr,yytext);}
":" {printf("%d\t\t%s\t\tCOLON\n", lnctr,yytext);}
"," {printf("%d\t\t%s\t\tCOMMA\n",lnctr, yytext);}
"." {printf("%d\t\t%s\t\tDOT\n",lnctr,yytext);}
".." {printf("%d\t\t%s\t\tDOTDOT\n",lnctr,yytext);}
"+" { printf("%d\t\t%s\t\tPLUS\n", lnctr,yytext);}
"-" { printf("%d\t\t%s\t\tMINUS\n",lnctr,yytext);}
"*" { printf("%d\t\t%s\t\tMUL\n", lnctr,yytext);}
"/" { printf("%d\t\t%s\t\tDIV\n",lnctr, yytext);}
"%" { printf("%d\t\t%s\t\tMOD\n", lnctr,yytext);}
":=" { printf("%d\t\t%s\t\tASSIGN\n",lnctr,yytext);}
"=" { printf("%d\t\t%s\t\tEQ\n",lnctr,yytext);}
"<>" { printf("%d\t\t%s\t\tNEQ\n",lnctr,yytext);}
"<" { printf("%d\t\t%s\t\tLT\n",lnctr, yytext);}
">" { printf("%d\t\t%s\t\tGT\n", lnctr,yytext);}
"<=" { printf("%d\t\t%s\t\tLTE\n", lnctr,yytext);}
">=" { printf("%d\t\t%s\t\tGTE\n", lnctr,yytext);}
["].*["] { printf("%d\t\t%s\t\tSTRING\n", lnctr,yytext);}
[\n] {printf("%d\t\t\t\tNEWLINE\n",lnctr);
        lnctr++;}
[\t]* {;}
[" "]+ {;}

. { fprintf (stderr, "'%c' (0%o): illegal charcter at line %d\n",
              yytext[0], yytext[0], lnctr); }



%%

int main(int argc, char *argv[]){
    // int capacity=100;
    // int size=0;
    
    // table *t = malloc(capacity * sizeoof(table));
    // if(t==NULL){
    //     printf(stderr,"Mem failed\n");
    //     printf("Input: %s Token: %d\n", 1;
    // }

    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        printf("Error opening file.\n");
        return 1; 
    }

    yyin = file;

    printf("------LEXICAL ANALYSIS TOKEN GENERATOR------\n");
    printf("Line\t\tLexeme\t\tToken Type\n");

    
    
    yylex();
    
   fclose(file);
}

int yywrap(){
    return 1;
}

%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "headerss.h"

extern int yylex();
void yyerror(const char *s);
int yywrap();
extern FILE* yyin;


int label = 0; 
int temp1 = -1;
int tempPostWhile = -1;
int tempPostIf = -1;
int temp2 = -1;
int else1 = -1;
int for1 = -1;
int for2 = -1;
int forT = -1;
int forEnd = -1;



%}

/* %union { struct var_name { 
            char name[100]; 
            struct node* nd;
        } lexeme;
} */

%union{
    struct lexeme{char* name;
    int label;} lexeme;
}
%token <lexeme> T_PROGRAM
%token <lexeme> T_VARIABLE

%token <lexeme> T_AND
%token <lexeme> T_OR
%token <lexeme> T_NOT
%token <lexeme> T_ELSE

%token <lexeme> T_INT
%token <lexeme> T_REAL
%token <lexeme> T_BOOLEAN
%token <lexeme> T_CHAR 

%token <lexeme> T_FOR
%token <lexeme> T_DO
%token <lexeme> T_WHILE
%token <lexeme> T_IF
%token <lexeme> T_THEN
%token <lexeme> T_ARRAY

%token <lexeme> T_BEGIN
%token <lexeme> T_END

%token <lexeme> T_READ
%token <lexeme> T_WRITE 

%token <lexeme> ID
%token <lexeme> INTEGERNUMBER
%token <lexeme> REALNUMBER
%token <lexeme> STR


%token <lexeme> OB
%token <lexeme> CB
%token <lexeme> OSBRACKET
%token <lexeme> CSBRACKET 
%token <lexeme> SEMI
%token <lexeme> COLON
%token <lexeme> COMMA
%token <lexeme> DOT
%token <lexeme> PLUS
%token <lexeme> MINUS
%token <lexeme> MUL
%token <lexeme> DIV
%token <lexeme> MOD
%token <lexeme> ASSIGN
%token <lexeme> EQ
%token <lexeme> NEQ
%token <lexeme> LT
%token <lexeme> GT
%token <lexeme> LTE
%token <lexeme> GTE
%token <lexeme> OF
%token <lexeme> T_TO
%token <lexeme> T_DOWNTO
%token <lexeme> DOTDOT 



%type <lexeme> program
%type <lexeme> var_decl_list
%type <lexeme> var_decl_list_line
%type <lexeme> var_decl
%type <lexeme> type_name
%type <lexeme> array_type
%type <lexeme> type_list
%type <lexeme> compound_stmt
/* %type <lexeme> var_list  */

%type <lexeme> stmt_list
%type <lexeme> stmt
%type <lexeme> assign_stmt
%type <lexeme> write_stmt
%type <lexeme> read_stmt
%type <lexeme> if_stmt
%type <lexeme> else_block
%type <lexeme> while_stmt
%type <lexeme> for_stmt
%type <lexeme> expr  
%type <lexeme> term
%type <lexeme> factor
%type <lexeme> primary
%type <lexeme> atom

%right ASSIGN
%left SEMI
%left COMMA
%left EQ NEQ LT GT LTE GTE         // Comparison operators
%left PLUS MINUS                  // Addition and subtraction
%left MUL DIV MOD                 // Multiplication, division, and modulus
%left T_AND T_OR                  // Logical AND and OR
%left T_NOT 


%%

program : T_PROGRAM ID SEMI T_VARIABLE var_decl_list compound_stmt DOT;

var_decl_list : var_decl_list_line
              | var_decl_list var_decl_list_line
              ;

var_decl_list_line : var_decl COLON type_name SEMI;

var_decl : ID
         | ID COMMA var_decl
         ;

/* var_list : var_decl
        // | var_list COMMA var_decl */
         ;
type_name : type_list
          | array_type
          ;

array_type : T_ARRAY OSBRACKET INTEGERNUMBER DOTDOT INTEGERNUMBER CSBRACKET OF type_list
           ;


type_list : T_INT{$$=$1;}
          | T_REAL{$$=$1;}
          | T_BOOLEAN{$$=$1;}
          | T_CHAR{$$=$1;}
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

assign_stmt : ID ASSIGN expr {assignment($1.name, $3.name);} 
            ;

write_stmt : T_WRITE OB expr_list CB;



expr_list : expr 
          | expr_list COMMA expr
          ;

read_stmt : T_READ OB ID CB
          | T_READ OB ID OSBRACKET INTEGERNUMBER CSBRACKET CB
          | T_READ OB ID OSBRACKET ID CSBRACKET CB
          ;

if_stmt :T_IF expr { if($2.label==-1)$2.label = ++label;
        printf("T%d = 0\n", varTemp);
        if(else1==-1)else1 = ++label;
        printf("iftrue T%d goto L%d\n", varTemp, else1);
        printf("T%d = 1\n", varTemp);
        printf("iftrue T%d goto L%d\n", varTemp++, $2.label);
        printf("L%d: \n", $2.label);}
        T_THEN compound_stmt 
        {   
        if(tempPostIf==-1)tempPostIf = ++label;
        printf("goto L%d\n", tempPostIf);
        $5.label = else1; printf("L%d: \n", else1);}
        else_block
        {
        if(tempPostIf==-1)tempPostIf = ++label;
        $7.label = tempPostIf; printf("L%d: \n", $7.label);}
        |
         T_IF expr { if($2.label==-1)$2.label = ++label;
        printf("T%d = 0\n", varTemp);
        if(tempPostIf==-1)tempPostIf = ++label;
        printf("iftrue T%d goto L%d\n", varTemp, tempPostIf);
        printf("T%d = 1\n", varTemp);
        printf("iftrue T%d goto L%d\n", varTemp++, $2.label);        
        printf("L%d: \n", $2.label);}
         T_THEN compound_stmt {$5.label = tempPostIf;
            printf("L%d: \n", tempPostIf);} 
        ;

/* if_stmt : T_IF expr { if($2.label==-1)$2.label = ++label;
        printf("T%d = 0\n", varTemp);
        if(tempPostIf==-1)tempPostIf = ++label;
        printf("iftrue T%d goto L%d\n", varTemp, tempPostIf);
        printf("T%d = 1\n", varTemp);
        printf("iftrue T%d goto L%d\n", varTemp++, $2.label);        
        printf("L%d: \n", $2.label);}
         T_THEN compound_stmt {$5.label = tempPostIf;
            printf("L%d: \n", tempPostIf);}
        ; */

else_block : T_ELSE compound_stmt {   
                if(tempPostIf==-1)tempPostIf = ++label;
                printf("goto L%d\n", tempPostIf);} 
           | T_ELSE if_stmt 
           |
           ;

while_stmt : T_WHILE expr 
            { if($2.label==-1)$2.label = ++label; 
            printf("L%d: \n", $2.label); /*printf("L%d: \n", ++label);*/ 
            printf("T%d = 0\n", varTemp); if(tempPostWhile==-1)tempPostWhile = ++label;  
            printf("iftrue T%d goto L%d\n",  varTemp, tempPostWhile); if(temp1 == -1)temp1 = ++label;
            printf("T%d = 1\n", varTemp); printf("iftrue T%d goto L%d\n", varTemp++, temp1);
            } T_DO {printf("L%d: \n", temp1);} compound_stmt 
            {$6.label = temp1; printf("L%d: \n", tempPostWhile);}

for_stmt : T_FOR ID ASSIGN atom 
            {assignment($2.name, $4.name);  
            if($2.label==-1)$2.label = ++label;
            printf("L%d: \n", $2.label);}
             T_TO atom 
             {  printf("T%d = %s - %s\n", varTemp, $7.name, $2.name);
                for1 = ++label;
                forEnd = ++label;
                printf("iftrue T%d >= 0 goto L%d\n", varTemp++, for1);
                printf("T%d = 0\n", varTemp);
                printf("goto L%d\n", forEnd);
                printf("T%d = 1\n", varTemp++);
                //printf("goto L%d\n", for1);
                }
             T_DO 
             {
                printf("L%d: \n", for1);
             }
             compound_stmt
             {
                forT = varTemp++;
                printf("T%d = %s + 1\n", forT, $2.name);
                printf("%s = T%d\n", $2.name, forT);    
                printf("goto L%d\n", $2.label);
                printf("L%d: \n", forEnd);            
             }
            
         | T_FOR ID ASSIGN atom 
            {assignment($2.name, $4.name);
             if($2.label==-1)$2.label = ++label;
             printf("L%d: \n", $2.label);}
             T_DOWNTO atom 
             {  printf("T%d = %s - %s\n", varTemp, $2.name, $7.name);
                for2 = ++label;
                forEnd = ++label;
                printf("iftrue T%d >= 0 goto L%d\n", varTemp++, for2);
                printf("T%d = 0\n", varTemp);
                printf("goto L%d\n", forEnd);
                printf("T%d = 1\n", varTemp++);
                //printf("goto L%d\n", for1);
                }
             T_DO
             {
                printf("L%d: \n", for2);
             }
              compound_stmt {
                forT = varTemp++;
                printf("T%d = %s + 1\n", forT, $2.name);
                printf("%s = T%d\n", $2.name, forT);    
                printf("goto L%d\n", $2.label);
                printf("L%d: \n", forEnd);            
             }   
         ;

expr : term
     | expr PLUS term {
            $$.name = treemFunctions($1.name, $2.name, $3.name);
            varTemp = varTemp + 1;
}
     | expr MINUS term {
            $$.name = treemFunctions($1.name, $2.name, $3.name);
            varTemp = varTemp + 1;
}
     ;

term : factor
     | term MUL factor {
            $$.name = treemFunctions($1.name, $2.name, $3.name);
            varTemp = varTemp + 1;
}
     | term DIV factor {
            $$.name = treemFunctions($1.name, $2.name, $3.name);
            varTemp = varTemp + 1;
}
     | term MOD factor {
            $$.name = treemFunctions($1.name, $2.name, $3.name);
            varTemp = varTemp + 1;
}
     ;

factor : primary
       | factor T_AND primary {
            $$.name = treemFunctions($1.name, $2.name, $3.name);
            varTemp = varTemp + 1;
}
       | factor T_OR primary {
            $$.name = treemFunctions($1.name, $2.name, $3.name);
            varTemp = varTemp + 1;
}
       ;

primary : atom
        | primary EQ atom {
            $$.name = treemFunctions($1.name, $2.name, $3.name);
            varTemp = varTemp + 1;
}
        | primary NEQ atom {
            $$.name = treemFunctions($1.name, $2.name, $3.name);
            varTemp = varTemp + 1;
}
        | primary LT atom {
            $$.name = treemFunctions($1.name, $2.name, $3.name);
            varTemp = varTemp + 1;
}
        | primary GT atom {
            $$.name = treemFunctions($1.name, $2.name, $3.name);
            varTemp = varTemp + 1;
}
        | primary LTE atom {
            $$.name = treemFunctions($1.name, $2.name, $3.name);
            varTemp = varTemp + 1;
}
        | primary GTE atom {
            $$.name = treemFunctions($1.name, $2.name, $3.name);
            varTemp = varTemp + 1;
}
        ;

atom : ID{$$.name = $1.name;}
     | INTEGERNUMBER{$$.name = $1.name;}
     | REALNUMBER{$$.name = $1.name;}
     | STR{$$.name = $1.name;}
     | ID OSBRACKET expr CSBRACKET{
        //$$.name = $3.name;
        printf("T%d = %s * 4\n", varTemp, $3.name);
        printf("T%d = baseAddr(%s) + T%d\n", 1+varTemp, $1.name, varTemp);varTemp+=1;
       // printf("T%d = T%d\n", varTemp, -1 + varTemp);
        char str[50];
        sprintf(str, "*(T%d)", varTemp++);
        $$.name = str;
        
        }
     | ID OSBRACKET ID CSBRACKET{
        //$$.name = $3.name;
        printf("T%d = %s * 4\n", varTemp, $3.name);
        printf("T%d = baseAddr(%s) + T%d\n", 1+varTemp, $1.name, varTemp);varTemp+=1;
       // printf("T%d = T%d\n", varTemp, -1 + varTemp);
        char str[50];
        sprintf(str, "*(T%d)", varTemp++);
        $$.name = str;
        
        }
     | T_NOT primary
     | OB expr CB{$$.name = $2.name;}
     ;


%%

/* int lbl(int n){
    
    return n + 1;
} */

int main(int argc, char *argv[]) {

    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        printf("Error opening file.\n");
        return 1; 
    }

    yyin = file;

    yyparse();
    /* printf("Completed Lexical Analysis\n");
    printf("Completed Syntax Analysis\n"); */

    fclose(file);
    return 0;
}

/* void yyerror(const char *s) {
    fprintf(stderr, "Error: %s at line count: %d\n", s,lnctr+1 );
    fprintf(stderr, "Token causing the error: %s\n", yytext);
    exit(1);
} */

%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include <unistd.h>


extern int yylex();
void yyerror(const char *s);
int yywrap();
extern FILE* yyin;

struct node {
     struct node *left;
     struct node *right;
     char *token;
     char *etoken;
};

union value {
     int i;
     float f;
     char c;
     bool b;
};

union arr_values{
        int *i;
        float *f;
        char *c;
        bool *b;
    };

struct data_variable {
     char *id_name;
     char *data_type;
     char *type;
     union value val;
     union arr_values arr;
     int arr_len;
     char *plist;
     struct node *fnode;
} id_table[50];


int id_cnt = 0;
int id_start = 0;   
int varListCtr = 0; //type counter
int simulate(struct node *root);
struct node *head;
void print_tree();
void print_id_table();
int is_char(char *tk);
int find_id(char *iden_name);
char *get_type(char *iden_name);
void add_id(char c, char *iden_name, char *value, char *d_type, int d1, int d2);
int lookup_i(char *iden_name, int idx1, int idx2);
float lookup_f(char *iden_name, int idx1, int idx2);
char lookup_c(char *iden_name, int idx1, int idx2);
void update_id(char *iden_name, char *value, int idx1, int idx2);
struct node* mknode(struct node *left, struct node *right, char *token);
struct node* mknode2(struct node *left, struct node *right, char *token, char*etoken);
bool checker(char *type1, char *type2);




%}

%union { struct var_name { 
            char name[100]; 
            struct node* nd;
        } syntax_object;

     struct type2 { 
        char name[100]; 
        struct node* nd;
        char type[6];
        union {
        int i;
        float f;
        char c;
         } val;
        union {
        int *i;
        float *f;
        char *c;
        } arr;
    } syntax_object2;
}

%token <syntax_object> T_PROGRAM
%token <syntax_object> T_VARIABLE

%token <syntax_object> T_AND
%token <syntax_object> T_OR
%token <syntax_object> T_NOT
%token <syntax_object> T_ELSE

%token <syntax_object> T_INT
%token <syntax_object> T_REAL
%token <syntax_object> T_BOOLEAN
%token <syntax_object> T_CHAR 

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

%token <syntax_object2> ID
%token <syntax_object2> INTEGERNUMBER
%token <syntax_object2> REALNUMBER
%token <syntax_object2> STR
%token <syntax_object2> CHAR



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
%token <syntax_object> OF
%token <syntax_object> T_TO
%token <syntax_object> T_DOWNTO
%token <syntax_object> DOTDOT 

/* %type <syntax_object> start */
%type <syntax_object> program
%type <syntax_object2> var_decl_list
%type <syntax_object2> var_decl_list_line
%type <syntax_object2> var_decl
%type <syntax_object2> type_name
%type <syntax_object2> type_list
%type <syntax_object> compound_stmt
//%type <syntax_object2> var_list 

%type <syntax_object> stmt_list
%type <syntax_object> stmt
%type <syntax_object> assign_stmt
%type <syntax_object> write_stmt
%type <syntax_object> read_stmt
%type <syntax_object> if_stmt
%type <syntax_object> else_block
%type <syntax_object> while_stmt
%type <syntax_object> for_stmt
%type <syntax_object2> expr  
%type <syntax_object> expr_list  
%type <syntax_object2> term
%type <syntax_object2> factor
%type <syntax_object2> primary
%type <syntax_object2> atom

%right ASSIGN
%left SEMI
%left COMMA
%left EQ NEQ LT GT LTE GTE         // Comparison operators
%left PLUS MINUS                  // Addition and subtraction
%left MUL DIV MOD                 // Multiplication, division, and modulus
%left T_AND T_OR                  // Logical AND and OR
%left T_NOT 

%%

/* start: program {$$.nd = mknode($1.nd, NULL, "begin"); head = $$.nd;} */

program : T_PROGRAM ID SEMI T_VARIABLE var_decl_list compound_stmt DOT { $$.nd = mknode($5.nd, $6.nd, "program");  head = $$.nd;} ;

var_decl_list : var_decl_list_line {$$.nd = mknode($1.nd,NULL,"var_decl_list" ); }
              | var_decl_list var_decl_list_line {$$.nd = mknode($1.nd,$2.nd,"var_decl_list" );varListCtr++;}
              ;

var_decl_list_line : var_decl COLON type_name SEMI {$$.nd = mknode($1.nd,$3.nd,"var_decl_list" ); for(int i=id_start; i < id_cnt;i++){
   // printf("%d %d\n",i,id_cnt);
    strcpy(id_table[i].data_type,$3.type);
}
//printf("1st end\n");
id_start=id_cnt;};

var_decl : ID {$$.nd = mknode(NULL,NULL,$1.name);
                    strcpy($1.type,$$.type);
                    add_id('V', $1.name, "0", $$.type, (char)varListCtr, 0);//printf("%d ",varListCtr);
}
         | ID COMMA var_decl {$$.nd = mknode(mknode(NULL,NULL,$1.name),$3.nd,"var_decl");
                    add_id('V', $1.name, "0", $$.type, (char)varListCtr, 0);//printf("%d ",varListCtr);
}
         ;

/* var_list : var_decl {$$.nd = mknode($1.nd,NULL,"var_list"); strcpy($1.type,$$.type); 
                
}*/
         /* | //var_list COMMA var_decl {$$.nd = mknode($1.nd,$3.nd,"var_list");
                               add_id('V', $3.name, "0", $3.name, (char)varListCtr, 0);printf("%d ",varListCtr); } */

         

type_name : type_list {$$.nd = mknode($1.nd,NULL,"type_list"); strcpy($$.type,$1.type);}
          | T_ARRAY OSBRACKET INTEGERNUMBER DOTDOT INTEGERNUMBER CSBRACKET OF type_list {$$.nd = mknode($8.nd,NULL,"array_type_list");for(int i=id_start; i < id_cnt;i++){
    //printf("%d %d \n",i,id_cnt);
    strcpy(id_table[i].data_type,$8.type);
}
//printf("2st end\n");
id_start=id_cnt;}
          ;

type_list : T_INT {$$.nd = mknode(NULL, NULL, "T_INT");strcpy($$.type,"int");}
          | T_REAL {$$.nd = mknode(NULL, NULL, "T_REAL");strcpy($$.type,"real");}
          | T_BOOLEAN {$$.nd = mknode(NULL, NULL, "T_BOOLEAN");strcpy($$.type,"bool");}
          | T_CHAR {$$.nd = mknode(NULL, NULL, "T_CHAR");strcpy($$.type,"char");}
          ;

compound_stmt : T_BEGIN stmt_list T_END {$$.nd = mknode($2.nd, NULL, "compound_stmt");};

stmt_list : stmt SEMI {$$.nd = mknode($1.nd, NULL, "stmt_list");}
          | stmt_list stmt SEMI  {$$.nd = mknode($1.nd, $2.nd, "stmt_list");}
          ;

stmt : assign_stmt {$$.nd = mknode($1.nd, NULL, "stmt");}
     | write_stmt {$$.nd = mknode($1.nd, NULL, "stmt");}
     | read_stmt {$$.nd = mknode($1.nd, NULL, "stmt");}
     | if_stmt {$$.nd = mknode($1.nd, NULL, "stmt");}
     | while_stmt {$$.nd = mknode($1.nd, NULL, "stmt");}
     | for_stmt {$$.nd = mknode($1.nd, NULL, "stmt");}
     ;

assign_stmt : ID ASSIGN expr {$$.nd = mknode(mknode(NULL,NULL,$1.name),mknode(NULL,$3.nd,$2.name),"assign_stmt");
if(!checker(get_type($1.name),$3.type)){
    printf("Error in Assignment of different types %s ,%s \n",$1.name,get_type($1.name));
}
}
            ;

write_stmt : T_WRITE OB expr_list CB {$$.nd = mknode(mknode(NULL,NULL,$1.name),$3.nd,"write_stmt");}; 



expr_list : expr {$$.nd = mknode($1.nd, NULL, "expr"); }
          | expr_list COMMA expr {$$.nd = mknode($1.nd, $3.nd, "expr");}
          ;

read_stmt : T_READ OB ID CB  {$$.nd = mknode($1.nd, mknode(NULL,NULL,$3.name), "read"); }
          | T_READ OB ID OSBRACKET INTEGERNUMBER CSBRACKET CB {$$.nd = mknode($1.nd, mknode(NULL,NULL,$3.name), "read"); }
          | T_READ OB ID OSBRACKET ID CSBRACKET CB {$$.nd = mknode($1.nd, mknode(NULL,NULL,$3.name), "read");}
          ;

if_stmt : T_IF primary T_THEN compound_stmt {$$.nd = mknode($2.nd, $4.nd, "if_stmt");}
        | T_IF primary T_THEN compound_stmt else_block {$$.nd = mknode(mknode($2.nd, $4.nd, "if_stmt"),$5.nd,"if_stmt");}
        ;

else_block : T_ELSE compound_stmt {$$.nd = mknode($2.nd, NULL, "else_block");}
           | T_ELSE if_stmt {$$.nd = mknode($2.nd, NULL, "else_block");}
           ;

while_stmt : T_WHILE expr T_DO compound_stmt {$$.nd = mknode($2.nd, $4.nd, "while_stmt");};

for_stmt : T_FOR ID ASSIGN atom T_TO atom T_DO compound_stmt {$$.nd = mknode(mknode($4.nd,$6.nd,"range"), $6.nd, "for");}
         | T_FOR ID ASSIGN atom T_DOWNTO atom T_DO compound_stmt {$$.nd = mknode(mknode($4.nd,$6.nd,"range"), $6.nd, "for");}
         ;

expr : term {$$.nd = mknode($1.nd, NULL, "expr"); strcpy($$.type,$1.type); /*printf("%s ",$1.type);*/}
     | expr PLUS term {$$.nd = mknode($1.nd, $3.nd, "plus");
     if(!checker($1.type,$3.type))
        {
          printf("Error in Addition of different types \n");
        } }
     | expr MINUS term {$$.nd = mknode($1.nd, $3.nd, "minus");
     if(!checker($1.type,$3.type))
        {
          printf("Error in Subtraction of different types \n");
        } }
     ;

term : factor {$$.nd = mknode($1.nd, NULL, "term"); strcpy($$.type,$1.type);}
     | term MUL factor {$$.nd = mknode($1.nd, $3.nd, "mul");
     if(!checker($1.type,$3.type))
        {
          printf("Error in Multiplication types \n");
        }}
     | term DIV factor {$$.nd = mknode($1.nd, $3.nd, "div");
     if(!checker($1.type,$3.type))
        {
          printf("Error in Division types \n");
        }}
     | term MOD factor {$$.nd = mknode($1.nd, $3.nd, "mod");
     if(!checker($1.type,$3.type))
        {
          printf("Error in Modulus types \n");
        }}
     ;

factor : primary {$$.nd = mknode($1.nd, NULL, "factor");strcpy($$.type,$1.type);}
       | factor T_AND primary {$$.nd = mknode($1.nd, $3.nd, "and");
       if(!checker($1.type,$3.type))
        {
          printf("Error in types \n");
        }}
       | factor T_OR primary  {$$.nd = mknode($1.nd, $3.nd, "or");
       if(!checker($1.type,$3.type))
        {
          printf("Error in types \n");
        }}
       ;

primary : atom {$$.nd = mknode($1.nd, NULL, "factor"); strcpy($$.type,$1.type);}
        | primary EQ atom {$$.nd = mknode($1.nd, $3.nd, "equals"); 
        if(!checker($1.type,$3.type))
        {
          printf("Error in types \n");
        } }
        | primary NEQ atom {$$.nd = mknode($1.nd, $3.nd, "not equals");
        if(!checker($1.type,$3.type))
        {
          printf("Error in types \n");
        }}
        | primary LT atom {$$.nd = mknode($1.nd, $3.nd, "less than");
        if(!checker($1.type,$3.type))
        {
          printf("Error in types \n");
        }}
        | primary GT atom {$$.nd = mknode($1.nd, $3.nd, "greater than");
        if(!checker($1.type,$3.type))
        {
          printf("Error in types \n");
        }}
        | primary LTE atom {$$.nd = mknode($1.nd, $3.nd, "less than equal");
        if(!checker($1.type,$3.type))
        {
          printf("Error in types \n");
        }}
        | primary GTE atom {$$.nd = mknode($1.nd, $3.nd, "greater than equal");
        if(!checker($1.type,$3.type))
        {
          printf("Error in types \n");
        }}
        ;

atom : ID {$$.nd = mknode(NULL, NULL, $1.name); strcpy($$.type, get_type($1.name));}
     | INTEGERNUMBER {$$.nd = mknode(NULL, NULL, $1.name); strcpy($$.type, "int");}
     | REALNUMBER {$$.nd = mknode(NULL, NULL, $1.name); strcpy($$.type, "real");}
     | CHAR {$$.nd = mknode(NULL, NULL, $1.name); strcpy($$.type, "char");}
     | STR {$$.nd = mknode(NULL, NULL, $1.name); strcpy($$.type, "str");}
     | ID OSBRACKET INTEGERNUMBER CSBRACKET {$$.nd = mknode($3.nd, NULL, $1.name); strcpy($$.type, get_type($1.name));}
     | ID OSBRACKET ID CSBRACKET   {$$.nd = mknode(mknode(NULL,NULL,$3.name), NULL, $1.name); strcpy($$.type, get_type($1.name));}
     | OB expr CB {$$.nd = mknode($2.nd, NULL, "Bracket Expression");strcpy($$.type, $2.type);}
     | T_NOT primary {$$.nd = mknode($2.nd, NULL, "Negation Expression"); strcpy($$.type, $2.type);}
     ;


%%
int main(int argc, char *argv[]) {
    // Check if the input file is provided as a command-line argument
    if (argc != 2) {
        printf("Usage: %s input_file\n", argv[0]);
        return 1;
    }

    // Open the input file
    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        printf("Error opening file.\n");
        return 1; 
    }

    // Set the lexer input stream to the opened file
    yyin = file;

    // Call yyparse to start parsing
    yyparse();

    // Print messages indicating completion of lexical and syntax analysis
    /* printf("Completed Lexical Analysis\n");
    printf("Completed Syntax Analysis\n"); */
    /* print_id_table();  */
    print_tree();

    printf("Semantic Analysis Complete, Please run tree.py to view AST");
    fclose(file);
    return 0;
}


struct node* mknode(struct node *left, struct node *right, char *token) {
  struct node *newnode = (struct node*) malloc(sizeof(struct node));
  char *newstr = (char*) malloc(strlen(token)+1);
  strcpy(newstr, token);
  newnode->left = left;
  newnode->right = right;
  newnode->token = newstr;
  return(newnode);
}

struct node* mknode2(struct node *left, struct node *right, char *token, char *etk) {
  struct node *newnode = (struct node*) malloc(sizeof(struct node));
  char *newstr = (char*) malloc(strlen(token)+1);
  strcpy(newstr, token);
  newnode->left = left;
  newnode->right = right;
  newnode->token = newstr;
  newnode->etoken = strdup(etk);
  return(newnode);
}

void print_tree2(FILE *fp, struct node *root) {
    if (!root) {
        fprintf(fp, "()");
        return;
    }
    fprintf(fp,"( %s ", root->token);
    print_tree2(fp, root->left);
    print_tree2(fp, root->right);
    fprintf(fp, ")");
}
void print_tree() {
    FILE *fp = fopen("tree.txt", "w");
    print_tree2(fp, head);
}


int find_id(char *iden_name)
{
    for (int i = id_cnt - 1; i >= 0; i--)
    {
        if (strcmp(id_table[i].id_name, iden_name) == 0)
        {
            return 1;
        }
    }
    return 0;
}

char *get_type(char *iden_name)
{
    if (!find_id(iden_name)) {
        printf("Could not find identifier: %s in the id_table\n", iden_name);
        assert(0 && "Finding type of identifier not in table\n");
    }
    for (int i = id_cnt - 1; i >= 0; i--)
    {
        if (strcmp(id_table[i].id_name, iden_name) == 0)
        {
            return id_table[i].data_type;
        }
    }
    return NULL;
}

void add_id(char c, char *iden_name, char *value, char *d_type, int d1, int d2)
{
    /* printf("add_id has been called!!!!!!!!!!!!!!"); */
    if (!find_id(iden_name))
    {
        id_table[id_cnt].id_name = strdup(iden_name);
        id_table[id_cnt].data_type = strdup(d_type);
        if (c == 'F')
        {
            id_table[id_cnt].type = strdup("Function");
            id_table[id_cnt].plist = strdup(value);
        }
        else if (c == 'V')
        {
            id_table[id_cnt].type = strdup("Variable");
            if (strcmp(d_type, "int") == 0)
                id_table[id_cnt].val.i = atoi(value);
            else if (strcmp(d_type, "float") == 0)
                id_table[id_cnt].val.f = atof(value);
            else if (strcmp(d_type, "char") == 0)
                id_table[id_cnt].val.c = value[0];
            /* else
                assert(0 && "Invalid d_type for add_id, variable\n"); */
        }
        else if (c == 'A')
        {
            if (!d1)
            {
                printf("Error: Array size cannot be 0");
                exit(1);
            }
            id_table[id_cnt].arr_len = d1;
           
            {
                id_table[id_cnt].type = strdup("Array1D");
                if (strcmp(d_type, "int") == 0)
                    id_table[id_cnt].arr.i = malloc(d1 * sizeof(int));
                else if (strcmp(d_type, "float") == 0)
                    id_table[id_cnt].arr.f = malloc(d1 * sizeof(float));
                else if (strcmp(d_type, "char") == 0)
                    id_table[id_cnt].arr.c = malloc(d1 * sizeof(char));
                /* else
                    assert(0 && "Invalid d_type for add_id, 1d array\n"); */
            }
            /* else
            {
                id_table[id_cnt].type = strdup("Array2D");
                if (strcmp(d_type, "int") == 0)
                    id_table[id_cnt].arr.i = malloc(d1 * d2 * sizeof(int));
                else if (strcmp(d_type, "float") == 0)
                    id_table[id_cnt].arr.f = malloc(d1 * d2 * sizeof(float));
                else if (strcmp(d_type, "char") == 0)
                    id_table[id_cnt].arr.c = malloc(d1 * d2 * sizeof(char));
                else
                    assert(0 && "Invalid d_type for add_id, 2d array\n");
            } */
        }
        /* else
        {
            assert(0 && "Invalid c for add_id\n");
        } */
        /* printf("Declared variable: %s with data type: %s and value: ", id_table[id_cnt].id_name, id_table[id_cnt].data_type); */
        /* if (strcmp(d_type, "int") == 0)
            printf("%d\n", id_table[id_cnt].val.i);
        else if (strcmp(d_type, "float") == 0)
            printf("%f\n", id_table[id_cnt].val.f);
        else if (strcmp(d_type, "char") == 0)
            printf("%c\n", id_table[id_cnt].val.c); */
        id_cnt++;
    }
    else
    {
        printf("Error: Redeclaration of existing identifier %s\n", iden_name);
        /* exit(1); */
    }
}

void print_id_table()
{
    printf("id_table has %d entries:\n", id_cnt);
    for (int i = 0; i < id_cnt; ++i)
        printf("%s, %s \n", id_table[i].id_name,id_table[i].data_type);
    printf("\n");
}
bool checker(char *type1, char *type2){
    if(!strcmp(type1,type2))
    return true;
    else
    return false;
}
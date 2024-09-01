/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     T_AND = 258,
     T_OR = 259,
     T_NOT = 260,
     T_PROGRAM = 261,
     T_ELSE = 262,
     T_INT = 263,
     T_REAL = 264,
     T_BOOLEAN = 265,
     T_CHAR = 266,
     T_VARIABLE = 267,
     T_FOR = 268,
     T_DO = 269,
     T_WHILE = 270,
     T_IF = 271,
     T_THEN = 272,
     T_ARRAY = 273,
     T_BEGIN = 274,
     T_END = 275,
     T_READ = 276,
     T_WRITE = 277,
     ID = 278,
     INTEGERNUMBER = 279,
     REALNUMBER = 280,
     OB = 281,
     CB = 282,
     OSBRACKET = 283,
     CSBRACKET = 284,
     SEMI = 285,
     COLON = 286,
     COMMA = 287,
     DOT = 288,
     PLUS = 289,
     MINUS = 290,
     MUL = 291,
     DIV = 292,
     MOD = 293,
     ASSIGN = 294,
     EQ = 295,
     NEQ = 296,
     LT = 297,
     GT = 298,
     LTE = 299,
     GTE = 300,
     STR = 301,
     OF = 302,
     T_TO = 303,
     T_DOWNTO = 304,
     DOTDOT = 305
   };
#endif
/* Tokens.  */
#define T_AND 258
#define T_OR 259
#define T_NOT 260
#define T_PROGRAM 261
#define T_ELSE 262
#define T_INT 263
#define T_REAL 264
#define T_BOOLEAN 265
#define T_CHAR 266
#define T_VARIABLE 267
#define T_FOR 268
#define T_DO 269
#define T_WHILE 270
#define T_IF 271
#define T_THEN 272
#define T_ARRAY 273
#define T_BEGIN 274
#define T_END 275
#define T_READ 276
#define T_WRITE 277
#define ID 278
#define INTEGERNUMBER 279
#define REALNUMBER 280
#define OB 281
#define CB 282
#define OSBRACKET 283
#define CSBRACKET 284
#define SEMI 285
#define COLON 286
#define COMMA 287
#define DOT 288
#define PLUS 289
#define MINUS 290
#define MUL 291
#define DIV 292
#define MOD 293
#define ASSIGN 294
#define EQ 295
#define NEQ 296
#define LT 297
#define GT 298
#define LTE 299
#define GTE 300
#define STR 301
#define OF 302
#define T_TO 303
#define T_DOWNTO 304
#define DOTDOT 305




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 15 "parser.y"
{ struct var_name { 
            char name[100]; 
            struct node* nd;
        } syntax_object;
}
/* Line 1529 of yacc.c.  */
#line 155 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;


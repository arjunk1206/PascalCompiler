# PascalCompiler

** Group Details Code: BAGEL619 **
Members:
Arjun Khandelwal 2020B3A70848H
Shreyash Mahapatra 2020B3A71167H
Kushal Kanagarla Anurag 2020B4A72168H
Kunal Bansal 2020B2A72456H


# Part 1: Lexical Analysis

Please run the following commands:

flex lexer.l
cc lex.yy.c
./a.out <input_file_name>

# Part 2: Syntax Analysis

flex lexer.l
bison -d --yacc parser.y
cc y.tab.c
./a.out <input_file_name>

<input_file_name> refers to the file to be tested

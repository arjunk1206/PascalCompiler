# Compilation Instructions
Arjun Khandelwal 2020B3A70848H
Shreyash Mahapatra 2020B3A71167H
Kushal Kanagarla 2020B4A72168H
Kunal Bansal 2020B2A72456H
# Semantic Analysis

please run the following commands:

lex lexer.l
bison -d --yacc parser.y
cc lex.yy.c y.tab.c -ll -o program
./program input.txt
python3 tree.py

# ThreeAddressCode 

please run the following commands:

lex lexer.l
bison -d --yacc parser.y
cc lex.yy.c y.tab.c
./a.out input.txt

# CodeGeneration 

please run the following commands:

lex lexer.l
bison -d --yacc parser.y
cc lex.yy.c y.tab.c
./a.out input.txt


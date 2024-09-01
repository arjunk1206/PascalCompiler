#include <stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>
#include<ctype.h>
int varTemp = 0;
void assignment(char* lhs, char* rhs)
    {


        printf("%s = %s\n", lhs, rhs);

    }
    int codeGenerator(char* lhs, char* op, char* rhs)
    {
        printf("T%d = %s %s %s\n", varTemp, lhs, op, rhs);return varTemp;
    }
    char* temporaryVariableGeneration(int x)
    {
        char* temp = (char*)malloc(sizeof(char)*10);temp[0] = 'T';
        snprintf(temp, 10, "T%d", x);return temp;
    }
    char* treemFunctions(char* lhs, char* op, char* rhs){
        int a = codeGenerator(lhs, op, rhs); char* tempVar = temporaryVariableGeneration(a);
        return tempVar; 
    }
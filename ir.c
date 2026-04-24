#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "ir.h"

Quad quads[1000];
int quad_index = 0;
int temp_count = 0;

char* new_temp() {
    char *temp = (char*)malloc(20);
    sprintf(temp, "t%d", temp_count++);
    return temp;
}

void emit(char *op, char *a1, char *a2, char *res) {
    strcpy(quads[quad_index].op, op);
    strcpy(quads[quad_index].arg1, a1);
    strcpy(quads[quad_index].arg2, a2);
    strcpy(quads[quad_index].result, res);
    quad_index++;
}

void print_ir() {
    printf("\n--- INTERMEDIATE CODE ---\n");

    for(int i=0;i<quad_index;i++) {

        if(strcmp(quads[i].op,"label")==0)
            printf("%s:\n", quads[i].result);

        else if(strcmp(quads[i].op,"=")==0)
            printf("%s = %s\n",
                quads[i].result,
                quads[i].arg1);

        else if(strcmp(quads[i].op,"+")==0 ||
                strcmp(quads[i].op,"*")==0)
            printf("%s = %s %s %s\n",
                quads[i].result,
                quads[i].arg1,
                quads[i].op,
                quads[i].arg2);

        else if(strcmp(quads[i].op,"if")==0)
            printf("if %s goto %s\n",
                quads[i].arg1,
                quads[i].result);

        else if(strcmp(quads[i].op,"print")==0)
            printf("print %s\n", quads[i].arg1);
    }
}
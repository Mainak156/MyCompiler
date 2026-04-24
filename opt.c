#include <stdio.h>
#include <string.h>
#include "ir.h"

typedef struct {
    char temp[20];
    char value[20];
} Map;

Map map[100];
int map_count = 0;

char* resolve(char *x) {
    for(int i=0;i<map_count;i++) {
        if(strcmp(map[i].temp, x)==0)
            return map[i].value;
    }
    return x;
}

void print_optimized_ir() {

    printf("\n--- OPTIMIZED CODE ---\n");

    map_count = 0;

    for(int i=0;i<quad_index;i++) {

        if(strcmp(quads[i].op,"=")==0 && quads[i].result[0]=='t') {
            strcpy(map[map_count].temp, quads[i].result);
            strcpy(map[map_count].value, quads[i].arg1);
            map_count++;
            continue;
        }

        char *a1 = resolve(quads[i].arg1);
        char *a2 = resolve(quads[i].arg2);

        if(strcmp(quads[i].op,"label")==0)
            printf("%s:\n", quads[i].result);

        else if(strcmp(quads[i].op,"=")==0)
            printf("%s = %s\n", quads[i].result, a1);

        else if(strcmp(quads[i].op,"*")==0)
            printf("%s = %s * %s\n",
                quads[i].result, a1, a2);

        else if(strcmp(quads[i].op,"+")==0)
            printf("%s = %s + %s\n",
                quads[i].result, a1, a2);

        else if(strcmp(quads[i].op,"print")==0)
            printf("print %s\n", a1);

        else if(strcmp(quads[i].op,"if")==0)
            printf("if %s goto %s\n", a1, quads[i].result);

        else if(strcmp(quads[i].op,"return")==0)
            printf("return %s\n", quads[i].arg1);
    }
}
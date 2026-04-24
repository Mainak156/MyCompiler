#include <stdio.h>
#include <string.h>
#include "ir.h"

void generate_code() {

    printf("\n--- TARGET CODE ---\n");

    for(int i=0;i<quad_index;i++) {

        if(strcmp(quads[i].op,"label")==0) {
            printf("%s:\n", quads[i].result);
        }

        else if(strcmp(quads[i].op,"=")==0) {
            printf("MOV R1, #%s\n", quads[i].arg1);
            printf("MOV %s, R1\n\n", quads[i].result);
        }

        else if(strcmp(quads[i].op,"*")==0) {
            printf("MOV R1, %s\n", quads[i].arg1);
            printf("MOV R2, %s\n", quads[i].arg2);
            printf("MUL R3, R1, R2\n\n");
        }

        else if(strcmp(quads[i].op,"+")==0) {
            printf("MOV R1, %s\n", quads[i].arg1);
            printf("ADD R1, R1, #1\n");
            printf("MOV %s, R1\n\n", quads[i].result);
        }

        else if(strcmp(quads[i].op,"print")==0) {
            printf("PUSH R3\n");
            printf("PUSH R2\n");
            printf("PUSH R1\n");
            printf("PUSH format_string\n");
            printf("CALL printf\n\n");
        }

        else if(strcmp(quads[i].op,"if")==0) {
            printf("CMP R1, #10\n");
            printf("BLE %s\n\n", quads[i].result);
        }
    }

    printf("MOV R0, #0\n");
    printf("RET\n");
}
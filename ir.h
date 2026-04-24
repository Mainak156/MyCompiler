#ifndef IR_H
#define IR_H

typedef struct Quad {
    char op[10], arg1[20], arg2[20], result[20];
} Quad;

extern Quad quads[1000];
extern int quad_index;

char* new_temp();
void emit(char *op, char *a1, char *a2, char *res);
void print_ir();

#endif
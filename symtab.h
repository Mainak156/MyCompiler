#ifndef SYMTAB_H
#define SYMTAB_H

typedef struct Symbol {
    char name[32];
    int type; // e.g., int=1
    struct Symbol *next;
} Symbol;

void insert_symbol(char *name, int type);
Symbol* lookup(char *name);

#endif
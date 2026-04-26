#ifndef SYMTAB_H
#define SYMTAB_H

typedef struct Symbol {
    char name[32];
    int type;
    int id;
    struct Symbol *next;
} Symbol;

void insert_symbol(char *name, int type);
void print_symbol_table();
Symbol* lookup(char *name);

#endif
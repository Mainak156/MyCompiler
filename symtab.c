#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symtab.h"

#define SIZE 97

Symbol* table[SIZE] = {0};

int hash(char *s) {
    int h=0;
    while(*s) h = (h<<1) + *s++;
    return h % SIZE;
}

void insert_symbol(char *name, int type) {
    if(lookup(name)) return; // avoid duplicates

    int h = hash(name);
    Symbol *s = (Symbol*)malloc(sizeof(Symbol));
    strcpy(s->name, name);
    s->type = type;
    s->next = table[h];
    table[h] = s;
}

Symbol* lookup(char *name) {
    int h = hash(name);
    Symbol *s = table[h];

    while(s) {
        if(strcmp(s->name, name)==0) return s;
        s = s->next;
    }
    return NULL;
}

/* 🔥 NEW: PRINT SYMBOL TABLE */
void print_symbol_table() {
    printf("\n--- SYMBOL TABLE ---\n");
    printf("Name\tType\n");

    for(int i=0;i<SIZE;i++) {
        Symbol *s = table[i];
        while(s) {
            printf("%s\tint\n", s->name);
            s = s->next;
        }
    }
}
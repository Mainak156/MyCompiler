#include <stdio.h>

int yyparse();

/* declare all functions */
void print_ir();
void print_optimized_ir();
void generate_code();
void print_symbol_table();

int main() {

    printf("Enter code:\n");

    yyparse();

    print_symbol_table();

    print_ir();

    print_optimized_ir();

    generate_code();

    return 0;
}
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include "ast.h"
#include "symtab.h"
#include "ir.h"

AST* root;
int yylex();
void yyerror(const char *s);

/* Label generator */
int label_count = 0;
char* new_label() {
    static char label[10];
    sprintf(label, "L%d", label_count++);
    return label;
}

/* GLOBAL TEMPS (🔥 KEY FIX) */
char t_num[10];   // t1
char t_i[10];     // t2

/* Number check */
int is_number(char *s) {
    for(int i = 0; s[i]; i++) {
        if(!isdigit(s[i])) return 0;
    }
    return 1;
}
%}

%union {
    int num;
    char* str;
    AST* node;
}

%token INT MAIN DO WHILE PRINTF RETURN
%token <num> NUMBER
%token <str> ID STRING
%token INC LE

%type <node> expr stmt stmt_list cond marker

%left '+'
%left '*'

%%

program:
    INT MAIN '(' ')' '{' decl stmt_list RETURN NUMBER ';' '}'
    {
        emit("return", "0", "", "");   // 🔥 FIX
        printf("\nParsing Successful\n");
    }
;

decl:
    INT ID '=' NUMBER ',' ID '=' NUMBER ';'
    {
        insert_symbol($2,1);
        insert_symbol($6,1);

        char v1[10], v2[10];
        sprintf(v1,"%d",$4);
        sprintf(v2,"%d",$8);

        emit("=", v1, "", $2);

        /* t1 = num */
        strcpy(t_num, new_temp());
        emit("=", $2, "", t_num);

        emit("=", v2, "", $6);

        /* t2 = i */
        strcpy(t_i, new_temp());
        emit("=", $6, "", t_i);
    }
;

stmt_list:
    stmt_list stmt
  | stmt
;

stmt:
    ID '=' expr ';'
    {
        emit("=", $3->name, "", $1);
    }

  | DO marker '{' stmt_list '}' WHILE '(' cond ')' ';'
    {
        emit("if", $8->name, "", $2->name);
    }

  | PRINTF '(' STRING ',' ID ',' ID ',' ID '*' ID ')' ';'
    {
        /* 🔥 USE SAME t1, t2 */
        char *t3 = new_temp();

        emit("*", t_num, t_i, t3);
        emit("print", t3, "", "");
    }

  | ID INC ';'
    {
        char *t4 = new_temp();

        emit("+", t_i, "1", t4);   // t4 = t2 + 1
        emit("=", t4, "", $1);     // i = t4

        /* 🔥 update t_i */
        strcpy(t_i, t4);
    }
;

marker:
{
    char *label = new_label();
    emit("label", "", "", label);

    AST* n = make_node(NODE_ID);
    strcpy(n->name, label);
    $$ = n;
}
;

cond:
    ID LE NUMBER
    {
        char val[10];
        sprintf(val,"%d",$3);

        AST* n = make_node(NODE_BINOP);

        /* 🔥 use t2 in condition */
        sprintf(n->name,"%s <= %s", t_i, val);

        $$ = n;
    }
;

expr:
    expr '+' expr
    {
        if(is_number($1->name) && is_number($3->name)) {
            int res = atoi($1->name) + atoi($3->name);
            $$ = make_num(res);
            sprintf($$->name,"%d",res);
        } else {
            $$ = make_binop('+',$1,$3);

            char *t1 = new_temp();
            char *t2 = new_temp();
            char *t3 = new_temp();

            emit("=", $1->name, "", t1);
            emit("=", $3->name, "", t2);
            emit("+", t1, t2, t3);

            strcpy($$->name, t3);
        }
    }

  | expr '*' expr
    {
        if(is_number($1->name) && is_number($3->name)) {
            int res = atoi($1->name) * atoi($3->name);
            $$ = make_num(res);
            sprintf($$->name,"%d",res);
        } else {
            $$ = make_binop('*',$1,$3);

            char *t1 = new_temp();
            char *t2 = new_temp();
            char *t3 = new_temp();

            emit("=", $1->name, "", t1);
            emit("=", $3->name, "", t2);
            emit("*", t1, t2, t3);

            strcpy($$->name, t3);
        }
    }

  | NUMBER
    {
        $$ = make_num($1);
        sprintf($$->name,"%d",$1);
    }

  | ID
    {
        $$ = make_id($1);
        strcpy($$->name,$1);
    }
;

%%

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}
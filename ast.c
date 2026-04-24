#include <stdlib.h>
#include <string.h>
#include "ast.h"

AST* make_node(NodeType t) {
    AST* n = (AST*)malloc(sizeof(AST));
    n->type = t;
    n->left = n->right = n->third = NULL;
    return n;
}

AST* make_num(int val) {
    AST* n = make_node(NODE_NUM);
    n->value = val;
    return n;
}

AST* make_id(char *name) {
    AST* n = make_node(NODE_ID);
    strcpy(n->name, name);
    return n;
}

AST* make_binop(char op, AST *l, AST *r) {
    AST* n = make_node(NODE_BINOP);
    n->op = op;
    n->left = l;
    n->right = r;
    return n;
}

AST* make_assign(AST *id, AST *expr) {
    AST* n = make_node(NODE_ASSIGN);
    n->left = id;
    n->right = expr;
    return n;
}

AST* make_stmt_list(AST *l, AST *r) {
    AST* n = make_node(NODE_STMT_LIST);
    n->left = l;
    n->right = r;
    return n;
}
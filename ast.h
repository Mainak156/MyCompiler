#ifndef AST_H
#define AST_H

typedef enum {
    NODE_NUM, NODE_ID, NODE_BINOP, NODE_ASSIGN,
    NODE_STMT_LIST, NODE_WHILE, NODE_DOWHILE
} NodeType;

typedef struct AST {
    NodeType type;
    char op;
    int value;
    char name[32];

    struct AST *left;
    struct AST *right;
    struct AST *third;
} AST;

AST* make_node(NodeType t);

AST* make_num(int val);
AST* make_id(char *name);
AST* make_binop(char op, AST *l, AST *r);
AST* make_assign(AST *id, AST *expr);
AST* make_stmt_list(AST *l, AST *r);

#endif
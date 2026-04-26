%{
#include "ast.h"
#include "parser.tab.h"
#include "symtab.h"

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
%}

%%

"int"       { return INT; }
"main"      { return MAIN; }
"do"        { return DO; }
"while"     { return WHILE; }
"printf"    { return PRINTF; }
"return"    { return RETURN; }

"++"        { return INC; }
"<="        { return LE; }
"<"         { return '<'; }
">"         { return '>'; }

[0-9]+      { yylval.num = atoi(yytext); return NUMBER; }

\".*\"      { yylval.str = strdup(yytext); return STRING; }

[a-zA-Z_][a-zA-Z0-9_]* {
    insert_symbol(yytext, 1);
    Symbol* s = lookup(yytext);

    printf("id%d ", s->id);   // 🔥 TOKEN FORMAT

    yylval.str = strdup(yytext);
    return ID;
}

"="     { return '='; }
"+"     { return '+'; }
"*"     { return '*'; }

"("     { return '('; }
")"     { return ')'; }
"{"     { return '{'; }
"}"     { return '}'; }
","     { return ','; }
";"     { return ';'; }

[ \t\n] ;
. ;

%%

int yywrap() { return 1; }
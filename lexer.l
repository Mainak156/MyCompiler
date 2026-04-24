%{
#include "ast.h"
#include "parser.tab.h"
#include <string.h>
#include <stdlib.h>
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
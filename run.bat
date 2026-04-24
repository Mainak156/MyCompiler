@echo on
color 0A

echo =====================================
echo STARTING BUILD
echo =====================================

echo Cleaning...
del *.exe *.tab.c *.tab.h lex.yy.c

echo Running Flex...
win_flex lexer.l

echo Running Bison...
win_bison -d parser.y

echo Compiling...
gcc lex.yy.c parser.tab.c ast.c symtab.c ir.c opt.c codegen.c main.c -o compiler.exe

echo Running program...
compiler.exe < input.c

echo DONE
pause
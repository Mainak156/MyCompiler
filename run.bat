@echo off
cls
color 0A
title Mini Compiler

echo =====================================
echo        MINI COMPILER
echo =====================================
echo.

echo [1/4] Cleaning...
del *.exe *.tab.c *.tab.h lex.yy.c >nul 2>&1

echo [2/4] Running Flex...
win_flex lexer.l >nul

echo [3/4] Running Bison...
win_bison -d parser.y >nul

echo [4/4] Compiling...
gcc lex.yy.c parser.tab.c ast.c symtab.c ir.c opt.c codegen.c main.c -o compiler.exe >nul

echo.
echo ===== RUNNING PROGRAM =====
echo.

compiler.exe < input.c

echo.
echo ===== DONE =====
pause
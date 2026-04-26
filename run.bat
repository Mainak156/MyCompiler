@echo off
color 0A
title Mini Compiler

:: ---------- Splash ----------
cls
echo =====================================
echo        MINI COMPILER 🚀
echo =====================================
echo.
echo Initializing...
timeout /t 1 >nul

:: ---------- Build ----------
cls
echo =====================================
echo        BUILDING PROJECT
echo =====================================
echo.

echo [1/4] Cleaning...
del *.exe *.tab.c *.tab.h lex.yy.c >nul 2>&1

echo [2/4] Running Flex...
win_flex lexer.l >nul 2>&1

echo [3/4] Running Bison...
win_bison -d parser.y >nul 2>&1

echo [4/4] Compiling...
gcc lex.yy.c parser.tab.c ast.c symtab.c ir.c opt.c codegen.c main.c -o compiler.exe >nul 2>&1

echo.
echo ✅ Build Successful!
timeout /t 1 >nul

:: ---------- Run ----------
cls
echo =====================================
echo        PROGRAM OUTPUT
echo =====================================
echo.

compiler.exe < input.c

echo.
echo =====================================
echo              DONE
echo =====================================
pause
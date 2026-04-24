# Mini Compiler Project

## Project Description

This is an educational mini compiler implementation that processes a subset of the C programming language and transforms it through all six phases of the compilation process. The compiler demonstrates fundamental compiler design principles and the complete compilation pipeline from source code to target code generation.

**Supported Language Features:**
- Integer variable declarations and operations
- Do-while loops with conditional statements
- Printf function for output
- Arithmetic and logical expressions
- Variable assignments and usage

The compiler is built using industry-standard tools:
- **Flex (Lex)** for lexical analysis
- **Bison (Yacc)** for syntax analysis
- **C** for implementing semantic analysis, code generation, and optimization

---

## Features

- **Lexical Analysis (Tokenization)**: Uses Flex to convert source code into meaningful tokens
- **Syntax Analysis (Parsing)**: Implements a complete parser using Bison with grammar rules
- **Abstract Syntax Tree (AST)**: Builds an internal tree representation for structured parsing
- **Semantic Analysis**: Validates type compatibility and semantic correctness
- **Symbol Table Management**: Maintains and manages variable declarations and scopes
- **Intermediate Code Generation**: Produces Three Address Code (TAC) as intermediate representation
- **Code Optimization**: Performs basic optimization techniques on the intermediate code
- **Target Code Generation**: Produces assembly-like output for execution

---

## Compiler Phases

The compiler implements all six standard phases of compilation:

### 1. Lexical Analyzer (Lexer)
Reads the source code character by character and produces a sequence of tokens. Uses Flex (lex) to recognize lexemes and classify them as keywords, identifiers, operators, literals, etc.

### 2. Syntax Analyzer (Parser)
Takes the token stream from the lexer and verifies that it conforms to the grammar rules. Produces an Abstract Syntax Tree (AST) representing the structure of the program.

### 3. Semantic Analyzer
Validates semantic rules such as:
- Variable declaration before use
- Type compatibility in expressions
- Proper function calls and parameter matching

Maintains and references the symbol table for scope and type information.

### 4. Intermediate Code Generator
Converts the AST into Three Address Code (TAC), a simple intermediate representation that is machine-independent and easier to optimize.

### 5. Code Optimizer
Performs basic optimization techniques such as:
- Dead code elimination
- Constant folding
- Common subexpression elimination

### 6. Code Generator
Translates the optimized intermediate code into target code (assembly-like output) that can be executed.

---

## Architecture Overview

The compiler architecture follows a pipeline design:

```
Input Source Code
      ↓
  [Lexer (Flex)] → Tokenization
      ↓
  [Parser (Bison)] → Abstract Syntax Tree
      ↓
  [Semantic Analyzer] → Symbol Table & Type Checking
      ↓
  [IR Generator] → Three Address Code
      ↓
  [Optimizer] → Optimized IR
      ↓
  [Code Generator] → Target Code Output
      ↓
  Executable Output
```

**Component Interactions:**
- `lexer.l` generates tokens from source code
- `parser.y` constructs the AST from tokens
- Symbol table stores variable and scope information
- IR generator converts AST to intermediate representation
- Optimizer improves the intermediate code
- Code generator produces final output

---

## Directory Structure

```
MyCompiler/
├── lexer.l                 # Flex lexer specification
├── parser.y                # Bison parser specification
├── ast.h                   # AST structure definitions
├── ast.c                   # AST implementation
├── symtab.h                # Symbol table header
├── symtab.c                # Symbol table implementation
├── ir.h                    # Intermediate code header
├── ir.c                    # Intermediate code generator
├── opt.c                   # Optimizer implementation
├── codegen.c               # Target code generator
├── main.c                  # Main compiler entry point
├── input.c                 # Sample input program
├── run.bat                 # Automated build and run script
└── README.md               # This file
```

---

## Requirements

### Tools and Software

| Tool | Purpose | Minimum Version |
|------|---------|-----------------|
| GCC (MinGW) | C Compiler | 7.0 or later |
| win_flex_bison | Flex and Bison for Windows | Latest |
| Windows Command Prompt or PowerShell | Build environment | - |

### System Requirements
- Windows Operating System (XP or later)
- Minimum 100 MB free disk space
- Command line access

---

## Installation Steps (Windows)

### Step 1: Download and Install win_flex_bison

1. Visit the [win_flex_bison GitHub releases page](https://github.com/lexxmark/winflexbison/releases)
2. Download the latest release (e.g., `win_flex_bison-2.5.25.zip`)
3. Extract to a directory (e.g., `C:\win_flex_bison`)

### Step 2: Add to System PATH

1. Open **Environment Variables**:
   - Right-click **This PC** → **Properties** → **Advanced system settings** → **Environment Variables**
2. Under **System variables**, select **Path** and click **Edit**
3. Click **New** and add: `C:\win_flex_bison`
4. Click **OK** and restart your terminal

### Step 3: Verify win_flex_bison Installation

```bash
win_flex --version
win_bison --version
```

### Step 4: Install GCC (MinGW)

1. Download MinGW from [mingw-w64.org](https://www.mingw-w64.org/)
2. Run the installer and select:
   - Architecture: x86_64
   - Threads: posix
   - Exception: seh
3. Complete installation and add MinGW bin directory to PATH (e.g., `C:\mingw-w64\bin`)

### Step 5: Verify GCC Installation

```bash
gcc --version
```

Both commands should display version information without errors.

---

## How to Run the Project

### Option 1: Automated Build (Recommended)

1. Place your C program in `input.c` (or edit the sample)
2. Run the batch script:
   ```bash
   run.bat
   ```
3. The compiler executable will be generated and automatically executed
4. Output will display in the terminal

### Option 2: Manual Build and Run

Open Command Prompt in the project directory and execute:

```bash
# Generate lexer from lexer.l
win_flex lexer.l

# Generate parser from parser.y
win_bison -d parser.y

# Compile all source files
gcc lex.yy.c parser.tab.c ast.c symtab.c ir.c opt.c codegen.c main.c -o compiler.exe

# Run the compiler
compiler.exe < input.c
```

### Step-by-Step Explanation

| Command | Description |
|---------|-------------|
| `win_flex lexer.l` | Generates `lex.yy.c` from lexer specification |
| `win_bison -d parser.y` | Generates `parser.tab.c` and `parser.tab.h` from parser specification |
| `gcc ... -o compiler.exe` | Compiles all object files into executable |
| `compiler.exe < input.c` | Runs compiler with input.c as input |

---

## Sample Input

Create or edit `input.c` with the following sample program:

```c
int main() {
    int x;
    int sum;
    x = 0;
    sum = 0;
    
    do {
        sum = sum + x;
        x = x + 1;
    } while (x < 5);
    
    printf(sum);
    
    return 0;
}
```

This program computes the sum of integers from 0 to 4 (which equals 10).

---

## Sample Output

### Phase 1: Lexical Analysis Output
```
Token: KEYWORD, Value: int
Token: IDENTIFIER, Value: main
Token: LPAREN, Value: (
Token: RPAREN, Value: )
Token: LBRACE, Value: {
...
```

### Phase 2-3: Symbol Table (After Semantic Analysis)
```
Symbol Table:
┌────────┬──────┬───────────┐
│ Name   │ Type │ Scope     │
├────────┼──────┼───────────┤
│ main   │ func │ global    │
│ x      │ int  │ local     │
│ sum    │ int  │ local     │
└────────┴──────┴───────────┘
```

### Phase 4: Intermediate Code (Three Address Code)
```
T1 = 0
x = T1
T2 = 0
sum = T2
L1: T3 = sum + x
    sum = T3
    T4 = x + 1
    x = T4
    T5 = x < 5
    if T5 goto L1
    call printf, sum
```

### Phase 5: Optimized Code
```
x = 0
sum = 0
L1: sum = sum + x
    x = x + 1
    if x < 5 goto L1
    call printf, sum
```

### Phase 6: Target Code (Assembly-like)
```
MOV AX, 0
MOV x, AX
MOV AX, 0
MOV sum, AX
L1: MOV AX, sum
    MOV BX, x
    ADD AX, BX
    MOV sum, AX
    MOV AX, x
    ADD AX, 1
    MOV x, AX
    MOV AX, x
    CMP AX, 5
    JL L1
    CALL printf
```

---

## Notes and Limitations

### Educational Purpose
This compiler is designed as an educational tool to demonstrate compiler design principles. It implements a simplified subset of the C language and is not intended for production use.

### Language Limitations
- **Data Types**: Only `int` type is supported
- **Control Flow**: Only `do-while` loops are supported
- **Functions**: Limited function support (mainly `printf`)
- **Operators**: Supports basic arithmetic (+, -, *, /) and comparison operators (<, >, ==, !=)
- **Memory Management**: No dynamic memory allocation (malloc/free)
- **Pointers**: Pointers are not supported

### Optimization Scope
The optimization phase performs basic techniques. Advanced optimizations such as loop unrolling or vectorization are not implemented.

### Known Issues
- Error recovery in the parser is limited
- Error messages may not be detailed
- Debugging output is minimal

---

## Future Enhancements

Potential improvements for this project:
- Support for additional data types (float, char, arrays)
- Nested function definitions
- Pointer operations and dereferencing
- Dynamic memory allocation
- Advanced optimization techniques
- Better error reporting and recovery
- Improved symbol table with scope management
- File I/O operations support

---

## Author and Purpose

| Attribute | Details |
|-----------|---------|
| **Author** | Mainak Sen |
| **Project Name** | Mini Compiler |
| **Purpose** | Academic Learning & Compiler Design Study |
| **Created** | 2026 |
| **Language** | C with Flex and Bison |

---

## References and Resources

- **Flex Documentation**: [GNU Flex Manual](https://westes.github.io/flex/manual/)
- **Bison Documentation**: [GNU Bison Manual](https://www.gnu.org/software/bison/manual/)
- **Compiler Design**: [Compilers: Principles, Techniques, and Tools by Aho, Lam, Sethi, Ullman](https://en.wikipedia.org/wiki/Compilers:_Principles,_Techniques,_and_Tools)
- **win_flex_bison**: [GitHub Repository](https://github.com/lexxmark/winflexbison)

---

## License

This project is provided for educational purposes. Feel free to use, modify, and distribute as per your requirements.

---

**Last Updated**: April 24, 2026

For questions or suggestions, please open an issue or contact the author.

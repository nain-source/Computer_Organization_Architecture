# Lab 04 — RISC-V & Venus

## Objectives
- Use Venus to execute RISC-V assembly and monitor registers.
- Perform arithmetic and logical operations.
- Access memory using load/store instructions.
- Work with arrays and loops.

## Tasks
1. Arithmetic: `C=A+B`, `D=A-B`, `E=A*B`, `F=A²`; separate instruction fields and give machine-language representation in decimal.
2. Convert `m=(a-c)+(d+e)*f` to RISC-V.
3. Perform AND, OR and XOR on `0xFFF` and `0xF0F`.
4. Debug/verify an array-sum program.
5. Initialize a table of two and load its values into different registers using `lw`.

## Concepts covered
- This lab uses 32-bit RISC-V registers `x0`–`x31`; 32 bits = one word.
- Arithmetic instructions operate on registers; memory is accessed with load/store instructions.
- `.data` contains data; `.text` contains instructions.
- `.globl main` makes `main` globally visible.
- `li` loads an immediate value; `la` loads an address; `lw` loads a word from memory; `sw` stores a word.
- RISC-V register names used include `t0`–`t6`, `s0`–`s11`, and `a0`–`a7`.

## Files
- `task1.s` — Task 1 arithmetic instructions
- `task1_part5.txt` — Task 1 Part 5 fields and machine-language representations
- `task2.s` — Task 2
- `task3.s` — Task 3
- `task4.s` — Task 4 array sum
- `task5.s` — Task 5 memory loads

All task files are intended to be tested independently in the Venus RISC-V simulator.

## Running the Assembly Files
The `.s` files are RISC-V assembly source files. They are not standalone executable programs.

To execute them, users need a RISC-V assembler/simulator such as **Venus**, which is the simulator used for this lab. GitHub can display the source code, but execution requires a compatible RISC-V environment.

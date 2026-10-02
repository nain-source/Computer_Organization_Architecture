# Lab 06 — RISC-V Procedures & Venus

## Objective

To use the Venus simulator to execute RISC-V assembly language programs, monitor register contents, work with procedures, use the stack, and implement nested and recursive procedures.

## Tasks

1. Fix the given procedure so that the correct value is displayed after preserving the required register.
2. Run the given stack push/pop example on the Venus simulator and observe the register and stack contents.
3. Implement the given C code for `EqSolver(a,b)` in RISC-V assembly.
4. Write two procedures, `AreaFinder` and `PerimeterFinder`, to calculate the area and perimeter of a square.
5. Implement the given C code for `EqSolver(x)` to calculate `x^3 + 5x^2 + 6x`.
6. Implement the given conditional C code using procedures `F1`, `F2`, and `F3`.
7. Implement the given conditional C code using `func1`, `func2`, and `func3`.
8. Implement Fibonacci in RISC-V both without recursion and with recursion.

## Concepts Covered

- RISC-V procedures and procedure calls
- `jal` and `jalr`
- Argument and return-value registers
- Return address register `ra`
- Stack pointer `sp`
- Stack push and pop using `sw` and `lw`
- Register preservation
- Conditional branching
- Loops
- Nested procedure execution
- Recursive procedures
- Fibonacci sequence
- Venus simulator

## Files

- `task1.s` — Procedure call with register preservation
- `task2.s` — Stack push/pop example
- `task3.s` — `EqSolver(a,b)` procedure
- `task4.s` — Square area and perimeter procedures
- `task5.s` — `EqSolver(x)` polynomial procedure
- `task6.s` — Conditional procedure calls using `F1`, `F2`, and `F3`
- `task7.s` — Conditional procedure calls using `func1`, `func2`, and `func3`
- `task8_without_recursion.s` — Iterative Fibonacci procedure
- `task8_with_recursion.s` — Recursive Fibonacci procedure

## Verification

The programs are intended to be executed independently in the Venus RISC-V simulator. The input values currently present in the source files can be changed to test different cases.

For the supplied inputs, the main calculated results are:

- Task 1: `3503`
- Task 3: `-11`
- Task 4: perimeter `20`, area `25`
- Task 5: `280`
- Task 6: `17`
- Task 7: `512`
- Task 8 without recursion: `5`
- Task 8 with recursion: `21`

## Running the Assembly Files

The `.s` files are RISC-V assembly source files and are intended to be run using the **Venus Simulator**. GitHub can display the source code, but execution requires a compatible RISC-V environment.

# Lab 05 - RISC-V Control Instructions & Venus

## Objective

To use the Venus simulator to execute RISC-V assembly programs and understand conditional branches, unconditional jumps, loops, nested loops, and load/store operations.

## Tasks

1. Identify the actual instructions and pseudo-instructions from the RISC-V control-instruction tables and explain how they are distinguished.
2. Write and simulate a short code snippet using `beq` and `j` to understand conditional branching and unconditional jumping.
3. Run and explain two RISC-V code examples using `beq`, `add`, `sub`, and `j`.
4. Convert the given C `if-else` statement into RISC-V assembly for `a = 5`, `b = 10`, `d = 4`, and `e = 3`.
5. Shift the number `2` to the left twice using the RISC-V `slli` instruction.
6. Convert the given `for` loop into RISC-V assembly and count from `i = 1` through `5`.
7. Convert the given `while` loop into RISC-V assembly and store `i + 5` into `num[i]` for `i < 5`.
8. Convert the given nested loops into RISC-V assembly and update `counter = x + y`.

## Concepts Covered

- RISC-V control instructions
- Conditional branches
- Unconditional jumps
- Actual instructions and pseudo-instructions
- `beq`, `bge`, `bgt`, `j`
- `slli`
- Load/store instructions
- Array addressing
- `for` loops
- `while` loops
- Nested loops
- Venus Simulator

## Files

- `task2.s` — Task 2: `beq` and `j`
- `task3_code1.s` — Task 3 Code 1
- `task3_code2.s` — Task 3 Code 2
- `task4.s` — Task 4: C `if-else` conversion
- `task5.s` — Task 5: left shift
- `task6.s` — Task 6: loop and counter
- `task7.s` — Task 7: array and `while` loop
- `task8.s` — Task 8: nested loops

Task 1 is theoretical and does not require a separate assembly file.

## Task 1 Instruction Classification

### Actual Instructions

- `beq`
- `blt`
- `bge`
- `bne`
- `jal`
- `jalr`

These instructions are directly supported by the RISC-V ISA and have their own instruction encodings.

### Pseudo-Instructions

- `ble`
- `bgt`
- `j`

These are assembler shortcuts that are translated into actual RISC-V instructions.

Examples:

- `ble t0, t1, target` → `bge t1, t0, target`
- `bgt t0, t1, target` → `blt t1, t0, target`
- `j target` → `jal x0, target`

## Verification

The assembly programs are intended to be assembled and simulated independently using the Venus RISC-V simulator. Register values, branch behavior, loop execution, and memory contents can be observed in the simulator.

## Running the Assembly Files

The `.s` files are RISC-V assembly source files. They are not standalone executable programs.

To execute them, use the **Venus RISC-V simulator**. Open a file in Venus, assemble it, and then run or step through the instructions to observe register and memory changes.

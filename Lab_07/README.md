# Lab 07 — Arithmetic Logic Unit (ALU)

## Objective

Design and simulate ALUs at multiple levels of abstraction, from a 1-bit ALU to a parameterized ALU and a 32-bit RV32-style ALU. The lab also includes a Logisim circuit for the 32-bit ALU.

## Tasks

1. Implement a 1-bit ALU using gate-level, behavioral, and dataflow modeling. Support AND, OR, and ADD/SUB selection, with carry input and carry output.
2. Combine 1-bit ALU stages to implement a 4-bit ALU supporting arithmetic, logical, and set-less-than operations with status flags.
3. Implement a reusable parameterized ALU supporting addition, subtraction, AND, OR, NOT, and XOR.
4. Implement a 32-bit ALU with the specified arithmetic, logical, comparison, and shift operations.
5. Simulate the 32-bit ALU circuit in Logisim.

## Files

- `Task_01_1bit_ALU_gatelevel.v` — 1-bit ALU, gate-level implementation
- `Task_01_1bit_ALU_behavioral.v` — 1-bit ALU, behavioral implementation
- `Task_01_1bit_ALU_dataflow.v` — 1-bit ALU, dataflow implementation
- `Task_02_4bit_ALU.v` — cascaded 4-bit ALU
- `Task_03_Parameterized_ALU.v` — parameterized-width ALU
- `Task_04_32bit_ALU.v` — 32-bit ALU
- `Logisim_32bit_ALU.circ` — Logisim circuit for the 32-bit ALU
- `Lab_07.mpf` — ModelSim project file

## Concepts Covered

- ALU operation selection
- Gate-level, dataflow, and behavioral modeling
- Addition and subtraction using two's complement
- Cascaded ALU stages and set-less-than
- Carry, sign, zero, and overflow flags
- Parameterized Verilog modules
- Logical and arithmetic shifts

## Running and Verification

Open the relevant `.v` file in ModelSim, compile it, and simulate the appropriate top-level module/testbench. Open `Logisim_32bit_ALU.circ` in Logisim to inspect and simulate the circuit. The source files are separate designs; compile only the files needed for the selected task to avoid duplicate module definitions.

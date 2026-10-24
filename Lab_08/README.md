# Lab 08 — Program Counter and Instruction Memory

## Objective

Implement program counters and instruction memories, then integrate a 32-bit RV32-style program counter with a 32-bit instruction memory. The lab includes a Logisim implementation.

## Tasks

1. Implement a program counter with a 4-bit address and verify its behavior using simulation.
2. Automatically increment the program counter and fetch instructions sequentially; return a default instruction for invalid memory addresses.
3. Implement a 32-bit program counter that resets to zero and increments by four bytes on each rising clock edge.
4. Integrate the 32-bit program counter with 32-bit instruction memory and verify sequential instruction fetches.
5. Simulate the 32-bit program counter and instruction memory in Logisim.

## Files

- `Task_01_Program_Counter.v` — basic program counter
- `Task_02_Program_Counter_Instruction_Memory.v` — counter and instruction-memory simulation
- `Task_03_RV32_Program_Counter.v` — 32-bit PC implementation
- `Task_04_RV32_PC_Instruction_Memory.v` — integrated 32-bit PC and instruction memory
- `Logisim_32bit_PC_Instruction_Memory.circ` — Logisim circuit for the integrated design
- `PC_IM_Simulation.mpf` — ModelSim project file

## Concepts Covered

- Clocked sequential logic
- Reset behavior
- Program-counter increment and word alignment
- Instruction-memory addressing
- Sequential instruction fetch
- Verilog simulation and Logisim circuit modeling

## Running and Verification

Open the required `.v` file in ModelSim, compile it, and simulate its top-level testbench/module. Inspect the PC and instruction outputs across clock edges. Open `Logisim_32bit_PC_Instruction_Memory.circ` in Logisim to inspect and simulate the circuit. Compile only the file required for the task because files may reuse module names.

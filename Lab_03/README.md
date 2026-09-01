# Lab 03 - Behavioral Modeling

## Objective

To implement and simulate combinational circuits using Verilog behavioral-level modeling.

## Tasks

1. Implement a 4-bit Adder/Subtractor. The circuit performs addition or subtraction according to the control signal.
2. Implement a 2-to-1 MUX with the following operations:
   - `Select = 0` → `Y = A & B`
   - `Select = 1` → `Y = A | B`
3. Implement a 2-bit Comparator that compares two 2-bit binary numbers and produces:
   - Equality
   - Greater than
   - Less than
4. Simulate all designs using Verilog testbenches.

## Concepts Covered

- Behavioral modeling
- `always` block
- `always @*`
- `if-else`
- Procedural assignments
- `reg` and `wire`
- Combinational logic
- Testbenches
- ModelSim

## Files

- `Adder_Subtractor.v`
- `2to1_MUX.v`
- `Comparator.v`

## Verification

The Adder/Subtractor, MUX, and 2-bit Comparator are verified using testbenches in ModelSim.

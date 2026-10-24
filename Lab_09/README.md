# Lab 09 — Register File Design

## Objective

Build and simulate a small 4×4 register file and a 32×32, 32-bit register file suitable for an RV32-style datapath. The designs demonstrate decoded writes and combinational reads, with a Logisim circuit included.

## Tasks

1. Implement a 4-register file with 4-bit-wide registers, a 2-to-4 write decoder, and two read ports.
2. Simulate writes of 6 to register 1, 3 to register 2, and 13 to register 3, then read registers 1 and 2 through the two output ports.
3. Implement a 32×32 register file with two asynchronous read ports, a synchronous write port, and reset support. Register zero is tied to zero.
4. Simulate a register-file circuit in Logisim.

## Files

- `Task_01_4x4_Register_File.v` — 4×4 register-file design and simulation testbench
- `Task_03_32x32_Register_File.v` — 32×32, 32-bit register-file design
- `Logisim_32bit_Register_File.circ` — Logisim register-file circuit
- `Register_files.mpf` — ModelSim project file

## Concepts Covered

- Register storage and clocked writes
- Write decoding
- Multiplexer-based asynchronous reads
- Dual read ports and a single write port
- Reset behavior
- RV32 register-file organization and constant-zero register

## Running and Verification

Open the relevant `.v` file in ModelSim, compile it, and simulate the appropriate testbench/top-level module. The 4×4 testbench applies the specified write/read sequence. For the 32×32 design, verify asynchronous read outputs and clock-edge-controlled writes, including reset and writes to register address zero. Open `Logisim_32bit_Register_File.circ` in Logisim to inspect and simulate the circuit. Compile only the file required for the selected task because some helper modules are defined locally in each source file.

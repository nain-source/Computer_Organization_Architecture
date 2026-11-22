# Lab 11 — RISC-V Data Memory Design

## Objective

Design and simulate a 1024 × 32-bit Data Memory module for a RISC-V RV32I processor using Verilog. The memory supports clock-controlled writing and asynchronous reading, with all memory locations initialized to zero.

## Tasks

1. Implement a memory array containing 1024 words, each 32 bits wide.
2. Initialize all memory locations to zero.
3. Write data on the rising edge of the clock when Write Enable is active.
4. Read the selected memory word asynchronously.
5. Develop a self-checking testbench to verify initialization, writing, reading, write protection, boundary addresses, overwriting, and all memory locations.

## Files

- `DataMemory.v` — Data Memory module and self-checking testbench.
- `DataMemory.mpf` — ModelSim project file.

## Tools

- ModelSim

## Memory Organization

| Property | Description |
|---|---|
| Memory size | 1024 words |
| Word width | 32 bits |
| Address width | 10 bits |
| Total capacity | 4096 bytes (4 KB) |
| Write operation | Rising edge of the clock |
| Read operation | Asynchronous |
| Initialization | All locations set to zero |

## Input and Output Ports

| Port | Direction | Width | Description |
|---|---|---:|---|
| `i_clk` | Input | 1 bit | Clock signal |
| `i_we` | Input | 1 bit | Write enable |
| `i_data` | Input | 32 bits | Data to be stored |
| `i_addr` | Input | 10 bits | Memory word address |
| `o_data` | Output | 32 bits | Data read from the selected address |

## Running and Testing

The generated `work/` folder is not included. Before compiling on a new computer, run `vlib work` in the ModelSim Transcript while the current directory is `Lab_11`. If `work` already exists, skip this command.

```tcl
vlib work
```

If the `work` library already exists, do not run `vlib work` again. If ModelSim reports that the library already exists, continue with compilation.

## Test Cases

1. Check that all 1024 memory locations start at zero.
2. Write a value to an address and read it back.
3. Confirm that memory is not changed when Write Enable is disabled.
4. Test the first address (0) and last address (1023).
5. Overwrite an existing memory location.
6. Write different values to all 1024 addresses and verify them.
7. Perform an overwrite test using hexadecimal values.

## Addressing Note

The module uses a 10-bit word address, not a byte address. As described in the lab manual, when connecting it to a RISC-V processor, bits `[11:2]` of the ALU byte address are used as `i_addr`. Byte and half-word access, sign extension, zero extension, and alignment checking are not implemented in this lab.

## Concepts Covered

Data Memory organization, memory arrays, clock-edge-controlled writes, asynchronous reads, write enable, memory initialization, and self-checking Verilog testbenches.

## Scope

This lab implements the word-wide Data Memory component. It does not implement byte or half-word read/write operations or integration with a complete processor.

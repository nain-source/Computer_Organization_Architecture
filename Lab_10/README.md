# Lab 10 — Single-Cycle Datapath

## Objective

Design and test a 32-bit single-cycle datapath using the Program Counter, Instruction Memory, Register File, Immediate Generator, ALU, branch comparator, and multiplexers. Control signals are supplied manually; an instruction decoder is not included.

## Tasks

1. Connect the PC, PC+4 adder, PC multiplexer, and instruction memory.
2. Connect instruction fields to the register file and immediate generator.
3. Select ALU operands and perform arithmetic/logical operations.
4. Generate branch comparison outputs and select the writeback value.
5. Test the complete datapath in Logisim and simulate the Verilog design.

## Files

- `Datapath.circ` — Main Logisim datapath and its subcircuits.
- `DataPath.v` — Verilog datapath modules and testbench.
- `program.txt` — Six machine instructions for the Logisim ROM.
- `Lab_10.mpf` — ModelSim project.

## Tools

- Logisim 2.7.1
- ModelSim

## Running and Testing in Logisim

1. Extract the repository and keep the `Lab_10` folder structure intact.
2. Open Logisim 2.7.1 and open `Lab_10/Datapath.circ` using **File → Open**.
3. Select the `main` circuit. Use the Poke tool to set control pins and the Clock tool to apply clock pulses.
4. Load the program into ROM: right-click the instruction ROM, select **Edit Contents**, then use the ROM editor's **File → Open** option and select `Lab_10/program.txt`.
5. Confirm the six instruction words are loaded. The PC is a byte address, so PC values 0, 4, 8, 12, 16, and 20 select ROM words 0–5.
6. Reset the circuit. Set the controls for the current instruction before each active clock edge. Check the combinational outputs first, then apply one clock pulse to write the register and update the PC.

`program.txt` is in Logisim raw format. Its first line must remain `v2.0 raw`.

## ROM Program

| ROM word | PC | Instruction | Machine code |
|---:|---:|---|---|
| 0 | 0 | `ADDI x5, x0, 7` | `00700293` |
| 1 | 4 | `ADDI x6, x0, 5` | `00500313` |
| 2 | 8 | `ADD x7, x5, x6` | `006283B3` |
| 3 | 12 | `SUB x8, x5, x6` | `40628433` |
| 4 | 16 | `BEQ x7, x0, +8` | `00038463` |
| 5 | 20 | `ADD x9, x7, x8` | `008384B3` |

## Control Signals

| Signal | Function / setting |
|---|---|
| `PCSel` | 0 = PC+4, 1 = branch target. Use 0 for this test; BEQ is not taken. |
| `RegWEn` / `Write_enable` | 1 = write register, 0 = disable write. |
| `ASel` | 0 = DataA, 1 = PC. |
| `BSel` | 0 = DataB, 1 = immediate. |
| `ImmSel` | `00` = I-type, `01` = S-type, `10` = B-type, `11` = J-type. |
| `WBSel` | `01` = ALU result. Use `01` for all register-writing instructions in this test. |

### Manual Control Table

| Step | Instruction | PCSel | RegWEn | ASel | BSel | ImmSel | ALU operation | WBSel |
|---:|---|---:|---:|---:|---:|---|---|---|
| 1 | `ADDI x5, x0, 7` | 0 | 1 | 0 | 1 | `00` | ADD | `01` |
| 2 | `ADDI x6, x0, 5` | 0 | 1 | 0 | 1 | `00` | ADD | `01` |
| 3 | `ADD x7, x5, x6` | 0 | 1 | 0 | 0 | — | ADD | `01` |
| 4 | `SUB x8, x5, x6` | 0 | 1 | 0 | 0 | — | SUB | `01` |
| 5 | `BEQ x7, x0, +8` | 0 | 0 | 0 | 0 | `10` | — | — |
| 6 | `ADD x9, x7, x8` | 0 | 1 | 0 | 0 | — | ADD | `01` |

For unused controls, keep a defined value; do not leave pins floating. The branch comparator checks `BrEq` separately from the ALU. For step 5, `BrEq=0`, so the branch is not taken and PC advances to 20.

## ALU Selection Encodings

The Logisim 32-bit ALU uses a 4-bit `Select_line` for its 10-input result MUX:

| `Select_line` | Operation |
|---|---|
| `0000` | ADD |
| `0001` | SUB |
| `0010` | AND |
| `0011` | OR |
| `0100` | XOR |
| `0101` | Signed less-than |
| `0110` | Unsigned less-than |
| `0111` | Shift left |
| `1000` | Logical shift right |
| `1001` | Arithmetic shift right |

The Verilog `ALU_32bit` in `DataPath.v` has a separate 3-bit `ALUSel`:

| `ALUSel` | Operation |
|---|---|
| `000` | ADD |
| `001` | SUB |
| `010` | AND |
| `011` | OR |
| `100` | XOR |
| `101` | Signed SLT |

Do not use the 3-bit Verilog values as the 4-bit Logisim selector values.

## Expected Results

| Register | Decimal value |
|---|---:|
| x0 | 0 |
| x5 | 7 |
| x6 | 5 |
| x7 | 12 |
| x8 | 2 |
| x9 | 14 |

After the sixth instruction, PC should be 24. Check the register values after each clock pulse. If a signal becomes undefined, check that control inputs are defined, bus widths match, and subcircuit pins are connected.

## Running the Verilog Testbench

1. Open ModelSim and create/open the project using `Lab_10.mpf`, or add `DataPath.v` to a project.
2. Compile `DataPath.v` and set `tb_datapath_top` as the simulation top level.
3. Run the simulation (for example, `run 100 ns`) and inspect `pc`, `inst`, `alu_result`, `wb`, `BrEq`, and `BrLT` in the waveform.

## Concepts Covered

Single-cycle datapath, PC and instruction memory, register-file read/write, immediate generation, ALU operations, branch comparison, multiplexers, and manual control-signal testing.

## Scope

The lab focuses on the datapath. An instruction decoder/control unit, pipeline registers, hazard detection, forwarding, interrupts, caches, privileged architecture, and load/store data-memory execution are outside the required scope.

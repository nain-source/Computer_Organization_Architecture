# Computer Organization and Architecture Labs

This repository contains lab implementations using Verilog, ModelSim, Logisim, and RISC-V assembly in Venus. Each lab is organized in its own folder with source files and a README describing the tasks, concepts, and tools.

## Labs

| Lab | Topic | Status |
|---|---|---|
| Lab 01 | Basic Logic Gates, XOR and 1's Complement | Completed |
| Lab 02 | Combinational Circuits | Completed |
| Lab 03 | Behavioral Modeling of Combinational Circuits | Completed |
| Lab 04 | RISC-V Assembly Fundamentals | Completed |
| Lab 05 | RISC-V Control Instructions and Loops | Completed |
| Lab 06 | RISC-V Procedures and Recursion | Completed |
| Lab 07 | Arithmetic Logic Unit (ALU) Design | Completed |
| Lab 08 | Program Counter and Instruction Memory | Completed |
| Lab 09 | Register File Design | Completed |
| Lab 10 | Single-Cycle Datapath Design | Completed |
| Lab 11 | To be added | Pending |
| Lab 12 | To be added | Pending |
| Lab 13 | To be added | Pending |

## Tools

- ModelSim for Verilog compilation and simulation
- Logisim for digital circuit design and simulation
- Venus for RISC-V assembly execution

Open the README inside a lab folder for its task list, source-file map, and instructions for running the work. Lab 10 includes additional steps for loading the instruction ROM and manually applying the datapath control signals.

## ModelSim Setup

ModelSim's generated `work/` library is not committed. In a lab folder, run `vlib work` in the Transcript before compiling if the library does not already exist. See each relevant lab README for details.

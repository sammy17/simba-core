# RISC-V

## Introduction to RISC-V

RISC-V (pronounced "risk-five") is an open instruction set architecture (ISA) based on established reduced instruction set computing (RISC) principles.

In contrast to most ISAs, the RISC-V ISA can be freely used for any purpose, permitting anyone to design, manufacture and sell RISC-V chips and software. While not the first open ISA, it is significant because it is designed to be useful in modern computerized devices such as warehouse-scale cloud computers, high-end mobile phones and the smallest embedded systems. Such uses demand that the designers consider both performance and power efficiency. The instruction set also has a substantial body of supporting software, which fixes a usual weakness of new instruction sets.

The project began in 2010 at the University of California, Berkeley, but many contributors are volunteers and industry workers outside the university.

The RISC-V ISA has been designed with small, fast, and low-power real-world implementations in mind,but without over-architecting for a particular microarchitecture style.(https://en.wikipedia.org/wiki/RISC-V).
<br />


## Features of the implementation

 * Fully written in Verilog
 * Support 32 Bit long Words
 * Support RISC-V Integer Specification "RV32IM" 
 * Implemented as a 12 Stage Pipelined Architecture
 * Support both Instruction and Data Cache
 * Address most of the common hazards found in the Pipelined Architectures
 * The Pipeleine pass all the tests and successfully synthesis at 100 MHz on Zybo
 * SoC for the RISC-V Core
# Autonomous-Digital-System-Verilog-
A Verilog-based autonomous digital system that executes a program of three hexadecimal instructions using a CPU-style pipeline with Program Counter, instruction memory, decoder, ALU, and accumulator.

Features:
Program Counter (PC): Steps through instruction memory automatically
Instruction Decoder: Splits 8-bit instruction into Command (2 bits) and Value (6 bits)
ALU & Accumulator: Performs operations and updates results every clock cycle

Instruction Set:
00 → Load (LD)
01 → Add (ADD)
10 → Bitwise AND (AND)
11 → Bitwise OR (OR)

This project demonstrates hands-on experience with instruction execution, control flow, and data persistence in digital systems.

Technologies: Verilog, Digital Design, CPU Architecture

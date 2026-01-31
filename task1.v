
//order of working
//PC --> Memory --> decoder --> ALU --> Accumulator

module autonomous_digital_system(
    input clock,
    input reset,
    output reg [7:0] accumulator
);
//how the module works
//1. everything is reset at start-up, time = 0, PC points to NEXT memory address 0, accumulator holds 0
//2. the CPU or CU checks the PC, goes to the memory address, fetches the instruction, sends it to decoder unit
//   the decoder unit splits the instruction into command and value.
//3. ALU checks the command, performs the operation on value.
//4. the value stays in the ALU until the end of the clock cycle, that is when the next posedge clock is hit.
//5. when next posedge is hit, accumulator value is updated and PC points to the NEXT memory address 1.
    parameter MEM_DEPTH = 3;
    wire [1:0] Command;
    wire [5:0] Value;
    reg [7:0] ProgramCounter;
    wire [7:0] instructionFromMemory;
    wire [7:0] ALUToAccumulator;

    ALU ALU1(
        .Command(Command),
        .Value(Value),
        .AccumulatorToALU(accumulator),
        .ToAccumulator(ALUToAccumulator)
    );

    memory memory1(
        .addressFromPC(ProgramCounter),
        .instruction(instructionFromMemory)
    );

    instruction_decoder instruction_decoder1(
        .instruction(instructionFromMemory),
        .CommandFromDecoder(Command),
        .ValueFromDecoder(Value)
    );

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            accumulator <= 8'b0;
            ProgramCounter <= 0;
        end else begin
            accumulator <= ALUToAccumulator;
            if (ProgramCounter < MEM_DEPTH-1)
                ProgramCounter <= ProgramCounter + 1;
        end
    end
endmodule


module memory(
    input [7:0] addressFromPC,
    output reg [7:0] instruction
);
    reg [7:0] memoryCells [2:0];
    initial begin
    memoryCells[0] = 8'h03;
    memoryCells[1] = 8'h47;
    memoryCells[2] = 8'h84;
    end
    always @(*) begin
        instruction = memoryCells[addressFromPC];
    end

endmodule


module instruction_decoder(
    input [7:0] instruction,
    output reg [1:0] CommandFromDecoder,
    output reg [5:0] ValueFromDecoder
);
    always @(*) begin
        CommandFromDecoder = instruction[7:6];
        ValueFromDecoder = instruction[5:0];
    end

endmodule


module ALU(
    input [1:0] Command,
    input [5:0] Value,
    input [7:0] AccumulatorToALU,
    output reg [7:0] ToAccumulator
);

    always @(*) begin
        case (Command)
            2'b00: ToAccumulator = Value;
            2'b01: ToAccumulator = AccumulatorToALU + Value;
            2'b10: ToAccumulator = AccumulatorToALU & Value;
            2'b11: ToAccumulator = AccumulatorToALU | Value;
            default: ToAccumulator = AccumulatorToALU; 
        endcase
    end

endmodule
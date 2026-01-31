`timescale 1ns / 1ps
module autonomous_digital_systemTB;
    reg clock;
    reg reset;
    wire [7:0] accumulator;
    autonomous_digital_system dut (
        .clock(clock),
        .reset(reset),
        .accumulator(accumulator)
    );
        initial begin
            clock = 0;
            forever #5 clock = ~clock;
        end
            initial begin
                $dumpfile("task1.vcd");
                $dumpvars(0, autonomous_digital_systemTB);
            end
                    initial begin
                        $monitor("Time=%t | ProgramCounter=%d Instruction=%b| Command=%b | Value =%b | Accumulator=%d |Accumulator=%b", 
                        $time, dut.ProgramCounter, dut.instructionFromMemory, dut.Command, dut.Value , accumulator,accumulator);
                        reset = 1;
                        #10 reset = 0;
                        #30
                        $display("Final Accumulator Value: %d", accumulator);    
                        $finish;
                    end
endmodule
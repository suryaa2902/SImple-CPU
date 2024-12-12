`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 04:19:37 PM
// Design Name: 
// Module Name: cpu_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module cpu_tb;

    // Instantiate the CPU module
    reg clk;
    reg reset;
    reg [7:0] data_in;
    wire [7:0] accumulator_out;
    wire [7:0] program_counter_out;

    cpu dut (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .accumulator_out(accumulator_out),
        .program_counter_out(program_counter_out)
    );

    // Clock generation
    always #5 clk = ~clk; 

    // Testbench logic
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        data_in = 8'h00; 

        // Apply reset
        #10 reset = 0;

        // Load initial program into memory (example)
        // Assuming memory is initialized in the CPU module
        // Here, we're loading a simple program:
        // - Load immediate value 5 into accumulator
        // - Add the value stored at memory location 10 to the accumulator
        // - Store the result back to memory location 20

        // Load immediate 5 into accumulator
        dut.memory[0] = 8'h05; // Load instruction
        dut.memory[1] = 8'h00; // Address for immediate load

        // Add value at memory location 10
        dut.memory[2] = 8'h03; // Add instruction
        dut.memory[3] = 8'h0A; // Address to add

        // Store result to memory location 20
        dut.memory[4] = 8'h04; // Store instruction
        dut.memory[5] = 8'h14; // Address to store

        // Halt the program (optional)
        dut.memory[6] = 8'h00; // No-op instruction

        // Monitor signals and check results
        monitor;

        // End simulation
        #200 $finish; 
    end

    // Monitor task
    task monitor;
        begin
            $monitor("Time: %t, PC: %h, Acc: %h, Mem[0]: %h, Mem[10]: %h, Mem[20]: %h", 
                     $time, program_counter_out, accumulator_out, 
                     dut.memory[0], dut.memory[10], dut.memory[20]);
        end
    endtask

endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 04:13:43 PM
// Design Name: 
// Module Name: cpu
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


// Simple 8-Bit CPU Architecture
module cpu(
    input wire clk,              // Clock signal
    input wire reset,             // Reset signal
    input wire [7:0] data_in,      // Input data bus
    output wire [7:0] accumulator_out, // Output: Accumulator value
    output wire [7:0] program_counter_out // Output: Program Counter value
);
    // Registers
    reg [7:0] accumulator;       // Accumulator register (main working register)
    reg [7:0] program_counter;  // Program Counter
    reg [7:0] instruction_register; // Instruction register
    reg [7:0] memory [0:255];   // Simple memory (256 bytes)

    // Control signals
    reg [2:0] current_state; // State machine states

    // ALU operation parameters
    parameter ADD = 3'b000;
    parameter SUB = 3'b001;
    parameter LOAD = 3'b010;
    parameter STORE = 3'b011;

    // ALU Module
    reg [7:0] alu_result;
    always @(*) begin
        case(instruction_register[7:5]) // Top 3 bits define operation
            ADD: alu_result = accumulator + memory[instruction_register[4:0]];
            SUB: alu_result = accumulator - memory[instruction_register[4:0]];
            default: alu_result = accumulator; 
        endcase
    end

    // CPU State Machine and Control Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset all registers and state
            accumulator <= 8'b0;
            program_counter <= 8'b0;
            instruction_register <= 8'b0;
            current_state <= 3'b000;
        end else begin
            // State machine for instruction fetch and execute
            case(current_state)
                3'b000: begin // Instruction Fetch
                    instruction_register <= memory[program_counter];
                    program_counter <= program_counter + 1;
                    current_state <= 3'b001;
                end

                3'b001: begin // Instruction Decode and Execute
                    case(instruction_register[7:5])
                        LOAD: begin
                            accumulator <= memory[instruction_register[4:0]];
                        end

                        STORE: begin
                            memory[instruction_register[4:0]] <= accumulator;
                        end

                        ADD: begin
                            accumulator <= alu_result;
                        end

                        SUB: begin
                            accumulator <= alu_result;
                        end
                    endcase
                    current_state <= 3'b000; // Return to fetch state
                end
            endcase
        end
    end

    // Outputs
    assign accumulator_out = accumulator;
    assign program_counter_out = program_counter;
endmodule

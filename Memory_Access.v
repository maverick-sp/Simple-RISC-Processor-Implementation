`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2024 19:06:59
// Design Name: 
// Module Name: Memory_Access
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


module Memory_Access(
    input clk,
    input [31:0] op2, aluR,
    input isLd, isSt,
    output reg [31:0] ldResult
);
    
    // Defining Memory
    reg [7:0] memory [0:4095];
   
    // Handle memory access for load and store instructions
    always @(negedge clk) begin
        if (isSt) begin
            // Store op2 in the memory location specified by aluR
            {memory[aluR+3], memory[aluR+2], memory[aluR+1], memory[aluR]} <= op2;
        end
    end

    // Handle load instruction outside of the always block
    always @(*) begin
        if (isLd) begin
            // Load the value from the memory location specified by aluR into ldResult
            ldResult <= {memory[aluR+3], memory[aluR+2], memory[aluR+1], memory[aluR]};
        end
    end
endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2024 10:25:40
// Design Name: 
// Module Name: Instruction_Fetch
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
module Instruction_Fetch (
    input [31:0] PC,
    input Clk,
    input Reset,
    input IsBranchTaken,
    input [31:0] BranchPC,
    output reg [31:0] pc_current,
    output [31:0] Instruction
);

reg [31:0] instruction_memory [0:255]; // Assuming 256 words of instruction memory for simplicity

// Initialize instruction memory for simulation (can be replaced with actual memory initialization)
initial begin
    // Example initialization 
    instruction_memory[0]=0;
    instruction_memory[1]  = 32'h4c400002; // mov R1,2
    instruction_memory[2]  = 32'h4c800006; // mov R2,6
    instruction_memory[3]  = 32'h0C480003; //  sub R1,R2,3
    
    // similarly instruction_memory can be initialized as per our codes

end

// Fetch instruction from instruction memory
assign Instruction = instruction_memory[pc_current]; 

// Always block to update PC on negative edge of clock or reset
always @(negedge Clk ) begin
    if (Reset) begin
        pc_current <= 32'b0; // Reset PC to 0
    end else begin
        if (IsBranchTaken)
            pc_current <= BranchPC;
        else
            pc_current <= pc_current + 1;  // Actual pc_current must be pc_current+4 (for the sake of simplicity I have taken it to be 1)
    end
end

endmodule




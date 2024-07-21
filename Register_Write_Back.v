`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2024 19:17:31
// Design Name: 
// Module Name: Register_Write_Back
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

module Register_Write_Back(
    input clk, reset,
    input [31:0] pc,
    input [3:0] rd, ra,
    input [31:0] instr,
    input [31:0] aluResult, ldResult,
    input isLd, isWb, isCall,
    output  [31:0] write_data,
    output [3:0] write_addr
);
    
  
    assign write_data = isCall ? (pc + 32'd4) : (isLd ? ldResult : aluResult);
    assign write_addr = isCall ? ra : rd;
    
  
endmodule

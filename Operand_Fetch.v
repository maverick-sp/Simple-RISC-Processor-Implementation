`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2024 15:29:35
// Design Name: 
// Module Name: Operand_Fetch
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

module Operand_Fetch(
    input clk, reset,
    input isRet, isSt,
    input [31:0] pc,
    input [31:0] instr,
    output [31:0] immx, branch_Target,
    output [31:0] operand1, operand2,
    output [5:0] opcode_Ibit,
    // Register File Interface
    output [3:0] reg_addr1, reg_addr2,
    input [31:0] reg_data1, reg_data2
);

    reg [31:0] immx_next;

    // Immediate Calculation 
    always @(*) begin
        if (instr[16] == 1'b1) immx_next = {16'b0, instr[15:0]};
        else if (instr[17] == 1'b1) immx_next = {instr[15:0], 16'b0};
        else immx_next = {{16{instr[15]}}, instr[15:0]};
    end
    assign immx = immx_next;
      
    // Computing Branch Target
    reg [31:0] temp;
    reg [31:0] target;
    
    always @(*) begin
        temp = {{5{instr[26]}}, instr[26:0]}; // Sign Extension of Offset
        target = pc + (temp << 2);
    end
    assign branch_Target = target;
    
    // Operand Fetch (Reg File Read)
    reg [31:0] op1, op2;

    assign reg_addr1 = instr[21:18];
    assign reg_addr2 = isSt ? instr[25:22] : instr[17:14];

    always @(*) begin
        if (isRet) begin
            op1 = reg_data1;
        end else begin
            op1 = reg_data1;
        end
        if (isSt) begin
            op2 = reg_data2;
        end else begin
            op2 = reg_data2;
        end
    end
    assign operand1 = op1;
    assign operand2 = op2;

    // opcode and Ibit to the Control unit
    assign opcode_Ibit = instr[31:26];
endmodule

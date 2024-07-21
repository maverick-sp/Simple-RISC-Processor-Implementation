`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2024 16:38:19
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] A, B,
    input isAdd, isSub, isComp, isMul, isDiv, isMod, isLSL, isLSR, isASR, isOR, isAND, isNOT, isMov,
    output reg flags_eq, flags_gt,
    output [31:0] aluResult
);

    reg [31:0] aluRes;
    
    always @(*) begin
        aluRes = 0;
        flags_eq = 0;
        flags_gt = 0;
        if (isAdd) aluRes = A + B; // Addition
        if (isSub) aluRes = A - B; // Subtraction
        if (isComp) begin // Comparison
            flags_eq = (A == B);
            flags_gt = (A >> B);
        end
        if (isMul) aluRes = A * B; // Multiplication
        if (isDiv) aluRes = A / B; // Division
        if (isMod) aluRes = A % B; // Modulo
        if (isLSL) aluRes = A << B; // Logical Shift Left
        if (isLSR) aluRes = A >> B; // Logical Shift Right
        if (isASR) aluRes = $signed(A) >>> B; // Arithmetic Shift Right
        if (isOR) aluRes = A | B; // OR Operation
        if (isAND) aluRes = A & B; // AND Operation
        if (isNOT) aluRes = ~A; // NOT Operation
        if (isMov) aluRes = B; // MOV Operation
    end

    assign aluResult = aluRes;
endmodule


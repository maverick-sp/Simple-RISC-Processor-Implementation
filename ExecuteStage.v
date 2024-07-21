`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2024 16:26:01
// Design Name: 
// Module Name: ExecuteStage
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


module ExecuteStage(
    input [31:0] branch_Target, op1, op2, immx,
    input isRet, isBeq, isBgt, isUbranch, isImmediate,
    input isAdd, isSub, isComp, isMul, isDiv, isMod, isLSL, isLSR, isASR, isOR, isAND, isNOT, isMov,
    output [31:0] branchPC,
    output isBranchTaken,
    output [31:0] aluResult
);
    wire flag_eq, flag_gt;
    // Branch Unit
    assign branchPC = isRet ? op1 : branch_Target;
    assign isBranchTaken = (flag_eq & isBeq) | isUbranch | (flag_gt & isBgt);
    
    wire [31:0] alu_input2;
    assign alu_input2 = isImmediate ? immx : op2;
    
    ALU ALU1(
        .A(op1), .B(alu_input2), .isAdd(isAdd), .isSub(isSub), .isComp(isComp), .isMul(isMul),
        .isDiv(isDiv), .isMod(isMod), .isLSL(isLSL), .isLSR(isLSR), .isASR(isASR), .isOR(isOR),
        .isAND(isAND), .isNOT(isNOT), .isMov(isMov), .flags_eq(flag_eq), .flags_gt(flag_gt),
        .aluResult(aluResult)
    );
endmodule


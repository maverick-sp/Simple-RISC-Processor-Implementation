`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2024 22:55:01
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit (
    input wire [31:0] Instruction,
    output reg isSt,
    output reg isLd,
    output reg isBeq,
    output reg isBgt,
    output reg isRet,
    output reg isImmediate,
    output reg isWb,
    output reg isUBranch,
    output reg isCall,
    output reg isAdd,
    output reg isSub,
    output reg isCmp,
    output reg isMul,
    output reg isDiv,
    output reg isMod,
    output reg isLsl,
    output reg isLsr,
    output reg isAsr,
    output reg isOr,
    output reg isAnd,
    output reg isNot,
    output reg isMov
);

    // Extracting opcode and immediate bit
    wire [4:0] op_code;
    wire I;

    assign op_code = Instruction[31:27];
    assign I = Instruction[26];

    // Process to generate control signals based on opcode and immediate bit
    always @(*) begin
        // Default values for control signals
        isSt = 0;
        isLd = 0;
        isBeq = 0;
        isBgt = 0;
        isRet = 0;
        isImmediate = 0;
        isWb = 0;
        isUBranch = 0;
        isCall = 0;
        isAdd = 0;
        isSub = 0;
        isCmp = 0;
        isMul = 0;
        isDiv = 0;
        isMod = 0;
        isLsl = 0;
        isLsr = 0;
        isAsr = 0;
        isOr = 0;
        isAnd = 0;
        isNot = 0;
        isMov = 0;

        // Set isImmediate if I bit is set
        if (I == 1'b1) begin
            isImmediate = 1;
        end

        // Generate control signals based on opcode
        case (op_code)
            5'b00000: begin // add
                isAdd = 1;
                isWb = 1;
            end
            5'b00001: begin // sub
                isSub = 1;
                isWb = 1;
            end
            5'b00010: begin // mul
                isMul = 1;
                isWb = 1;
            end
            5'b00011: begin // div
                isDiv = 1;
                isWb = 1;
            end
            5'b00100: begin // mod
                isMod = 1;
                isWb = 1;
            end
            5'b00101: begin // cmp
                isCmp = 1;
            end
            5'b00110: begin // and
                isAnd = 1;
                isWb = 1;
            end
            5'b00111: begin // or
                isOr = 1;
                isWb = 1;
            end
            5'b01000: begin // not
                isNot = 1;
                isWb = 1;
            end
            5'b01001: begin // mov
                isMov = 1;
                isWb = 1;
            end
            5'b01010: begin // lsl
                isLsl = 1;
                isWb = 1;
            end
            5'b01011: begin // lsr
                isLsr = 1;
                isWb = 1;
            end
            5'b01100: begin // asr
                isAsr = 1;
                isWb = 1;
            end
            5'b01110: begin // ld
                isLd = 1;
                isWb = 1;
                isAdd = 1;
            end
            5'b01111: begin // st
                isSt = 1;
                isAdd = 1;
            end
            5'b10000: begin // beq
                isBeq = 1;
            end
            5'b10001: begin // bgt
                isBgt = 1;
            end
            5'b10010: begin // b
                isUBranch = 1;
            end
            5'b10011: begin // call
                isCall = 1;
                isUBranch = 1;
                isWb = 1;
            end
            5'b10100: begin // ret
                isRet = 1;
                isUBranch = 1;
            end
            default: begin
                // Default case, all control signals are 0
            end
        endcase
    end

endmodule



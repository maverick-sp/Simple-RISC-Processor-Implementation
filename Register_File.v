`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2024 19:27:14
// Design Name: 
// Module Name: Register_File
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

module Register_File(
    input clk, reset, isWb,
    input [3:0] addr1, addr2, addr3, // addr1 and addr2 are read addresses and addr3 is write address
    input [31:0] data3,
    output reg [31:0] data1, data2
);
    reg [31:0] reg_file [0:15];
    integer i;
    always @(posedge reset) begin
       if(reset)
        for (i = 0; i < 16; i = i + 1) begin
            reg_file[i] <= 32'b0;
        end
    end
    
    // Read and Write
    always @(negedge clk or data3)
    begin
        if (isWb) begin
            reg_file[addr3] <= data3; // Writing into Register File
        end
    end
    
    // Fetching Operands from Register File
    always @(*) begin
        data1 = reg_file[addr1];
        data2 = reg_file[addr2];
    end
endmodule


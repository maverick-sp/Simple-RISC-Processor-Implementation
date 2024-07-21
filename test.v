`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2024 12:05:33
// Design Name: 
// Module Name: test
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

module test();

    reg clk;
    reg reset;
    
    // Instantiate the Simple_Risc_Processor
    Simple_Risc_Processor uut (
        .clk(clk),
        .reset(reset)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Clock period of 10 time units
    end
    
    // Initial block for simulation
    initial begin
        // Initialize signals
        reset = 1;
        // Apply reset
        #9;
        reset = 0;
   
        #25;

        $stop;
    end
    
endmodule

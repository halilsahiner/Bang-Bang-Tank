`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2017 12:01:47 PM
// Design Name: 
// Module Name: pll
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


module VGAClock(
    input inclk,
    output vgaclk
    );
    
    
    logic [1:0] count = {{2'b0}}; 
        
    always@ (posedge inclk) begin
        count <= count + 1;    
    end//always
    
    assign clk_NoBuf = count[1];
    
    BUFG BUFG_inst (
      .I(clk_NoBuf),  // 1-bit input: Clock input
      .O(vgaclk) // 1-bit output: Clock output
      
    );

    
endmodule

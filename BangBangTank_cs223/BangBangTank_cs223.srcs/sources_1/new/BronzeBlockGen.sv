`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2017 04:11:04 PM
// Design Name: 
// Module Name: bronzeBlockgen
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

module BronzeBlockGen( input logic [9:0] x,y, left, top, 
                       input logic [1:0] broken,
                       output logic[3:0] redBlock, greenBlock, blueBlock,
                       output logic inblock);
                       
    assign inblock = (x >= left & x < left + 16 & y >= top & y < top + 16  ) && broken < 2 ;     


    assign redBlock  [3] = ((y > top && y < top + 7) || (y > top + 8 && y < top + 15)) &&  ((x > left && x < left + 7) 
                           || (x > left + 8 && x < left + 15)); 
    assign greenBlock[2] = ((y > top && y < top + 6) || (y > top + 8 && y < top + 14)) &&  ((x > left + 1 && x < left + 7) 
                           || (x > left + 9 && x < left + 15));
    assign {blueBlock[3: 0], greenBlock[1:0]} = {6{((y > top + 1 && y < top + 4) || (y > top + 9 && y < top + 12)) 
                           &&  ((x > left + 3 && x < left + 6) || (x > left + 11 && x < left + 14))}} ;               
    assign redBlock[2] = 1 ;
    
endmodule

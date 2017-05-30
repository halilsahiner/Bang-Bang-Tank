`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2017 11:10:57 AM
// Design Name: 
// Module Name: baseGen
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


module BaseGen( input logic [9:0] x,y, left, top,
                input [1:0] broken,
                output logic[3:0] redBlock, greenBlock, blueBlock,
                output logic inblock);

    assign inblock = (x >= left  && x < left + 16  && y >= top  && y < top + 16 ) && broken == 0;

    assign redBlock[3 : 0] = x -  y  +  left  - top   ;
    assign greenBlock[3 : 0] =  x + y  - left  - top  ;
    
endmodule 

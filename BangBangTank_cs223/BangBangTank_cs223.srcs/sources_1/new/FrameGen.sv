`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2017 10:39:20 PM
// Design Name: 
// Module Name: skeletongen
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

module FrameGen( input logic [9:0] x,y, left, top, 
                 output logic[3:0] redBlock, greenBlock, blueBlock,
                 output logic inblock);
                                
                                
    assign inblock = (x >= left && x < left + 240 && y >= top && y < top + 240  ) && ~( x >= left+16 && x < left + 224 
                      && y >= top + 16 && y < top + 224   ) ;     
    assign {redBlock[3], greenBlock[3] ,blueBlock[3] } = {3{((y[3:0] - top[3:0] > 0  && y[3:0] - top[3:0] <   15)
                                                          &&((x[3:0] - left[3:0] > 0 && x[3:0] - left[3:0] <  15)))}}; 
    assign {blueBlock[1: 0] , greenBlock[1:0]} = {6{((y[3:0] - top[3:0] >  1 && y[3:0]- top[3:0]  <  4)) 
                                                 &&((x[3:0] - left[3:0] > 11 && x[3:0]- left[3:0] < 14))}} ;               
    assign {redBlock[2], greenBlock[2] , blueBlock[2]} = 111 ;

endmodule

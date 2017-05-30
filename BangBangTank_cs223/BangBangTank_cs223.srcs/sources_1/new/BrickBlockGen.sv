`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2017 04:10:07 PM
// Design Name: 
// Module Name: standartBlockGen
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



module  BrickBlockGen( input logic [9:0] x,y, left, top,
                        input [1:0] broken,
                         output logic[3:0] redBlock, greenBlock, blueBlock,
                         output logic inblock);

    assign inblock = (x >= left  & x < left + 16  & y >= top  & y < top + 16 ) && broken == 0;


    assign greenBlock[1 : 0] = {2{( ( x < left + 3 || ( x > left + 4 && x < left + 11 ) || x> left + 13 ) 
                                && (( y > top && y < top + 3) || ( y > top + 8 && y < top + 11 ) ) )
                                || (( x > left + 10 || ( x < left + 8 && x > left + 1))&&( (y > left + 4 && y < left + 7) 
                                || ( y > left + 12 && y < left + 15 )))}};
    assign greenBlock[3] = ~((( ( x < left + 3 || ( x > left + 3 && x < left + 11 ) || x>= left + 13 )
                               && ( y < top + 3 || ( y >= top + 8 && y < top + 11 )))   
                               || (( x >= left + 10 || ( x < left + 8 && x > left)) && ( (y >= left + 4 && y < left + 7)
                               || ( y > left + 11 && y < left + 15 )))));
    assign blueBlock[2:0] = {3 {~(( ( x < left + 3 || ( x > left + 3 && x < left + 11 ) || x>= left + 13 ) 
                               && ( y < top+3||( y >= top + 8 && y<top+11 )))|| (( x >= left + 10||( x < left + 8 && x > left))
                               &&( (y >= left + 4 && y < left + 7) || ( y > left + 11 && y < left + 15 ))))}};
    assign redBlock[3] = 1 ;
endmodule 

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2017 08:58:50 PM
// Design Name: 
// Module Name: PlayerStatus
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

module PlayerStatusGen( input logic[9:0] x,y, left, top,
	       input logic[6:0] p1, p2,
	       output logic [1:0][7:0] visible,
	       output logic [1:0][7:0][11:0] color
           );
           
           SimpleBlock simp0_0 (x, y, left + (0)*8, top + (0)*8, p1[1:0]>0, 0 ,
                       color[0][0][11:8],  color[0][0][7:4],     color[0][0][3:0] ,  visible[0][0]);
           SimpleBlock simp0_1 (x, y, left + (0)*8, top + (1)*8, p1[1:0]>1, 0 ,
                       color[0][1][11:8],  color[0][1][7:4],     color[0][1][3:0] ,  visible[0][1]);
           SimpleBlock simp0_2 (x, y, left + (0)*8, top + (2)*8,  p1[1:0]>2, 0 ,
                       color[0][2][11:8],  color[0][2][7:4],     color[0][2][3:0] ,  visible[0][2]);
           SimpleBlock simp0_3 (x, y, left + (0)*8, top + (3)*8, p1[2], 1 ,
                       color[0][3][11:8],  color[0][3][7:4],     color[0][3][3:0] ,  visible[0][3]);
           SimpleBlock simp0_4 (x, y, left + (0)*8, top + (4)*8, p1[3], 2 ,
                       color[0][4][11:8],  color[0][4][7:4],     color[0][4][3:0] ,  visible[0][4]);
           SimpleBlock simp0_5 (x, y, left + (0)*8, top + (5)*8, p1[4], 3 ,
                       color[0][5][11:8],  color[0][5][7:4],     color[0][5][3:0] ,  visible[0][5]);
           SimpleBlock simp0_6 (x, y, left + (0)*8, top + (6)*8, p1[5], 3 ,
                       color[0][6][11:8],  color[0][6][7:4],     color[0][6][3:0] ,  visible[0][6]);
           SimpleBlock simp0_7 (x, y, left + (0)*8, top + (7)*8, p1[6], 3 ,
                       color[0][7][11:8],  color[0][7][7:4],     color[0][7][3:0] ,  visible[0][7]);
           SimpleBlock simp1_0 (x, y, left + (1)*8, top + (0)*8,  p2[1:0]>0, 0 ,
                       color[1][0][11:8],  color[1][0][7:4],     color[1][0][3:0] ,  visible[1][0]);
           SimpleBlock simp1_1 (x, y, left + (1)*8, top + (1)*8, p2[1:0]>1, 0 ,
                       color[1][1][11:8],  color[1][1][7:4],     color[1][1][3:0] ,  visible[1][1]);
           SimpleBlock simp1_2 (x, y, left + (1)*8, top + (2)*8, p2[1:0]>2, 0 ,
                       color[1][2][11:8],  color[1][2][7:4],     color[1][2][3:0] ,  visible[1][2]);
           SimpleBlock simp1_3 (x, y, left + (1)*8, top + (3)*8,  p2[2], 1 ,
                       color[1][3][11:8],  color[1][3][7:4],     color[1][3][3:0] ,  visible[1][3]);
           SimpleBlock simp1_4 (x, y, left + (1)*8, top + (4)*8,  p2[3], 2 ,
                       color[1][4][11:8],  color[1][4][7:4],     color[1][4][3:0] ,  visible[1][4]);
           SimpleBlock simp1_5 (x, y, left + (1)*8, top + (5)*8,  p2[4], 3 ,
                       color[1][5][11:8],  color[1][5][7:4],     color[1][5][3:0] ,  visible[1][5]);
           SimpleBlock simp1_6 (x, y, left + (1)*8, top + (6)*8,  p2[5],  3 ,
                       color[1][6][11:8],  color[1][6][7:4],     color[1][6][3:0] ,  visible[1][6]);
           SimpleBlock simp1_7 (x, y, left + (1)*8, top + (7)*8,  p2[6], 3 ,
                       color[1][7][11:8],  color[1][7][7:4],     color[1][7][3:0] ,  visible[1][7]);
           
           
endmodule

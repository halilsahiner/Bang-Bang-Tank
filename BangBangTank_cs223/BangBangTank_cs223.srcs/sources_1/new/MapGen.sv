`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2017 04:11:39 PM
// Design Name: 
// Module Name: mapGen
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

module MapGen(  input  logic[9:0] x ,y, left, top,                
                input  logic [13:0][13:0][1:0] broken,
                output logic [13:0][13:0] visible,
                output logic [13:0][13:0][11:0] color);
                
                initial
                visible <= 0;
                //Brick
                BrickBlockGen stdRow12 (x, y, left + (2)*16, top + (2)*16, broken[2][2],
                                        color[2][2][11:8],  color[2][2][7:4],     color[2][2][3:0] ,  visible[2][2]);
  
                BrickBlockGen stdRow13 (x, y, left + (3)*16, top + (2)*16, broken[3][2],
                                        color[3][2][11:8],  color[3][2][7:4],     color[3][2][3:0] ,  visible[3][2]);
  
                BrickBlockGen stdRow14 (x, y, left + (4)*16, top + (2)*16, broken[4][2],
                                        color[4][2][11:8],  color[4][2][7:4],     color[4][2][3:0] ,  visible[4][2]);
  
                BrickBlockGen stdRow15 (x, y, left + (5)*16, top + (2)*16, broken[5][2],
                                        color[5][2][11:8],  color[5][2][7:4],     color[5][2][3:0] ,  visible[5][2]);
  
                BrickBlockGen stdRow19 (x, y, left + (9)*16, top + (2)*16, broken[9][2], 
                                        color[9][2][11:8],  color[9][2][7:4],     color[9][2][3:0] ,  visible[9][2]);
  
                BrickBlockGen stdRow110 (x, y, left + (10)*16, top + (2)*16, broken[10][2],
                                         color[10][2][11:8],  color[10][2][7:4],     color[10][2][3:0] ,  visible[10][2]);
  
                BrickBlockGen stdRow111 (x, y, left + (11)*16, top + (2)*16, broken[11][2], 
                                         color[11][2][11:8],  color[11][2][7:4],     color[11][2][3:0] ,  visible[11][2]);
  
                BrickBlockGen stdRow112 (x, y, left + (12)*16, top + (2)*16, broken[12][2], 
                                         color[12][2][11:8],  color[12][2][7:4],     color[12][2][3:0] ,  visible[12][2]);
  
                BrickBlockGen stdRow22 (x, y, left + (2)*16, top + (4)*16, broken[2][4], 
                                        color[2][4][11:8],  color[2][4][7:4],     color[2][4][3:0] ,  visible[2][4]);
  
                BrickBlockGen stdRow23 (x, y, left + (3)*16, top + (4)*16, broken[3][4], 
                                        color[3][4][11:8],  color[3][4][7:4],     color[3][4][3:0] ,  visible[3][4]);
  
                BrickBlockGen stdRow24 (x, y, left + (4)*16, top + (4)*16, broken[4][4], color[4][4][11:8], 
                                        color[4][4][7:4],     color[4][4][3:0] ,  visible[4][4]);
  
                BrickBlockGen stdRow25 (x, y, left + (5)*16, top + (4)*16, broken[5][4],
                                       color[5][4][11:8],  color[5][4][7:4],     color[5][4][3:0] ,  visible[5][4]);
  
                BrickBlockGen stdRow29 (x, y, left + (9)*16, top + (4)*16, broken[9][4],
                                       color[9][4][11:8],  color[9][4][7:4],     color[9][4][3:0] ,  visible[9][4]);
  
                BrickBlockGen stdRow210 (x, y, left + (10)*16, top + (4)*16, broken[10][4],
                                        color[10][4][11:8],  color[10][4][7:4],     color[10][4][3:0] ,  visible[10][4]);
  
                BrickBlockGen stdRow211 (x, y, left + (11)*16, top + (4)*16, broken[11][4],
                                        color[11][4][11:8],  color[11][4][7:4],     color[11][4][3:0] ,  visible[11][4]);
  
                BrickBlockGen stdRow212 (x, y, left + (12)*16, top + (4)*16, broken[12][4],
                                        color[12][4][11:8],  color[12][4][7:4],     color[12][4][3:0] ,  visible[12][4]);
  
                BrickBlockGen stdRow32 (x, y, left + (2)*16, top + (10)*16, broken[2][10],
                                       color[2][10][11:8],  color[2][10][7:4],     color[2][10][3:0] ,  visible[2][10]);
  
                BrickBlockGen stdRow33 (x, y, left + (3)*16, top + (10)*16, broken[3][10],
                                       color[3][10][11:8],  color[3][10][7:4],     color[3][10][3:0] ,  visible[3][10]);
  
                BrickBlockGen stdRow34 (x, y, left + (4)*16, top + (10)*16, broken[4][10],
                                       color[4][10][11:8],  color[4][10][7:4],     color[4][10][3:0] ,  visible[4][10]);
  
                BrickBlockGen stdRow35 (x, y, left + (5)*16, top + (10)*16, broken[5][10],
                                       color[5][10][11:8],  color[5][10][7:4],     color[5][10][3:0] ,  visible[5][10]);
  
                BrickBlockGen stdRow39 (x, y, left + (9)*16, top + (10)*16, broken[9][10],
                                       color[9][10][11:8],  color[9][10][7:4],     color[9][10][3:0] ,  visible[9][10]);
  
                BrickBlockGen stdRow310 (x, y, left + (10)*16, top + (10)*16, broken[10][10],
                                        color[10][10][11:8],  color[10][10][7:4],     color[10][10][3:0] ,  visible[10][10]);
  
                BrickBlockGen stdRow311 (x, y, left + (11)*16, top + (10)*16, broken[11][10],
                                        color[11][10][11:8],  color[11][10][7:4],     color[11][10][3:0] ,  visible[11][10]);
  
                BrickBlockGen stdRow312 (x, y, left + (12)*16, top + (10)*16, broken[12][10],
                                        color[12][10][11:8],  color[12][10][7:4],     color[12][10][3:0] ,  visible[12][10]);
  
                BrickBlockGen stdRow42 (x, y, left + (2)*16, top + (12)*16, broken[2][12], 
                                       color[2][12][11:8],  color[2][12][7:4],     color[2][12][3:0] ,  visible[2][12]);
  
                BrickBlockGen stdRow43 (x, y, left + (3)*16, top + (12)*16, broken[3][12],
                                       color[3][12][11:8],  color[3][12][7:4],     color[3][12][3:0] ,  visible[3][12]);
  
                BrickBlockGen stdRow44 (x, y, left + (4)*16, top + (12)*16, broken[4][12],
                                       color[4][12][11:8],  color[4][12][7:4],     color[4][12][3:0] ,  visible[4][12]);
  
                BrickBlockGen stdRow45 (x, y, left + (5)*16, top + (12)*16, broken[5][12],
                                       color[5][12][11:8],  color[5][12][7:4],     color[5][12][3:0] ,  visible[5][12]);
  
                BrickBlockGen stdRow49 (x, y, left + (9)*16, top + (12)*16, broken[9][12],
                                       color[9][12][11:8],  color[9][12][7:4],     color[9][12][3:0] ,  visible[9][12]);
  
                BrickBlockGen stdRow410 (x, y, left + (10)*16, top + (12)*16, broken[10][12],
                                        color[10][12][11:8],  color[10][12][7:4],     color[10][12][3:0] ,  visible[10][12]);
  
                BrickBlockGen stdRow411 (x, y, left + (11)*16, top + (12)*16, broken[11][12], 
                                        color[11][12][11:8],  color[11][12][7:4],     color[11][12][3:0] ,  visible[11][12]);
  
                BrickBlockGen stdRow412 (x, y, left + (12)*16, top + (12)*16, broken[12][12], 
                                        color[12][12][11:8],  color[12][12][7:4],     color[12][12][3:0] ,  visible[12][12]);
                
  
                //Bronze
                BronzeBlockGen brnzCol6_1 (x, y, left + (1)*16, top + (6)*16, broken[1][6],
                                          color[1][6][11:8],  color[1][6][7:4],     color[1][6][3:0] ,  visible[1][6]);
  
                BronzeBlockGen brnzCol8_1 (x, y, left + (1)*16, top + (8)*16, broken[1][8], 
                                          color[1][8][11:8],  color[1][8][7:4],     color[1][8][3:0] ,  visible[1][8]);
  
                BronzeBlockGen brnzCol6_2 (x, y, left + (2)*16, top + (6)*16, broken[2][6], 
                                          color[2][6][11:8],  color[2][6][7:4],     color[2][6][3:0] ,  visible[2][6]);
  
                BronzeBlockGen brnzCol7_2 (x, y, left + (2)*16, top + (7)*16, broken[2][7], 
                                          color[2][7][11:8],  color[2][7][7:4],     color[2][7][3:0] ,  visible[2][7]);
  
                BronzeBlockGen brnzCol8_2 (x, y, left + (2)*16, top + (8)*16, broken[2][8], 
                                          color[2][8][11:8],  color[2][8][7:4],     color[2][8][3:0] ,  visible[2][8]);
  
                BronzeBlockGen brnzCol6_4 (x, y, left + (4)*16, top + (6)*16, broken[4][6], 
                                          color[4][6][11:8],  color[4][6][7:4],     color[4][6][3:0] ,  visible[4][6]);
  
                BronzeBlockGen brnzCol7_4 (x, y, left + (4)*16, top + (7)*16, broken[4][7], 
                                          color[4][7][11:8],  color[4][7][7:4],     color[4][7][3:0] ,  visible[4][7]);
  
                BronzeBlockGen brnzCol8_4 (x, y, left + (4)*16, top + (8)*16, broken[4][8],
                                          color[4][8][11:8],  color[4][8][7:4],     color[4][8][3:0] ,  visible[4][8]);
  
                BronzeBlockGen brnzCol6_6 (x, y, left + (6)*16, top + (6)*16, broken[6][6], 
                                          color[6][6][11:8],  color[6][6][7:4],     color[6][6][3:0] ,  visible[6][6]);
  
                BronzeBlockGen brnzCol7_6 (x, y, left + (6)*16, top + (7)*16, broken[6][7], 
                                          color[6][7][11:8],  color[6][7][7:4],     color[6][7][3:0] ,  visible[6][7]);
  
                BronzeBlockGen brnzCol8_6 (x, y, left + (6)*16, top + (8)*16, broken[6][8],
                                          color[6][8][11:8],  color[6][8][7:4],     color[6][8][3:0] ,  visible[6][8]);
  
                BronzeBlockGen brnzCol6_8 (x, y, left + (8)*16, top + (6)*16, broken[8][6],
                                          color[8][6][11:8],  color[8][6][7:4],     color[8][6][3:0] ,  visible[8][6]);
  
                BronzeBlockGen brnzCol7_8 (x, y, left + (8)*16, top + (7)*16, broken[8][7], 
                                          color[8][7][11:8],  color[8][7][7:4],     color[8][7][3:0] ,  visible[8][7]);
  
                BronzeBlockGen brnzCol8_8 (x, y, left + (8)*16, top + (8)*16, broken[8][8], 
                                          color[8][8][11:8],  color[8][8][7:4],     color[8][8][3:0] ,  visible[8][8]);
  
                BronzeBlockGen brnzCol6_10 (x, y, left + (10)*16, top + (6)*16, broken[10][6], 
                                           color[10][6][11:8],  color[10][6][7:4],     color[10][6][3:0] ,  visible[10][6]);
  
                BronzeBlockGen brnzCol7_10 (x, y, left + (10)*16, top + (7)*16, broken[10][7], 
                                           color[10][7][11:8],  color[10][7][7:4],     color[10][7][3:0] ,  visible[10][7]);
  
                BronzeBlockGen brnzCol8_10 (x, y, left + (10)*16, top + (8)*16, broken[10][8], 
                                           color[10][8][11:8],  color[10][8][7:4],     color[10][8][3:0] ,  visible[10][8]);
  
                BronzeBlockGen brnzCol6_12 (x, y, left + (12)*16, top + (6)*16, broken[12][6], 
                                           color[12][6][11:8],  color[12][6][7:4],     color[12][6][3:0] ,  visible[12][6]);
  
                BronzeBlockGen brnzCol7_12 (x, y, left + (12)*16, top + (7)*16, broken[12][7], 
                                           color[12][7][11:8],  color[12][7][7:4],     color[12][7][3:0] ,  visible[12][7]);
  
                BronzeBlockGen brnzCol8_12 (x, y, left + (12)*16, top + (8)*16, broken[12][8], 
                                           color[12][8][11:8],  color[12][8][7:4],     color[12][8][3:0] ,  visible[12][8]);
  
                BronzeBlockGen brnzCol6_13 (x, y, left + (13)*16, top + (6)*16, broken[13][6], 
                                           color[13][6][11:8],  color[13][6][7:4],     color[13][6][3:0] ,  visible[13][6]);
  
                BronzeBlockGen brnzCol8_13 (x, y, left + (13)*16, top + (8)*16, broken[13][8], 
                                           color[13][8][11:8],  color[13][8][7:4],     color[13][8][3:0] ,  visible[13][8]);
  
               
                 //Iron
                IronBlockGen stlCol1_7 (x, y, left + (7)*16, top + (1)*16, broken[7][1],
                                         color[7][1][11:8],  color[7][1][7:4],     color[7][1][3:0] ,  visible[7][1]);
  
                IronBlockGen stlCol2_7 (x, y, left + (7)*16, top + (2)*16, broken[7][2], 
                                         color[7][2][11:8],  color[7][2][7:4],     color[7][2][3:0] ,  visible[7][2]);
  
                IronBlockGen stlCol3_7 (x, y, left + (7)*16, top + (3)*16, broken[7][3], 
                                         color[7][3][11:8],  color[7][3][7:4],     color[7][3][3:0] ,  visible[7][3]);
  
                IronBlockGen stlCol4_7 (x, y, left + (7)*16, top + (4)*16, broken[7][4], 
                                         color[7][4][11:8],  color[7][4][7:4],     color[7][4][3:0] ,  visible[7][4]);
  
                IronBlockGen stlCol10_7 (x, y, left + (7)*16, top + (10)*16, broken[7][10], 
                                          color[7][10][11:8],  color[7][10][7:4],     color[7][10][3:0] ,  visible[7][10]);
  
                IronBlockGen stlCol11_7 (x, y, left + (7)*16, top + (11)*16, broken[7][11], 
                                          color[7][11][11:8],  color[7][11][7:4],     color[7][11][3:0] ,  visible[7][11]);
  
                IronBlockGen stlCol12_7 (x, y, left + (7)*16, top + (12)*16, broken[7][12],
                                          color[7][12][11:8],  color[7][12][7:4],     color[7][12][3:0] ,  visible[7][12]);
  
                IronBlockGen stlCol13_7 (x, y, left + (7)*16, top + (13)*16, broken[7][13], 
                                          color[7][13][11:8], color[7][13][7:4], color[7][13][3:0] , visible[7][13]);     
                                          
               //bases
               BaseGen      redBase(x, y, left + (1)*16, top + (7)*16, broken[1][7],
                                                         color[1][7][11:8],  color[1][7][7:4], color[1][7][3:0] ,  visible[1][7] );
               BaseGen      blueBase(x, y, left + (13)*16, top + (7)*16, broken[13][7],
                                    color[13][7][3:0],  color[13][7][7:4], color[13][7][11:8] ,  visible[13][7] );
endmodule

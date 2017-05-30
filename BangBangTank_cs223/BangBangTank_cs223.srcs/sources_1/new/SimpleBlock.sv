`timescale 1ns / 1ps



module SimpleBlock( input logic [9:0] x,y, left, top,
                    input  visible,
                    input[1:0]  blockType,
                    output logic[3:0] redBlock, greenBlock, blueBlock,
                    output logic inblock);
                    
                    assign inblock = visible && (x >= left  & x < left + 8 & y >= top  & y < top + 8 );
                    
                    assign redBlock = {4{ ((blockType == 0 || blockType == 3) && x > left + 1 && x < left + 6 & y >= top + 2  & y < top + 6) }};
                    assign greenBlock = {4{ ((blockType == 1 || blockType == 3) && x > left + 1 && x < left + 6 & y >= top + 2  & y < top + 6) }};
                    assign blueBlock = {4{ (blockType == 2 && x > left + 1 && x < left + 6 & y >= top + 2  & y < top + 6) }};
                                        
endmodule


module BulletGen(input logic [9:0] x,y, left, top,
                 input logic superBul,
                 input logic [1:0] norm, 
                 output logic[3:0] colorBullet,
                 output logic inbullet);
               
                assign inbullet = x < left + 4 && y < top + 4 && x >= left && y >= top;
                
                always_comb
                  if( ~superBul )
                    colorBullet[3] <=   (y == top + 1 ||  y == top + 2) && (x == left + 1 || x == left + 2) ;
                else
                  begin
                if(norm[1])
                begin
                if(norm[0])
                begin
                        colorBullet[2] <= y == top + 1 && (x == left + 1 || x == left + 2) ;
                        colorBullet[3] <= ((y == top || y == top + 1  || y == top + 2) && (x == left + 1 || x == left + 2)) 
                                          || (y == top + 3 && ~(x == left + 1 || x == left + 2)) ;
                end
                else
                begin
                      colorBullet[2] <= y == top + 2 && (x == left + 1 || x == left + 2) ;
                      colorBullet[3] <= ((y == top + 3 || y == top + 1  || y == top + 2) 
                                         && (x == left + 1 || x == left + 2)) || (y == top && ~(x == left + 1 || x == left + 2)) ;
                end
                end
                else
                begin
                if(norm[0])
                begin
                        colorBullet[2] <= x == left + 1 && (y == top + 1 || y == top + 2) ;
                        colorBullet[3] <= ((x == left  || x == left + 1  || x == left + 2) && (y == top + 1 || y == top + 2)) 
                                          || (x == left + 3 && ~(y == top + 1 || y == top + 2)) ;
                end
                else
                begin
                      colorBullet[2] <= x == left + 2 && (y == top + 1 || y == top + 2) ;
                      colorBullet[3] <= ((x == left + 3 || x == left + 1  || x == left + 2) && (y == top + 1 || y == top + 2)) 
                                        || (x == left && ~(y == top + 1 || y == top + 2)) ;
                end
                end
                  end
endmodule

module TankGen( input logic [9:0] x,y, left, top,
                input logic[1:0] norm,
                output logic[3:0] color,
                output logic intank);

always_comb
begin
    intank <= (x >= left && x < left + 16 && y >= top && y < top + 16);
        if(norm [1])
        begin
            if(norm[0])
            begin
                color[3] <= (((y == top + 3) || (y == top + 5) || (y == top + 7) || (y == top + 9) || (y == top + 11) 
                              || (y == top + 13) || (y == top + 15 ) ) && (( x < left + 2) || (x > left + 13) )) 
                              || ( x== left && y >= top +3 && y < top + 13 )|| (( x >= left + 3) && ( x < left + 13 )
                              && (y >= top + 6) && (y < top +13 ) && ~( (x >= left + 7) && ( x < left + 9 ) && (y >= top + 6) 
                              && (y < top +9 )))|| ( y == top + 15 && ~( x >= left + 4 && x < left + 12 )) 
                              || ( y == top + 13 && ~( (x == left + 2) || (x == left + 4) ||(x == left + 11) || (x == left + 13 )) ) 
                              || ( y== top +14 && ( x == left + 3 || x == left + 12 ));

                color[2] <= ((y >= top +6)|| ( x == left + 7 )|| ( x == left + 8 )) && ( y < top + 14) 
                              || ( (x < left + 3 || x >= left + 13) && (y >= top + 3) ) ;

                color[1] <= ((x == left + 3 || x == left + 12) && (y >= top + 6) && (y < top + 15 )) || ((y == top + 6 ) 
                              && ( x == left + 4 || x == left + 5 || x == left + 10 || x == left + 11))
                              || ( y == top + 7 && ( x == left + 5 || x == left + 10)) ;

                color[0] <= ((x == left + 3 || x == left + 12) && (y >= top + 6) && (y < top + 15 )) 
                              || ((y == top + 6 ) && ( x == left + 4 || x == left + 5 || x == left + 10 || x == left + 11))
                              || ( y == top + 7 && ( x == left + 5 || x == left + 10)) ;
            end
            else
            begin
                color[3] <= (((y == top + 12) || (y == top + 10) || (y == top + 8) || (y == top + 6) || (y == top + 4) 
                              || (y == top + 2) || (y == top ) )&& (( x < left + 2) || (x > left + 13) ))
                              || ( x== left +15 && y <= top + 12 && y > top + 2 )|| (( x <= left + 12) 
                              && ( x > left + 2 ) && (y <= top + 9) && (y > top +2 ) && ~( (x <= left + 8) && ( x > left + 6 )
                              && (y <= top + 9) && (y > top +6 )))|| ( y == top && ~( x <= left + 11 && x > left + 3 ))
                              || ( y == top + 2 && ~( (x == left + 13) || (x == left + 11) ||(x == left + 4) || (x == left + 2 )) )
                              || ( y== top +1 && ( x == left + 12 || x == left + 3 ));

                color[2] <= ((y <= top +9)|| ( x == left + 8 )|| ( x == left + 7 )) && ( y > top + 1) 
                            || ( (x > left + 12|| x <= left + 2) && (y <= top + 12) ) ;

                color[1] <= ((x == left + 12 || x == left + 3) && (y <= top + 9) && (y > top )) || ((y == top + 9 ) 
                            && ( x == left + 11 || x == left + 10 || x == left + 5 || x == left + 4)) 
                            || ( y == top + 8 && ( x == left + 10 || x == left + 5)) ;

                color[0] <= ((x == left + 12 || x == left + 3) && (y <= top + 9) && (y > top )) || ((y == top + 9 ) 
                            && ( x == left + 11 || x == left + 10 || x == left + 5 || x == left + 4))
                            || ( y == top + 87 && ( x == left + 10 || x == left + 5)) ;
            end
        end
        else
        begin
            if(norm[0])
            begin
                color[3] <= (((x == left + 3) || (x == left + 5) || (x == left + 7) || (x == left + 9) || (x == left + 11) 
                              || (x == left + 13) || (x == left + 15 ) ) && (( y < top + 2) || (y > top + 13) ))
                              || ( y== top && x >= left +3 && x < left + 13 )||(( y >= top + 3) && ( y < top + 13 ) 
                              && (x >= left + 6) && (x < left +13 ) && ~( (y >= top + 7) && ( y < top + 9 ) && (x >= left + 6) 
                              && (x < left +9 ))) || ( x == left + 15 && ~( y >= top + 4 && y < top + 12 ))|| ( x == left + 13 
                              && ~( (y == top + 2) || (y == top + 4) ||(y == top + 11) || (y == top + 13 )) ) 
                              || ( x== left +14 && ( y == top + 3 || y == top + 12 ));

                color[2] <= ((x >= left +6)|| ( y == top + 7 )|| ( y == top + 8 )) && ( x < left + 14) 
                            || ( (y < top + 3 || y >= top + 13) && (x >= left + 3) ) ;

                color[1] <= ((y == top + 3 || y == top + 12) && (x >= left + 6) && (x < left + 15 )) 
                            || ((x == left + 6 ) && ( y == top + 4 || y == top + 5 || y == top + 10 || y == top + 11))
                            || ( x == left + 7 && ( y == top + 5 || y == top + 10)) ;

                color[0] <= ((y == top + 3 || y == top + 12) && (x >= left + 6) && (x < left + 15 )) 
                            || ((x == left + 6 ) && ( y == top + 4 || y == top + 5 || y == top + 10 || y == top + 11)) 
                            || ( x == left + 7 && ( y == top + 5 || y == top + 10)) ;
            end
            else
            begin
                color[3] <= (((x == left + 12) || (x == left + 10) || (x == left + 8) || (x == left + 6) || (x == left + 4)
                              || (x == left + 2) || (x == left ) ) && (( y < top + 2) || (y > top + 13) )) 
                              || ( y== top +15 && x <= left + 12 && x > left + 2 ) || (( y <= top + 12) 
                              && ( y > top + 2 ) && (x <= left + 9) && (x > left +2 ) && ~( (y <= top + 8)
                              && ( y > top + 6 ) && (x <= left + 9) && (x > left +6 ))) || ( x == left 
                              && ~( y <= top + 11 && y > top + 3 ))|| ( x == left + 2 && ~( (y == top + 13) || (y == top + 11)
                              ||(y == top + 4) || (y == top + 2 )) )|| ( x== left +1 && ( y == top + 12 || y == top + 3 ));

                color[2] <= ((x <= left +9)|| ( y == top + 8 )|| ( y == top + 7 )) && ( x > left + 1) 
                            || ( (y > top + 12|| y <= top + 2) && (x <= left + 12) ) ;

                color[1] <= ((y == top + 12 || y == top + 3) && (x <= left + 9) && (x > left )) || ((x == left + 9 ) 
                            && ( y == top + 11 || y == top + 10 || y == top + 5 || y == top + 4))
                            || ( x == left + 8 && ( y == top + 10 || y == top + 5)) ;

                color[0] <= ((y == top + 12 || y == top + 3) && (x <= left + 9) && (x > left )) || ((x == left + 9 )
                            && ( y == top + 11 || y == top + 10 || y == top + 5 || y == top + 4))
                            || ( x == left + 87 && ( y == top + 10 || y == top + 5)) ;
            end
        end
end
endmodule

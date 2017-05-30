`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Code Erat Demonstrandum
// Engineer: SomeOne
// 
// Create Date: 04/05/2017 11:18:19 AM
// Design Name: 
// Module Name: vga
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


module TOP(
    input logic clk, psclk, data,reset, shoot_1, 
    input logic p1_u, p1_d, p1_l, p1_r,
    input logic [3:0] rowin,
    output logic [3:0] column,
    output logic hsync, vsync,
    output logic [3:0] red, green, blue);
    
    logic [9:0] x, y;
    logic vgaclk;
    logic [7:0] data_out;
    logic p2_u=0, p2_d=0, p2_l=0, p2_r=0, shoot_2=0;
    
    VGAClock vgapll( .inclk(clk), .vgaclk(vgaclk));
    VGAController vgaCont( vgaclk, hsync, vsync, x, y );
    
    PSKeyboard psKeyboard( psclk, data, data_out);
    
    logic [3:0] char1;
    BetiKeyboard betiKeyboard( clk, reset, rowin, column, char1);
    
    
    always_ff @( posedge clk)
        begin
            if( data_out == 8'b01110101)
            begin
                p2_u <= 1;
                p2_d <= 0;
                p2_l <= 0;
                p2_r <= 0;
                shoot_2 <= 0;
            end
            else if( data_out == 8'b01110010)
            begin
                            p2_u <= 0;
                            p2_d <= 1;
                            p2_l <= 0;
                            p2_r <= 0;
                            shoot_2 <= 0;
                        end
            else if( data_out == 8'b01101011)
            begin
                            p2_u <= 0;
                            p2_d <= 0;
                            p2_l <= 1;
                            p2_r <= 0;
                            shoot_2 <= 0;
                        end
            else if( data_out == 8'b11100000)
            begin
                            p2_u <= 0;
                            p2_d <= 0;
                            p2_l <= 0;
                            p2_r <= 1;
                            shoot_2 <= 0;
                        end
            else if( data_out == 8'b00101001)
            begin
                            p2_u <= 0;
                            p2_d <= 0;
                            p2_l <= 0;
                            p2_r <= 0;
                            shoot_2 <= 1;
                        end
            
        end
        
       
    
    VideoGen videoGen( p1_u || char1==4'b0001, p1_d || char1==4'b0100, p1_l || char1==4'b1110, p1_r || char1==4'b0111, shoot_1,
                       p2_u, p2_d, p2_l, p2_r, shoot_2, x, y,
                       clk, reset, red, green, blue);

endmodule



module VGAController #(parameter HACTIVE = 10'd640,
                                 HFP     = 10'd16,
                                 HSYN    = 10'd96,
                                 HBP     = 10'd32,
                                 HMAX    = HACTIVE + HFP + HSYN + HBP,
                                 VACTIVE = 10'd480,
                                 VBP     = 10'd32,
                                 VFP     = 10'd11,
                                 VSYN    = 10'd2,
                                 VMAX    = VACTIVE + VFP + VSYN +VBP)
                                 (input logic vgaclk,
                                 output logic hsync, vsync,
                                 output logic [9:0] x, y);

always@(posedge vgaclk) 
begin
    x++;
    if( x== HMAX )
    begin
        x = 0;
        y++;
        if ( y == VMAX ) y = 0;
     end                               
end

assign hsync = ~( x >= HACTIVE + HFP & x < HACTIVE + HFP + HSYN );
assign vsync = ~( y >= VACTIVE + VFP & y < VACTIVE + VFP + VSYN );   

                                                                 
endmodule

module VideoGen( input logic p1_u, p1_d, p1_l, p1_r, shoot_1,
                 input logic p2_u, p2_d, p2_l, p2_r, shoot_2,
                 input logic [9:0] x, y,
                 input logic clk, reset,
                 output logic [3:0] r,g,b
                 );

    logic[6:0] ucontrol, dcontrol, rcontrol, lcontrol; 
    logic[6:0] ucontrol2, dcontrol2, rcontrol2, lcontrol2;
    logic[6:0] ucontrolb, dcontrolb, rcontrolb, lcontrolb;
    logic[6:0] ucontrolb2, dcontrolb2, rcontrolb2, lcontrolb2;
    
    logic[1:0] directionRed;
    logic[1:0] directionGreen;
    logic[3:0] colorR, colorG;
   
    
    logic intankR, intankG;
    
    logic[9:0] top1=10'd192, left1=10'd128, top2 = 10'd32, left2 = 10'd224;
    logic[9:0] left_b_1 = 10'd96, top_b_1 = 10'd16;
    logic[9:0] left_b_2 = 10'd96, top_b_2 = 10'd16;
    
    logic[1:0][7:0][11:0] statuscolor;
        logic[1:0][7:0] statusvisible;

    logic [13:0][13:0][1:0] broken;
    logic [13:0][13:0] visible;
    logic [13:0][13:0][11:0] color;
    logic [3:0] redBlock, greenBlock, blueBlock;
    logic inblock;
    logic [1:0] move;
    logic [1:0] move2;
    
    logic [1:0][3:0] colorBullet;
    logic [1:0] inbullet;
    logic readyToMove = 0;
    logic readyToMove2 = 0;
    logic [1:0] moveb;
    logic [1:0] moveb2;
    logic [1:0] directionBullet;
    logic [1:0] directionBullet2;
    logic [7:0] player1_status, player2_status;
    
    
    initial
    begin
        move <= 0;
        move2 <= 0;
        moveb <= 0;
        moveb2 <= 0;
        player1_status <= 7'b0000011;
        player2_status <= 7'b0000011;
    end
    
    
    FrameGen frameGen( x,y, 10'd96, 10'd16, redBlock, greenBlock, blueBlock, inblock);
    MapGen mapGen( x, y, 10'd96, 10'd16, broken, visible, color);
    BulletGen bullet1( x,y, left_b_1, top_b_1, 0, 0, colorBullet[0][3:0], inbullet[0]);
    BulletGen bullet2( x,y, left_b_2, top_b_2, 0, 0, colorBullet[1][3:0], inbullet[1]);
    PlayerStatusGen status(x, y, 10'd350, 10'd60, player1_status, player2_status, statusvisible, statuscolor);

    always_ff @ ( posedge clk ,posedge reset )
        if(reset)
            begin
                top1<=10'd192; left1<=10'd128; top2 <= 10'd32; left2 <= 10'd224;
                left_b_1 <= 10'd96; top_b_1 <= 10'd16;
                player1_status <= 7'b0000011;
                player2_status <= 7'b0000011;
                left_b_2 <= 10'd96; top_b_2 <= 10'd16;
                broken <= 0;
            end
        else
            begin
                if( p1_u == 1 ) 
                begin         
                    if( ~((left1 == left2) ? (top2 == top1 + 16) : 0 ) && (top1 > 31) && y == top1 - 1 && x >= left1 && x < left1 + 16 )
                    begin
                        if( visible[(x-96)/16][(y-16)/16] || ( top1 - top2 >= 0  && top1 - top2 < 16 && (left2 - left1 > -16 || left2 - left1 < 16) ) )
                            ucontrol <= 0;
                        else
                        begin
                            ucontrol <= ucontrol +1;
                            if( ucontrol == 60 )
                            begin
                            move <= move + 1 ;
                                if(move == 1)
                                    top1 <= top1  - 1;        
                                ucontrol <= 0;
                            end
                        end
                    end
                    directionRed <= 3;
                end
                else if( p1_l == 1)
                begin
                    if( ~((top1 == top2) ? (left2 == left1 - 16) : 0 ) && (left1 > 111)  &&  x == left1 - 1 && y >= top1 && y < top1 + 16  )
                    begin
                        if( ~(visible[(x-96)/16][(y-16)/16] || ( left1 - left2 < 16 && left1 - left2 >= 0  && (top2 - top1 > -16 || top2 - top1 < 16)) ) )
                        begin
                            lcontrol <= lcontrol +1;
                            if( lcontrol == 60 )
                            begin
                                move <= move + 1 ;
                                if(move == 1)
                                    left1 <= left1 - 1;
                                lcontrol <= 0;
                            end
                        end
                        else
                            lcontrol <= 0;
                    end
                    directionRed <= 1;
                end
                else if( p1_r == 1 )
                begin
                    if( ~((top1 == top2) ? (left2 == left1 + 16) : 0 ) && (left1 < 305)  && x == left1 + 16 && y >= top1 && y < top1 + 16 )
                    begin
                        if( ~(visible[(x-96)/16][(y-16)/16] || ( left2 - left1 < 16 && left2 - left1 >= 0  && (top2 - top1 > -16 || top2 - top1 < 16)) )  )
                        begin
                            rcontrol <= rcontrol +1;
                            if( rcontrol == 60 )
                            begin
                                move <= move + 1 ;
                                if(move == 1)
                                    left1 <= left1 + 1;
                                rcontrol <=0; 
                            end
                        end
                        else
                            rcontrol <= 0;    
                    end
                    directionRed <= 0;
                end
                else if( p1_d == 1 )
                begin
                    if( ~((left1 == left2) ? (top2 == top1 + 16) : 0) && (top1 < 225)  && x >= left1 && x < left1 + 16 && y == top1 + 16 )
                    begin
                        if( visible[(x-96)/16][(y-16)/16] || ( top1 - top2 >= 0  && top2 - top1 < 16 && (left2 - left1 > -16 || left2 - left1 < 16) ) )
                            dcontrol <= 0;
                        else
                        begin
                            dcontrol <= dcontrol + 5;
                            if( dcontrol == 60 )
                            begin
                                move <= move + 1 ;
                                if(move == 1)
                                    top1 <= top1  + 1; 
                                dcontrol <= 0;
                            end
                        end
                    end
                    directionRed <= 2;
                end
                if( p2_u == 1 ) 
                begin         
                    if( ~((left1 == left2) ? (top1 == top2 + 16) : 0) && (top2 > 31) && y == top2 - 1 && x >= left2 && x < left2 + 16 )
                    begin
                        if( visible[(x-96)/16][(y-16)/16] || ( top2 - top1 >= 0  && top2 - top1 < 16 && (left2 - left1 > -16 || left2 - left1 < 16) ) )
                            ucontrol2 <= 0;
                        else
                        begin
                            ucontrol2 <= ucontrol2 +1;
                            if( ucontrol2 == 60 )
                            begin
                            move2 <= move2 + 1 ;
                                if(move2 == 1)
                                    top2 <= top2  - 1;        
                                ucontrol2 <= 0;
                            end
                        end
                    end
                    directionGreen <= 3;
                end
                else if( p2_l == 1)
                begin
                    if( ~((top1 == top2) ? ( left1 == left2 - 16) : 0) && (left2 > 111)  &&  x == left2 - 1 && y >= top2 && y < top2 + 16  )
                    begin
                        if( ~(visible[(x-96)/16][(y-16)/16] || ( left2 - left1 < 16 && left2 - left1 >= 0  && (top2 - top1 > -16 || top2 - top1 < 16)) ) )
                        begin
                            lcontrol2 <= lcontrol2 +1;
                            if( lcontrol2 == 60 )
                            begin
                                move2 <= move2 + 1 ;
                                if(move2 == 1)
                                    left2 <= left2 - 1;
                                lcontrol2 <= 0;
                            end
                        end
                        else
                            lcontrol2 <= 0;
                    end
                    directionGreen <= 1;
                end
                else if( p2_r == 1 )
                begin
                    if( ~( (top1 == top2) ? ( left1 == left2 + 17) : 0) && (left2 < 305)  && x == left2 + 16 && y >= top2 && y < top2 + 16 )
                    begin
                        if( ~(visible[(x-96)/16][(y-16)/16] || ( left1 - left2 < 16 && left1 - left2 >= 0  && (top2 - top1 > -16 || top2 - top1 < 16)) ) )
                        begin
                            rcontrol2 <= rcontrol2 +1;
                            if( rcontrol2 == 60 )
                            begin
                                move2 <= move2 + 1 ;
                                if(move2 == 1)
                                    left2 <= left2 + 1;
                                rcontrol2 <=0; 
                            end
                        end
                        else
                            rcontrol2 <= 0;    
                    end
                    directionGreen <= 0;
                end
                else if( p2_d == 1 )
                begin
                    if( ~((left1 == left2) ? (top1 == top2 + 16) : 0) && (top2 < 225)  && x >= left2 && x < left2 + 16 && y == top2 + 16 )
                    begin
                        if( visible[(x-96)/16][(y-16)/16] || ( top1 - top2 >= 0  && top1 - top2 < 16 && (left2 - left1 > -16 || left2 - left1 < 16) ) )
                            dcontrol2 <= 0;
                        else
                        begin
                            dcontrol2 <= dcontrol2 +1;
                            if( dcontrol2 == 60 )
                            begin
                                move2 <= move2 + 1 ;
                                if(move2 == 1)
                                    top2 <= top2  + 1; 
                                dcontrol2 <= 0;
                            end
                        end
                    end
                    directionGreen <= 2;
                end
            if( shoot_1 == 1)
                begin
                    if( ( left_b_1 == 10'd96 ) &&( top_b_1 == 10'd16))
                    begin
                        readyToMove <= 1;
                        if( directionRed == 3)
                            begin
                                directionBullet <= 3;
                                left_b_1 <= left1 + 6;
                                top_b_1 <= top1 - 2;
                            end
                        else if( directionRed == 1)
                            begin
                                directionBullet <= 1;
                                left_b_1 <= left1 - 2;
                                top_b_1 <= top1 + 6;
                            end
                        else if( directionRed == 2)
                            begin
                                directionBullet <= 2;
                                left_b_1 <= left1 + 6;
                                top_b_1 <= top1 + 16;
                            end
                        else if( directionRed == 0)
                            begin
                                directionBullet <= 0;
                                left_b_1 <= left1 + 16;
                                top_b_1 <= top1 + 6;
                            end
                    end
                end
            if( readyToMove == 1)
                begin
                    if( (top_b_1 > 31) && directionBullet == 3)
                        begin
                            if( y == top_b_1 - 1 && x >= left_b_1 && x < left_b_1 + 2 )
                                begin
                                    if( visible[(x-96)/16][(y-16)/16] )
                                        begin
                                            if( visible[(x-96)/16][(y-16)/16] == visible[13][7])
                                                begin
                                                    player1_status[4] <= 1'b1;
                                                    player1_status[5] <= 1'b1;
                                                    player1_status[6] <= 1'b1;
                                                end
                                            if( ~(broken[(x-96)/16][(y-16)/16] == 2))
                                                broken[(x-96)/16][(y-16)/16] <= broken[(x-96)/16][(y-16)/16] + 1;
                                            
                                            ucontrolb <= 0;
                                            left_b_1 <= 10'd96; top_b_1 <= 10'd16;
                                            readyToMove <= 0;
                                        end
                                    else if(  top2 == top_b_1 - 1 && left2 < left_b_1 && left_b_1 < left2 + 17 )
                                        begin 
                                        
                                            if( player1_status[4] == 1'b0)
                                                player1_status[4] <= 1'b1;
                                            else if( player1_status[5] == 1'b0)
                                                player1_status[5] <= 1'b1;
                                            else
                                                player1_status[6] <= 1'b1;
                                            player2_status <= player2_status - 1'b1;
                                            
                                            top2 <= 10'd32; 
                                            left2 <= 10'd224;
                                            ucontrolb <= 0;
                                            left_b_1 <= 10'd96 ; top_b_1 <= 10'd16;
                                            left_b_2 <= 10'd96 ; top_b_2 <= 10'd16;
                                            readyToMove <= 0;
                                        end
                                    else
                                        begin
                                            ucontrolb <= ucontrolb + 2;
                                            if( ucontrolb == 60 )
                                            begin
                                                moveb <= moveb + 1 ;
                                                    if(moveb == 1)
                                                        top_b_1 <= top_b_1  - 1;        
                                                    ucontrolb <= 0;
                                            end
                                        end
                                end
                        end
                    else if( (left_b_1 > 111)  &&  directionBullet == 1)
                        begin
                           if( x == left_b_1 - 1 && y >= top_b_1 && y < top_b_1 + 2  )
                               begin
                                   if( visible[(x-96)/16][(y-16)/16] )
                                   begin
                                        if( visible[(x-96)/16][(y-16)/16] == visible[13][7])
                                           begin
                                               player1_status[4] <= 1'b1;
                                               player1_status[5] <= 1'b1;
                                               player1_status[6] <= 1'b1;
                                           end
                                        if( ~(broken[(x-96)/16][(y-16)/16] == 2))
                                          broken[(x-96)/16][(y-16)/16] <= broken[(x-96)/16][(y-16)/16] + 1;
                                        lcontrolb <= 0;
                                        left_b_1 <= 10'd96 ; top_b_1 <= 10'd16;
                                        readyToMove <= 0;
                                   end
                                   else if(  left2 == left_b_1 - 1 && top2 < top_b_1 && top_b_1 < top2 + 17)
                                       begin 
                                            if( player1_status[4] == 1'b0)
                                               player1_status[4] <= 1'b1;
                                           else if( player1_status[5] == 1'b0)
                                               player1_status[5] <= 1'b1;
                                           else
                                               player1_status[6] <= 1'b1;
                                           player2_status <= player2_status - 1'b1;
                                           top2 <= 10'd32; 
                                           left2 <= 10'd224;
                                           lcontrolb <= 0;
                                           left_b_1 <= 10'd96 ; top_b_1 <= 10'd16;
                                           left_b_2 <= 10'd96 ; top_b_2 <= 10'd16;
                                           readyToMove <= 0;
                                       end
                                   else
                                        begin
                                            lcontrolb <= lcontrolb + 2;
                                            if( lcontrolb == 60 )
                                                begin
                                                    moveb <= moveb + 1 ;
                                                    if( moveb == 1)
                                                        left_b_1 <= left_b_1 - 1;
                                                    lcontrolb <= 0;
                                                 end
                                        end
                               end
                        end
                    else if( (top_b_1 < 239)  && directionBullet == 2)
                        begin
                           if( x >= left_b_1 && x < left_b_1 + 2 && y == top_b_1 + 2 )
                               begin
                                   if( visible[(x-96)/16][(y-16)/16] )
                                       begin
                                            if( visible[(x-96)/16][(y-16)/16] == visible[13][7])
                                               begin
                                                   player1_status[4] <= 1'b1;
                                                   player1_status[5] <= 1'b1;
                                                   player1_status[6] <= 1'b1;
                                               end
                                            if( ~(broken[(x-96)/16][(y-16)/16] == 2))
                                                broken[(x-96)/16][(y-16)/16] <= broken[(x-96)/16][(y-16)/16] + 1;
                                            dcontrolb <= 0;
                                            left_b_1 <= 10'd96 ; top_b_1 <= 10'd16;
                                            readyToMove <= 0;
                                       end
                                   else if(  top2 == top_b_1 + 1 && left2 < left_b_1 && left_b_1 < left2 + 17)
                                      begin 
                                            if( player1_status[4] == 1'b0)
                                                 player1_status[4] <= 1'b1;
                                             else if( player1_status[5] == 1'b0)
                                                 player1_status[5] <= 1'b1;
                                             else
                                                 player1_status[6] <= 1'b1;
                                             player2_status <= player2_status - 1'b1;
                                          top2 <= 10'd32; 
                                          left2 <= 10'd224;
                                          dcontrolb <= 0;
                                          left_b_1 <= 10'd96 ; top_b_1 <= 10'd16;
                                          left_b_2 <= 10'd96 ; top_b_2 <= 10'd16;
                                          readyToMove <= 0;
                                      end
                                   else
                                   begin
                                       dcontrolb <= dcontrolb + 2;
                                       if( dcontrolb == 60 )
                                       begin
                                           moveb <= moveb + 1 ;
                                           if(moveb == 1)
                                               top_b_1 <= top_b_1 + 1; 
                                           dcontrolb <= 0;
                                       end
                                   end
                               end
                        end
                    else if( (left_b_1 < 319)  && directionBullet == 0)
                        begin
                           if( x == left_b_1 + 2 && y >= top_b_1 && y < top_b_1 + 2 )
                                begin
                                    if( visible[(x-96)/16][(y-16)/16] )
                                        begin
                                            if( visible[(x-96)/16][(y-16)/16] == visible[13][7])
                                                begin
                                                    player1_status[4] <= 1'b1;
                                                    player1_status[5] <= 1'b1;
                                                    player1_status[6] <= 1'b1;
                                                end
                                            if( ~(broken[(x-96)/16][(y-16)/16] == 2))
                                                broken[(x-96)/16][(y-16)/16] <= broken[(x-96)/16][(y-16)/16] + 1;
                                            rcontrolb <= 0;
                                            left_b_1 <= 10'd96 ; top_b_1 <= 10'd16;
                                            readyToMove <= 0;
                                        end
        
                                    else if(  left2 == left_b_1 + 1 && top2 < top_b_1 && top_b_1 < top2 + 17)
                                       begin 
                                           if( player1_status[4] == 1'b0)
                                                player1_status[4] <= 1'b1;
                                            else if( player1_status[5] == 1'b0)
                                                player1_status[5] <= 1'b1;
                                            else
                                                player1_status[6] <= 1'b1;
                                            player2_status <= player2_status - 1'b1;
                                           top2 <= 10'd32; 
                                           left2 <= 10'd224;
                                           rcontrolb <= 0;
                                           left_b_1 <= 10'd96 ; top_b_1 <= 10'd16;
                                           left_b_2 <= 10'd96 ; top_b_2 <= 10'd16;
                                           readyToMove <= 0;
                                       end
                                    else
                                    begin
                                        rcontrolb <= rcontrolb + 2;
                                        if( rcontrolb == 60 )
                                        begin
                                            moveb <= moveb + 1 ;
                                            if(moveb == 1)
                                                left_b_1 <= left_b_1 + 1;
                                            rcontrolb <=0; 
                                        end
                                    end
                                           
                                end
                         end
                    else
                        begin
                            left_b_1 <= 10'd96 ; top_b_1 <= 10'd16;
                            readyToMove <= 0;
                        end
                end
            
                if( shoot_2 == 1)
                                begin
                                    if( ( left_b_2 == 10'd96 ) &&( top_b_2 == 10'd16))
                                    begin
                                        readyToMove2 <= 1;
                                        if( directionGreen == 3)
                                            begin
                                                directionBullet2 <= 3;
                                                left_b_2 <= left2 + 6;
                                                top_b_2 <= top2 - 2;
                                            end
                                        else if( directionGreen == 1)
                                            begin
                                                directionBullet2 <= 1;
                                                left_b_2 <= left2 - 2;
                                                top_b_2 <= top2 + 6;
                                            end
                                        else if( directionGreen == 2)
                                            begin
                                                directionBullet2 <= 2;
                                                left_b_2 <= left2 + 6;
                                                top_b_2 <= top2 + 16;
                                            end
                                        else if( directionGreen == 0)
                                            begin
                                                directionBullet2 <= 0;
                                                left_b_2 <= left2 + 16;
                                                top_b_2 <= top2 + 6;
                                            end
                                    end
                                end
                if( readyToMove2 == 1)
                    begin
                        if( (top_b_2 > 31) && directionBullet2 == 3)
                            begin
                                if( y == top_b_2 - 1 && x >= left_b_2 && x < left_b_2 + 2 )
                                    begin
                                        if( visible[(x-96)/16][(y-16)/16] )
                                            begin
                                                if( visible[(x-96)/16][(y-16)/16] == visible[1][7])
                                                                                                begin
                                                                                                    player2_status[4] <= 1'b1;
                                                                                                    player2_status[5] <= 1'b1;
                                                                                                    player2_status[6] <= 1'b1;
                                                                                                end
                                                if( ~(broken[(x-96)/16][(y-16)/16] == 2))
                                                    broken[(x-96)/16][(y-16)/16] <= broken[(x-96)/16][(y-16)/16] + 1;
                                                
                                                ucontrolb2 <= 0;
                                                left_b_2 <= 10'd96; top_b_2 <= 10'd16;
                                                readyToMove2 <= 0;
                                            end
                                        else if(  top1 == top_b_2 - 1 && left1 < left_b_2 && left_b_2 < left1 + 17 )
                                            begin 
                                                if( player2_status[4] == 1'b0)
                                                    player2_status[4] <= 1'b1;
                                                else if( player2_status[5] == 1'b0)
                                                    player2_status[5] <= 1'b1;
                                                else
                                                    player2_status[6] <= 1'b1;
                                                player1_status <= player1_status - 1'b1;
                                                
                                                top1 <= 10'd192; 
                                                left1 <= 10'd128;
                                                ucontrolb2 <= 0;
                                                left_b_1 <= 10'd96 ; top_b_1 <= 10'd16;
                                                left_b_2 <= 10'd96 ; top_b_2 <= 10'd16;
                                                readyToMove2 <= 0;
                                            end
                                        else
                                            begin
                                                ucontrolb2 <= ucontrolb2 + 2;
                                                if( ucontrolb2 == 60 )
                                                begin
                                                    moveb <= moveb + 1 ;
                                                        if(moveb == 1)
                                                            top_b_2 <= top_b_2  - 1;        
                                                        ucontrolb2 <= 0;
                                                end
                                            end
                                    end
                            end
                        else if( (left_b_2 > 111)  &&  directionBullet2 == 1)
                            begin
                               if( x == left_b_2 - 1 && y >= top_b_2 && y < top_b_2 + 2  )
                                   begin
                                       if( visible[(x-96)/16][(y-16)/16] )
                                       begin
                                            if( visible[(x-96)/16][(y-16)/16] == visible[1][7])
                                             begin
                                                 player2_status[4] <= 1'b1;
                                                 player2_status[5] <= 1'b1;
                                                 player2_status[6] <= 1'b1;
                                             end
                                            if( ~(broken[(x-96)/16][(y-16)/16] == 2))
                                              broken[(x-96)/16][(y-16)/16] <= broken[(x-96)/16][(y-16)/16] + 1;
                                            
                                              
                                            lcontrolb2 <= 0;
                                            
                                            left_b_2 <= 10'd96 ; top_b_2 <= 10'd16;
                                            readyToMove2 <= 0;
                                       end
                                       else if(  left1 == left_b_2 - 1 && top1 < top_b_2 && top_b_2 < top1 + 17)
                                           begin 
                                                if( player2_status[4] == 1'b0)
                                                   player2_status[4] <= 1'b1;
                                               else if( player2_status[5] == 1'b0)
                                                   player2_status[5] <= 1'b1;
                                               else
                                                   player2_status[6] <= 1'b1;
                                               player1_status <= player1_status - 1'b1;
                                               top1 <= 10'd192; 
                                               left1 <= 10'd128;
                                               lcontrolb2 <= 0;
                                               left_b_1 <= 10'd96 ; top_b_1 <= 10'd16;
                                               left_b_2 <= 10'd96 ; top_b_2 <= 10'd16;
                                               readyToMove2 <= 0;
                                           end
                                       else
                                            begin
                                                lcontrolb2 <= lcontrolb2 + 2;
                                                if( lcontrolb2 == 60 )
                                                    begin
                                                        moveb <= moveb + 1 ;
                                                        if( moveb == 1)
                                                            left_b_2 <= left_b_2 - 1;
                                                        lcontrolb2 <= 0;
                                                     end
                                            end
                                   end
                            end
                        else if( (top_b_2 < 239)  && directionBullet2 == 2)
                            begin
                               if( x >= left_b_2 && x < left_b_2 + 2 && y == top_b_2 + 2 )
                                   begin
                                       if( visible[(x-96)/16][(y-16)/16] )
                                           begin
                                                if(visible[(x-96)/16][(y-16)/16] == visible[1][7])
                                                                                               begin
                                                                                                   player2_status[4] <= 1'b1;
                                                                                                   player2_status[5] <= 1'b1;
                                                                                                   player2_status[6] <= 1'b1;
                                                                                               end
                                                if( ~(broken[(x-96)/16][(y-16)/16] == 2))
                                                    broken[(x-96)/16][(y-16)/16] <= broken[(x-96)/16][(y-16)/16] + 1;
                                                
                                                dcontrolb2 <= 0;
                                                left_b_2 <= 10'd96 ; top_b_2 <= 10'd16;
                                                readyToMove2 <= 0;
                                           end
                                       else if(  top1 == top_b_2 + 1 && left1 < left_b_2 && left_b_2 < left1 + 17)
                                          begin 
                                                if( player2_status[4] == 1'b0)
                                                     player2_status[4] <= 1'b1;
                                                 else if( player2_status[5] == 1'b0)
                                                     player2_status[5] <= 1'b1;
                                                 else
                                                     player2_status[6] <= 1'b1;
                                                 player1_status <= player1_status - 1'b1;
                                              top1 <= 10'd192; 
                                              left1 <= 10'd128;
                                              dcontrolb2 <= 0;
                                              left_b_1 <= 10'd96 ; top_b_1 <= 10'd16;
                                              left_b_2 <= 10'd96 ; top_b_2 <= 10'd16;
                                              readyToMove2 <= 0;
                                          end
                                       else
                                       begin
                                           dcontrolb2 <= dcontrolb2 + 2;
                                           if( dcontrolb2 == 60 )
                                           begin
                                               moveb <= moveb + 1 ;
                                               if(moveb == 1)
                                                   top_b_2 <= top_b_2 + 1; 
                                               dcontrolb2 <= 0;
                                           end
                                       end
                                   end
                            end
                        else if( (left_b_2 < 319)  && directionBullet2 == 0)
                            begin
                               if( x == left_b_2 + 2 && y >= top_b_2 && y < top_b_2 + 2 )
                                    begin
                                        if( visible[(x-96)/16][(y-16)/16] )
                                            begin
                                                if( visible[(x-96)/16][(y-16)/16] == visible[1][7])
                                                    begin
                                                        player2_status[4] <= 1'b1;
                                                        player2_status[5] <= 1'b1;
                                                        player2_status[6] <= 1'b1;
                                                    end
                                                if( ~(broken[(x-96)/16][(y-16)/16] == 2))
                                                    broken[(x-96)/16][(y-16)/16] <= broken[(x-96)/16][(y-16)/16] + 1; 
                                                
                                                rcontrolb2 <= 0;
                                                left_b_2 <= 10'd96 ; top_b_2 <= 10'd16;
                                                readyToMove2 <= 0;
                                            end
            
                                        else if(  left1 == left_b_2 + 1 && top1 < top_b_2 && top_b_2 < top1 + 17)
                                           begin 
                                               if( player2_status[4] == 1'b0)
                                                  player2_status[4] <= 1'b1;
                                              else if( player2_status[5] == 1'b0)
                                                  player2_status[5] <= 1'b1;
                                              else
                                                  player2_status[6] <= 1'b1;
                                              player1_status <= player1_status - 1'b1;
                                               top1 <= 10'd192; 
                                               left1 <= 10'd128;
                                               rcontrolb2 <= 0;
                                               left_b_1 <= 10'd96 ; top_b_1 <= 10'd16;
                                               left_b_2 <= 10'd96 ; top_b_2 <= 10'd16;
                                               readyToMove2 <= 0;
                                           end
                                        else
                                        begin
                                            rcontrolb2 <= rcontrolb2 + 2;
                                            if( rcontrolb2 == 60 )
                                            begin
                                                moveb <= moveb + 1 ;
                                                if(moveb == 1)
                                                    left_b_2 <= left_b_2 + 1;
                                                rcontrolb2 <=0; 
                                            end
                                        end
                                               
                                    end
                             end
                        else
                            begin
                                left_b_2 <= 10'd96 ; top_b_2 <= 10'd16;
                                readyToMove2 <= 0;
                            end
                    end
            
     end
    
    
    //Red Tank
    TankGen tankgenR( x , y, left1, top1 , directionRed, colorR[3:0], intankR );
    //Green Tank
    TankGen tankgenG( x, y, left2, top2, directionGreen, colorG[3:0], intankG );



    assign r = ~inblock ? ( intankR ? ( colorR) : ( ~inbullet[0] ? ( ~inbullet[1] ? ( visible[(x-96)/16][(y-16)/16] ? color[(x-96)/16][(y-16)/16][11:8] :  ( statusvisible[(x-350)/8][(y-60)/8] ? statuscolor[(x-350)/8][(y-60)/8][11:8] :  4'b0) ) : {4{colorBullet[1]}} ) :  {4{colorBullet[0]}}  )) : redBlock;

    assign g = ~inblock ? ( intankG ? ( colorG) : ( ~inbullet[0] ? ( ~inbullet[1] ? ( visible[(x-96)/16][(y-16)/16] ? color[(x-96)/16][(y-16)/16][7:4] : ( statusvisible[(x-350)/8][(y-60)/8] ? statuscolor[(x-350)/8][(y-60)/8][7:4] :  4'b0) ) : {4{colorBullet[1]}} ) :  {4{colorBullet[0]}}  )) : greenBlock;

    assign b = ~inblock ? ( ~inbullet[0] ? ( ~inbullet[1] ? ( visible[(x-96)/16][(y-16)/16] ?  color[(x-96)/16][(y-16)/16][3:0] : ( statusvisible[(x-350)/8][(y-60)/8] ? statuscolor[(x-350)/8][(y-60)/8][3:0] :  4'b0) ) : {4{colorBullet[1]}} ) :  {4{colorBullet[0]}}  ) : blueBlock;   
         
endmodule

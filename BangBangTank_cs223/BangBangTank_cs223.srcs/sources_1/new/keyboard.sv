`timescale 1ns / 1ps
// 4x4 keyboard in Beti-board by Mehmet Baray. It is edited for this project


module BetiKeyboard(
    input  clk,
    input  rst,
    input logic [3:0] rowin,
    output logic [3:0] column,
    output logic [3:0] char1,
    output hata1
    );
parameter N=3; 
logic [N:0] counter;

logic [3:0] row,colbuf,chr;

logic hata;

logic [3:0] rowbuf1,rowbuf2,rowbuf3,rowbuf4;
assign column=colbuf;
assign char1=chr;
assign hata1=hata;
always_ff @(posedge clk, posedge rst)
if (rst) 
counter<=0;
else
 counter<=counter+1;

assign row=rowin;
 assign colbuf[0]=~counter[N]&~counter[N-1];
 assign colbuf[1]=~counter[N]&counter[N-1];
 assign colbuf[2]=counter[N]&~counter[N-1];
 assign colbuf[3]=counter[N]&counter[N-1];

always_ff @(posedge clk)
if(colbuf==4'b0001)
	case(row)
	
	4'b0001: begin hata<=0; chr[3:0]<=4'b0001;end
	4'b0010: begin  hata=0; chr[3:0]<=4'b0100;end
	4'b0100: begin  hata<=0; chr[3:0]<=4'b0111;end
	4'b1000: begin  hata<=0; chr[3:0]<=4'b1110;end
    default: begin hata<=1; chr[3:0]<=4'b0000; end
	endcase

  else if(colbuf==4'b0010) 
	case(row)
	4'b0010: begin  hata<=0; chr[3:0]<=4'b0101;end
    default: begin hata<=1; chr[3:0]<=4'b0000; end
	endcase	
	
	

endmodule

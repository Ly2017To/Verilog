module rx_cordic (
  input nd,
  input clk,
  input sclr,
  input signed [15 : 0] x_in,
  input signed [15 : 0] y_in,
  output rdy,
  output signed [15 : 0] x_out,
  output signed [15 : 0] phase_out
);

parameter DATAIN_WIDTH = 16;

/*
parameter DATAIN_WIDTH = 32;
parameter signed angle_0 = 32'd2949120;		//45 degree *2^16
parameter signed angle_1 = 32'd1740992;     //26.5651 degree *2^16
parameter signed angle_2 = 32'd919872;      //14.0362 degree *2^16
parameter signed angle_3 = 32'd466944;      //7.1250 degree *2^16
parameter signed angle_4 = 32'd234368;      //3.5763 degree *2^16
parameter signed angle_5 = 32'd117312;      //1.7899 degree *2^16
parameter signed angle_6 = 32'd58688;       //0.8952 degree *2^16
parameter signed angle_7 = 32'd29312;       //0.4476 degree *2^16
parameter signed angle_8 = 32'd14656;       //0.2238 degree *2^16
parameter signed angle_9 = 32'd7360;        //0.1119 degree *2^16
parameter signed angle_10 = 32'd3648;       //0.0560 degree *2^16
parameter signed angle_11 = 32'd1856;	    //0.0280 degree *2^16
parameter signed angle_12 = 32'd896;        //0.0140 degree *2^16
parameter signed angle_13 = 32'd448;        //0.0070 degree *2^16
parameter signed angle_14 = 32'd256;        //0.0035 degree *2^16
parameter signed angle_15 = 32'd128;        //0.0018 degree *2^16
*/

/*
parameter signed angle_0 = 18'd51472;		//7.85398163e-0 radius *2^16 = 5.14718540e+04
parameter signed angle_1 = 18'd30386;       //4.63647609e-01 radius *2^16 = 3.03856097e+04
parameter signed angle_2 = 18'd16055;       //2.44978663e-01 radius *2^16 = 1.60549217e+04
parameter signed angle_3 = 18'd8150;        //1.24354995e-01 radius *2^16 = 8.14972892e+03
parameter signed angle_4 = 18'd4091;        //6.24188100e-02 radius *2^16 = 4.09067913e+03
parameter signed angle_5 = 18'd2047;        //3.12398334e-02 radius *2^16 = 2.04733372e+03
parameter signed angle_6 = 18'd1024;        //1.56237286e-02 radius *2^16 = 1.02391668e+03
parameter signed angle_7 = 18'd512;         //7.81234106e-03 radius *2^16 = 5.11989584e+02
parameter signed angle_8 = 18'd256;         //3.90623013e-03 radius *2^16 = 2.55998698e+02
parameter signed angle_9 = 18'd128;         //1.95312252e-03 radius *2^16 = 1.27999837e+02
parameter signed angle_10 = 18'd64;         //9.76562190e-04 radius *2^16 = 6.39999797e+01
parameter signed angle_11 = 18'd32;	        //4.88281211e-04 radius *2^16 = 3.19999975e+01
parameter signed angle_12 = 18'd16;         //2.44140620e-04 radius *2^16 = 1.59999997e+01
parameter signed angle_13 = 18'd8;          //1.22070312e-04 degree *2^16 = 7.99999996e+00
parameter signed angle_14 = 18'd4;          //6.10351562e-05 degree *2^16 = 4.00000000e+00
parameter signed angle_15 = 18'd2;          //3.05175781e-05 degree *2^16 = 2.00000000e+00
*/

parameter signed angle_0 = 16'd6434;	   //7.85398163e-0 radius *2^13 = 6.434e+03
parameter signed angle_1 = 16'd3798;       //4.63647609e-01 radius *2^13 = 3.798e+03
parameter signed angle_2 = 16'd2007;       //2.44978663e-01 radius *2^13 = 2.007e+03
parameter signed angle_3 = 16'd1019;       //1.24354995e-01 radius *2^13 = 1.019e+03
parameter signed angle_4 = 16'd511;        //6.24188100e-02 radius *2^13 = 5.110e+02
parameter signed angle_5 = 16'd256;        //3.12398334e-02 radius *2^13 = 2.560e+02
parameter signed angle_6 = 16'd128;        //1.56237286e-02 radius *2^13 = 1.280e+02
parameter signed angle_7 = 16'd64;         //7.81234106e-03 radius *2^13 = 6.400e+01     
parameter signed angle_8 = 16'd32;         //3.90623013e-03 radius *2^13 = 3.200e+01
parameter signed angle_9 = 16'd16;         //1.95312252e-03 radius *2^13 = 1.600e+01
parameter signed angle_10 = 16'd8;         //9.76562190e-04 radius *2^13 = 8.000e+00
parameter signed angle_11 = 16'd4;	       //4.88281211e-04 radius *2^13 = 4.000e+00
parameter signed angle_12 = 16'd2;         //2.44140620e-04 radius *2^13 = 2.000e+00 
parameter signed angle_13 = 16'd1;         //1.22070312e-04 degree *2^13 = 1.000e+00

parameter signed angle_shift = 16'd12868;   //1.5707963267948966 degree * 2^13

reg signed 	[DATAIN_WIDTH-1:0] 		x0 =0,y0 =0,z0 =0;
reg signed 	[DATAIN_WIDTH-1:0] 		x1 =0,y1 =0,z1 =0;
reg signed 	[DATAIN_WIDTH-1:0] 		x2 =0,y2 =0,z2 =0;
reg signed 	[DATAIN_WIDTH-1:0] 		x3 =0,y3 =0,z3 =0;
reg signed 	[DATAIN_WIDTH-1:0] 		x4 =0,y4 =0,z4 =0;
reg signed 	[DATAIN_WIDTH-1:0] 		x5 =0,y5 =0,z5 =0;
reg signed 	[DATAIN_WIDTH-1:0] 		x6 =0,y6 =0,z6 =0;
reg signed 	[DATAIN_WIDTH-1:0] 		x7 =0,y7 =0,z7 =0;
reg signed 	[DATAIN_WIDTH-1:0] 		x8 =0,y8 =0,z8 =0;
reg signed 	[DATAIN_WIDTH-1:0] 		x9 =0,y9 =0,z9 =0;
reg signed 	[DATAIN_WIDTH-1:0] 		x10=0,y10=0,z10=0;
reg signed 	[DATAIN_WIDTH-1:0] 		x11=0,y11=0,z11=0;
reg signed 	[DATAIN_WIDTH-1:0] 		x12=0,y12=0,z12=0;
reg signed 	[DATAIN_WIDTH-1:0] 		x13=0,y13=0,z13=0;

/*
reg signed 	[DATAIN_WIDTH-1:0] 		x14=0,y14=0,z14=0;
reg signed 	[DATAIN_WIDTH-1:0] 		x15=0,y15=0,z15=0;
reg signed 	[DATAIN_WIDTH-1:0] 		x16=0,y16=0,z16=0;
*/

wire [1:0] quadrant ;
assign quadrant = {x_in[15], y_in[15]};

//initialization
//to make the phase between -PI and PI

reg step0_rdy = 1'b0;

always @(posedge clk) step0_rdy <= nd;

always@(posedge clk or posedge sclr)
begin
	if(sclr)
	begin
		x0 <= 'b0;
		y0 <= 'b0;
		z0 <= 'b0;
		
	end
	else if(nd)
	begin
		case(quadrant)
			2'b10: //the second quadrant
			begin
				x0 <= y_in;
				y0 <= -x_in;
				z0 <= angle_shift;
			end
			
			2'b11: //the third quadrant
			begin
				x0 <= -y_in;
				y0 <= x_in;
				z0 <= -angle_shift;
			end

			default: //the first and the fourth quadrant
			begin
				x0 <= x_in;
				y0 <= y_in;
				z0 <= 'b0;
			end
		endcase
	end
end 

//iteration 1

reg step1_rdy = 1'b0;

always @(posedge clk) step1_rdy <= step0_rdy;

always@(posedge clk or posedge sclr)
begin
	if(sclr)
	begin
		x1 <= 'b0;
		y1 <= 'b0;
		z1 <= 'b0;
	end
	else if(y0[DATAIN_WIDTH-1]) 
	begin
		x1 <= x0 - y0;
		y1 <= y0 + x0;
		z1 <= z0 - angle_0;	
	end
	else 
	begin
		x1 <= x0 + y0;
		y1 <= y0 - x0;
		z1 <= z0 + angle_0;		
	end
end 

//iteration 2

reg step2_rdy = 1'b0;

always @(posedge clk) step2_rdy <= step1_rdy;

always@(posedge clk or posedge sclr)
begin
	if(sclr)
	begin
		x2 <= 'b0;
		y2 <= 'b0;
		z2 <= 'b0;
	end
	else if(y1[DATAIN_WIDTH-1]) 
	begin
		x2 <= x1 - (y1>>>1);
		y2 <= y1 + (x1>>>1);
		z2 <= z1 - angle_1;	
	end
	else 
	begin
		x2 <= x1 + (y1>>>1);
		y2 <= y1 - (x1>>>1);
		z2 <= z1 + angle_1;
	end
end 

//iteration 3

reg step3_rdy = 1'b0;

always @(posedge clk) step3_rdy <= step2_rdy;

always@(posedge clk or posedge sclr)
begin
	if(sclr)
	begin
		x3 <= 'b0;
		y3 <= 'b0;
		z3 <= 'b0;
	end
	else if(y2[DATAIN_WIDTH-1])
	begin
		x3 <= x2 - (y2>>>2);
		y3 <= y2 + (x2>>>2);
		z3 <= z2 - angle_2;	
	end
	else 
	begin
		x3 <= x2 + (y2>>>2);
		y3 <= y2 - (x2>>>2);
		z3 <= z2 + angle_2;
	end
end 

//iteration 4

reg step4_rdy = 1'b0;

always @(posedge clk) step4_rdy <= step3_rdy;

always@(posedge clk or posedge sclr)
begin
	if(sclr)
	begin
		x4 <= 'b0;
		y4 <= 'b0;
		z4 <= 'b0;
	end
	else if(y3[DATAIN_WIDTH-1]) 
	begin
		x4 <= x3 - (y3>>>3);
		y4 <= y3 + (x3>>>3);
		z4 <= z3 - angle_3;	
	end
	else 
	begin
		x4 <= x3 + (y3>>>3);
		y4 <= y3 - (x3>>>3);
		z4 <= z3 + angle_3;
	end
end 

//iteration 5

reg step5_rdy = 1'b0;

always @(posedge clk) step5_rdy <= step4_rdy;

always@(posedge clk or posedge sclr)
begin
	if(sclr)
	begin
		x5 <= 'b0;
		y5 <= 'b0;
		z5 <= 'b0;
	end
	else if(y4[DATAIN_WIDTH-1]) 
	begin
		x5 <= x4 - (y4>>>4);
		y5 <= y4 + (x4>>>4);
		z5 <= z4 - angle_4;	
	end
	else
	begin
		x5 <= x4 + (y4>>>4);
		y5 <= y4 - (x4>>>4);
		z5 <= z4 + angle_4;
	end
end 

//iteration 6

reg step6_rdy = 1'b0;

always @(posedge clk) step6_rdy <= step5_rdy;

always@(posedge clk or posedge sclr)
begin
	if(sclr)
	begin
		x6 <= 'b0;
		y6 <= 'b0;
		z6 <= 'b0;
	end
	else if(y5[DATAIN_WIDTH-1]) 
	begin
		x6 <= x5 - (y5>>>5);
		y6 <= y5 + (x5>>>5);
		z6 <= z5 - angle_5;
	end
	else 
	begin
		x6 <= x5 + (y5>>>5);
		y6 <= y5 - (x5>>>5);
		z6 <= z5 + angle_5;
	end
end 

//iteration 7

reg step7_rdy = 1'b0;

always @(posedge clk) step7_rdy <= step6_rdy;

always@(posedge clk or posedge sclr)
begin
	if(sclr)
	begin
		x7 <= 'b0;
		y7 <= 'b0;
		z7 <= 'b0;
	end
	else if(y6[DATAIN_WIDTH-1]) 
	begin
		x7 <= x6 - (y6>>>6);
		y7 <= y6 + (x6>>>6);
		z7 <= z6 - angle_6;	
	end
	else 
	begin
		x7 <= x6 + (y6>>>6);
		y7 <= y6 - (x6>>>6);
		z7 <= z6 + angle_6;
	end
end 

//iteration 8

reg step8_rdy = 1'b0;

always @(posedge clk) step8_rdy <= step7_rdy;

always@(posedge clk or posedge sclr)
begin
	if(sclr)
	begin
		x8 <= 'b0;
		y8 <= 'b0;
		z8 <= 'b0;
	end
	else if(y7[DATAIN_WIDTH-1]) 
	begin
		x8 <= x7 - (y7>>>7);
		y8 <= y7 + (x7>>>7);
		z8 <= z7 - angle_7;	
	end
	else 
	begin
		x8 <= x7 + (y7>>>7);
		y8 <= y7 - (x7>>>7);
		z8 <= z7 + angle_7;
	end
end 

//iteration 9

reg step9_rdy = 1'b0;

always @(posedge clk) step9_rdy <= step8_rdy;

always@(posedge clk or posedge sclr)
begin
	if(sclr)
	begin
		x9 <= 'b0;
		y9 <= 'b0;
		z9 <= 'b0;
	end
	else if(y8[DATAIN_WIDTH-1])
	begin
		x9 <= x8 - (y8>>>8);
		y9 <= y8 + (x8>>>8);
		z9 <= z8 - angle_8;
	end
	else 
	begin
		x9 <= x8 + (y8>>>8);
		y9 <= y8 - (x8>>>8);
		z9 <= z8 + angle_8;
	end
end 

//iteration 10

reg step10_rdy = 1'b0;

always @(posedge clk) step10_rdy <= step9_rdy;

always@(posedge clk or posedge sclr)
begin
	if(sclr)
	begin
		x10 <= 'b0;
		y10 <= 'b0;
		z10 <= 'b0;
	end
	else if(y9[DATAIN_WIDTH-1]) 
	begin
		x10 <= x9 - (y9>>>9);
		y10 <= y9 + (x9>>>9);
		z10 <= z9 - angle_9;
	end
	else 
	begin
		x10 <= x9 + (y9>>>9);
		y10 <= y9 - (x9>>>9);
		z10 <= z9 + angle_9;		
	end
end 

//iteration 11

reg step11_rdy = 1'b0;

always @(posedge clk) step11_rdy <= step10_rdy;

always@(posedge clk or posedge sclr)
begin
	if(sclr)
	begin
		x11 <= 'b0;
		y11 <= 'b0;
		z11 <= 'b0;
	end
	else if(y10[DATAIN_WIDTH-1]) 
	begin
		x11 <= x10 - (y10>>>10);
		y11 <= y10 + (x10>>>10);
		z11 <= z10 - angle_10;	
	end
	else 
	begin
		x11 <= x10 + (y10>>>10);
		y11 <= y10 - (x10>>>10);
		z11 <= z10 + angle_10;
	end
end 

//iteration 12

reg step12_rdy = 1'b0;

always @(posedge clk) step12_rdy <= step11_rdy;

always@(posedge clk or posedge sclr)
begin
	if(sclr)
	begin
		x12 <= 'b0;
		y12 <= 'b0;
		z12 <= 'b0;
	end
	else if(y11[DATAIN_WIDTH-1]) 
	begin
		x12 <= x11 - (y11>>>11);
		y12 <= y11 + (x11>>>11);
		z12 <= z11 - angle_11;	
	end
	else 
	begin
		x12 <= x11 + (y11>>>11);
		y12 <= y11 - (x11>>>11);
		z12 <= z11 + angle_11;
	end
end 

//iteration 13

reg step13_rdy = 1'b0;

always @(posedge clk) step13_rdy <= step12_rdy;

always@(posedge clk or posedge sclr)
begin
	if(sclr)
	begin
		x13 <= 'b0;
		y13 <= 'b0;
		z13 <= 'b0;
	end
	else if(y12[DATAIN_WIDTH-1]) 
	begin
		x13 <= x12 - (y12>>>12);
		y13 <= y12 + (x12>>>12);
		z13 <= z12 - angle_12;	
	end
	else 
	begin
		x13 <= x12 + (y12>>>12);
		y13 <= y12 - (x12>>>12);
		z13 <= z12 + angle_12;
	end
end 

/*
//iteration 14
always@(posedge clk or posedge sclr)
begin
	if(sclr)
	begin
		x14 <= 'b0;
		y14 <= 'b0;
		z14 <= 'b0;
	end
	else if(y13[DATAIN_WIDTH-1]) 
	begin
		x14 <= x13 - (y13>>>13);
		y14 <= y13 + (x13>>>13);
		z14 <= z13 - angle_13;	
	end
	else 
	begin
		x14 <= x13 + (y13>>>13);
		y14 <= y13 - (x13>>>13);
		z14 <= z13 + angle_13;
	end
end 

//iteration 15
always@(posedge clk or posedge sclr)
begin
	if(sclr)
	begin
		x15 <= 'b0;
		y15 <= 'b0;
		z15 <= 'b0;
	end
	else if(y14[DATAIN_WIDTH-1]) 
	begin
		x15 <= x14 - (y14>>>14);
		y15 <= y14 + (x14>>>14);
		z15 <= z14 - angle_14;	
	end
	else 
	begin
		x15 <= x14 + (y14>>>14);
		y15 <= y14 - (x14>>>14);
		z15 <= z14 + angle_14;
	end
end 

//iteration 16
always@(posedge clk or posedge sclr)
begin
	if(sclr)
	begin
		x16 <= 'b0;
		y16 <= 'b0;
		z16 <= 'b0;
	end
	else if(y15[DATAIN_WIDTH-1])
	begin
		x16 <= x15 - (y15>>>15);
		y16 <= y15 + (x15>>>15);
		z16 <= z15 - angle_15;	
	end
	else 
	begin
		x16 <= x15 + (y15>>>15);
		y16 <= y15 - (x15>>>15);
		z16 <= z15 + angle_15;
	end
end
*/ 

reg signed [DATAIN_WIDTH-1:0] mag;
reg signed [DATAIN_WIDTH-1:0] phase; 

reg step14_rdy = 1'b0;

always @(posedge clk) step14_rdy <= step13_rdy;

always@(posedge clk or posedge sclr)
begin
	if(sclr)
	begin
		mag <= 'b0;
		phase <= 'b0;
	end
	else 
	begin
        mag <= x13; //K linear factor ignored here
        phase <= z13;
	end
end 

assign x_out = mag;
assign phase_out = phase;
assign rdy = step14_rdy;

endmodule

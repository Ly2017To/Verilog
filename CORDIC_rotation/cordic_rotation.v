`timescale 1ns/1ps

module cordic_rotation (
  input nd,
  input clk,
  input sclr,
  input signed [15 : 0] x_in,
  input signed [15 : 0] y_in,
  input signed [15 : 0] phase_in,
  output rdy,
  output signed [15 : 0] x_out,
  output signed [15 : 0] y_out
);

parameter DATAIN_WIDTH = 16;

//not scaled
parameter signed angle_0 = 16'sd6434;	   //7.85398163e-0 radius *2^13 (scaled) = 6.434e+03
parameter signed angle_1 = 16'sd3798;       //4.63647609e-01 radius *2^13 (scaled)= 3.798e+03
parameter signed angle_2 = 16'sd2007;       //2.44978663e-01 radius *2^13 (scaled) = 2.007e+03
parameter signed angle_3 = 16'sd1019;       //1.24354995e-01 radius *2^13 (scaled) = 1.019e+03
parameter signed angle_4 = 16'sd511;        //6.24188100e-02 radius *2^13 (scaled) = 5.110e+02
parameter signed angle_5 = 16'sd256;        //3.12398334e-02 radius *2^13 (scaled) = 2.560e+02
parameter signed angle_6 = 16'sd128;        //1.56237286e-02 radius *2^13 (scaled) = 1.280e+02
parameter signed angle_7 = 16'sd64;         //7.81234106e-03 radius *2^13 (scaled) = 6.400e+01    
parameter signed angle_8 = 16'sd32;         //3.90623013e-03 radius *2^13 (scaled) = 3.200e+01
parameter signed angle_9 = 16'sd16;         //1.95312252e-03 radius *2^13 (scaled) = 1.600e+01
parameter signed angle_10 = 16'sd8;         //9.76562190e-04 radius *2^13 (scaled) = 8.000e+00
parameter signed angle_11 = 16'sd4;	       //4.88281211e-04 radius *2^13 (scaled)= 4.000e+00
parameter signed angle_12 = 16'sd2;          //2.44140625e-04 radius *2^13 = 2.000e+00
parameter signed angle_half_pi = 16'sd12868;   //1.5707963267948966 radius * 2^13 = 12867.963509103793
parameter signed angle_half_pi_minus = -16'sd12868;   //1.5707963267948966 radius * 2^13 = 12867.963509103793

/*
//scaled
parameter signed angle_0 = 16'sd2048;	   //7.85398163e-0 radius *2^13 (scaled) = 2.04800581e+03
parameter signed angle_1 = 16'sd1209;       //4.63647609e-01 radius *2^13 (scaled)= 1.20894095e+03
parameter signed angle_2 = 16'sd639;       //2.44978663e-01 radius *2^13 (scaled) = 6.38847942e+02
parameter signed angle_3 = 16'sd324;       //1.24354995e-01 radius *2^13 (scaled) = 3.24357774e+02
parameter signed angle_4 = 16'sd163;        //6.24188100e-02 radius *2^13 (scaled) = 1.62656352e+02
parameter signed angle_5 = 16'sd81;        //3.12398334e-02 radius *2^13 (scaled) = 8.14873309e+01
parameter signed angle_6 = 16'sd41;        //1.56237286e-02 radius *2^13 (scaled) = 4.07436654e+01
parameter signed angle_7 = 16'sd20;         //7.81234106e-03 radius *2^13 (scaled) = 2.03718327e+01    
parameter signed angle_8 = 16'sd10;         //3.90623013e-03 radius *2^13 (scaled) = 1.01859164e+01
parameter signed angle_9 = 16'sd5;         //1.95312252e-03 radius *2^13 (scaled) = 5.09295818e+00
parameter signed angle_10 = 16'sd3;         //9.76562190e-04 radius *2^13 (scaled) = 2.54647909e+00
parameter signed angle_11 = 16'sd1;	       //4.88281211e-04 radius *2^13 (scaled)= 1.27323954e+00
parameter signed angle_half_pi = 16'sd4096;   //1.5707963267948966 radius * 2^13 (scale)
parameter signed angle_half_pi_minus = -16'sd4096;   //1.5707963267948966 radius * 2^13 (scale)
*/ 

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

reg [1:0] rotate ; //a register to 

always@(posedge clk or posedge sclr)
begin
	if(sclr)
	begin
        rotate <= 'b0;		
	end
	else if(nd)
	begin
		rotate[0] <= phase_in > angle_half_pi ? 1:0; //phase_in is larger than pi/2
		rotate[1] <= phase_in < angle_half_pi_minus ? 1:0; //phase_in is smaller than -pi/2
	end
end 

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
	else if(step0_rdy)
	begin
		case(rotate)
			2'b01: //phase_in is larger than pi/2
			begin
				x0 <= -y_in;
				y0 <= x_in;
				z0 <= phase_in - angle_half_pi;
			end
			
			2'b10: //phase_in is smaller than -pi/2
			begin
				x0 <= y_in;
				y0 <= -x_in;
				z0 <= phase_in + angle_half_pi;
			end

			default: //phase_in is between -pi/2 and pi/2
			begin
				x0 <= x_in;
				y0 <= y_in;
				z0 <= phase_in;
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
	else if(!z0[DATAIN_WIDTH-1]) 
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
	else if(!z1[DATAIN_WIDTH-1]) 
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
	else if(!z2[DATAIN_WIDTH-1])
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
	else if(!z3[DATAIN_WIDTH-1]) 
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
	else if(!z4[DATAIN_WIDTH-1]) 
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
	else if(!z5[DATAIN_WIDTH-1]) 
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
	else if(!z6[DATAIN_WIDTH-1]) 
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
	else if(!z7[DATAIN_WIDTH-1]) 
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
	else if(!z8[DATAIN_WIDTH-1])
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
	else if(!z9[DATAIN_WIDTH-1]) 
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
	else if(!z10[DATAIN_WIDTH-1]) 
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
	else if(!z11[DATAIN_WIDTH-1]) 
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
	else if(!z12[DATAIN_WIDTH-1]) 
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

reg signed [DATAIN_WIDTH-1:0] x_output;
reg signed [DATAIN_WIDTH-1:0] y_output; 

reg step_rdy = 1'b0;

always@(posedge clk or posedge sclr)
begin
	if(sclr)
	begin
		x_output <= 'b0;
		y_output <= 'b0;
		step_rdy <= 'b0;
	end
	else 
	begin
        x_output <= x13;
        y_output <= y13;
		step_rdy <= step13_rdy;
	end
end 

assign x_out = x_output;
assign y_out = y_output;
assign rdy = step_rdy;

endmodule

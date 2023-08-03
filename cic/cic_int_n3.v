`timescale 1ns/1ps

//The structure of an interpolation CIC filter consists of combs, interpolator and integrators
//The number of bits of output data equals log2((R*D)^N/R) plus the number of bits of input data
//This module implements an interpolation CIC filter with 3 stages, 1 differential delay and rate 8

module cic_int_n3    
	#(parameter INPUT_WIDTH  = 15,
	parameter OUTPUT_WIDTH = 21,
	parameter INTERPOLATION_RATE = 8)
	(
	input clk,
	input rst,
	input nd,
	input signed [INPUT_WIDTH-1:0] din,
	output signed [OUTPUT_WIDTH-1:0] dout,
	output rdy);

//input data as wire
wire [OUTPUT_WIDTH-1:0] cic_in = {{(OUTPUT_WIDTH-INPUT_WIDTH){din[INPUT_WIDTH-1]}}, din} ;

//comb section
//number of stages: 3
	
//registers
reg signed [OUTPUT_WIDTH-1:0] c_1;
reg signed [OUTPUT_WIDTH-1:0] c_1_d;
reg signed [OUTPUT_WIDTH-1:0] c_2;
reg signed [OUTPUT_WIDTH-1:0] c_2_d;
reg signed [OUTPUT_WIDTH-1:0] c_3;
reg signed [OUTPUT_WIDTH-1:0] c_3_d; 
reg signed [OUTPUT_WIDTH-1:0] c_out; 

always @(posedge clk or posedge rst)
begin
	if (rst) 
	begin
		c_1 <= 'b0;
		c_1_d <= 'b0;
		c_2 <= 'b0;
		c_2_d <= 'b0;
		c_3 <= 'b0;
		c_3_d <= 'b0;
		c_out <= 'b0;
	end
	else if (nd)
	begin
		c_1 <= cic_in;
		c_1_d <= c_1;
		c_2 <= c_1 - c_1_d;
		c_2_d <= c_2;
		c_3 <= c_2 - c_2_d;
		c_3_d <= c_3;
		c_out <= c_3 - c_3_d;
	end
	else 
	begin
		c_out <= 'b0; //upsampling by inserting 0
	end
end
	
//integrator section
//number of stages: 3
//the widith should be the same as the widith of dout
reg signed [OUTPUT_WIDTH-1:0] i_1;
reg signed [OUTPUT_WIDTH-1:0] i_2; 
reg signed [OUTPUT_WIDTH-1:0] i_3;
reg cic_rdy; 

always @(posedge clk or posedge rst) 
begin
	if(rst) 
	begin
		i_1 <= 'b0;
		i_2 <= 'b0;
		i_3 <= 'b0;
		cic_rdy <= 1'b0;
	end 
	else
	begin
		i_1 <= i_1 + c_out;
		i_2 <= i_1 + i_2;
		i_3 <= i_2 + i_3;
		cic_rdy <= 1'b1;
	end
end

assign rdy = cic_rdy;
assign dout = i_3;
	
endmodule
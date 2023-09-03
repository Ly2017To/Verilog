`timescale 1ns/1ps

//The structure of a decimation CIC filter consists of integrators, a decimator and combs
//The number of bits of output data equals N*log2(R*D) plus the number of bits of input data
//This module implements a decimation CIC filter with 5 stages, 2 differential delay and rate 12

module cic_dec_n5    
	#(parameter INPUT_WIDTH  = 15,
	parameter OUTPUT_WIDTH = 38,
	parameter DECIMATION_RATE = 12)
	(
	input clk,
	input rst,
	input nd,
	input signed [INPUT_WIDTH-1:0] din,
	output signed [OUTPUT_WIDTH-1:0] dout,
	output rdy);

//integrator section
//number of stages: 5

//input data as wire
wire [OUTPUT_WIDTH-1:0] cic_in = {{(OUTPUT_WIDTH-INPUT_WIDTH){din[INPUT_WIDTH-1]}}, din} ;

//registers
//the widith should be the same as the widith of dout
reg signed [OUTPUT_WIDTH-1:0] i_1;
reg signed [OUTPUT_WIDTH-1:0] i_2; 
reg signed [OUTPUT_WIDTH-1:0] i_3; 
reg signed [OUTPUT_WIDTH-1:0] i_4;
reg signed [OUTPUT_WIDTH-1:0] i_5;

always @(posedge clk or posedge rst) 
begin
	if(rst) 
	begin
		i_1 <= 'b0;
		i_2 <= 'b0;
		i_3 <= 'b0;
		i_4 <= 'b0;
		i_5 <= 'b0;
	end else if (nd)
	begin
		i_1 <= i_1 + cic_in;
		i_2 <= i_1 + i_2;
		i_3 <= i_2 + i_3;
		i_4 <= i_3 + i_4;
		i_5 <= i_4 + i_5;
	end
end
		
//decimation section
parameter CNT_SAMPLE = DECIMATION_RATE-1;
reg [3:0] cnt;
reg decimation_valid;
reg signed [OUTPUT_WIDTH-1:0] sample_data;

always @(posedge clk or posedge rst)
begin
	if (rst) 
	begin
		cnt <= 4'b0;
		decimation_valid <= 1'b0;
	end
	else if (nd)
	begin
		if (cnt== CNT_SAMPLE)
		begin
			cnt <= 4'b0;
			decimation_valid <= 1'b1;
			sample_data <= i_5;
		end
		else 
		begin
			cnt <= cnt + 1'b1 ;
			decimation_valid <= 1'b0;
		end
	end
end

//comb section
//number of stages: 5

//registers
reg signed [OUTPUT_WIDTH-1:0] c_1;
reg signed [OUTPUT_WIDTH-1:0] c_1_d;
reg signed [OUTPUT_WIDTH-1:0] c_1_dd;
reg signed [OUTPUT_WIDTH-1:0] c_2;
reg signed [OUTPUT_WIDTH-1:0] c_2_d;
reg signed [OUTPUT_WIDTH-1:0] c_2_dd;  
reg signed [OUTPUT_WIDTH-1:0] c_3;
reg signed [OUTPUT_WIDTH-1:0] c_3_d; 
reg signed [OUTPUT_WIDTH-1:0] c_3_dd; 
reg signed [OUTPUT_WIDTH-1:0] c_4;
reg signed [OUTPUT_WIDTH-1:0] c_4_d;
reg signed [OUTPUT_WIDTH-1:0] c_4_dd;
reg signed [OUTPUT_WIDTH-1:0] c_5;
reg signed [OUTPUT_WIDTH-1:0] c_5_d;
reg signed [OUTPUT_WIDTH-1:0] c_5_dd;
reg signed [OUTPUT_WIDTH-1:0] cic_out;
reg cic_rdy;

always @(posedge clk or posedge rst)
begin
	if (rst) 
	begin
		c_1 <= 'b0;
		c_1_d <= 'b0;
		c_1_dd <= 'b0;
		c_2 <= 'b0;
		c_2_d <= 'b0;
		c_2_dd <= 'b0;
		c_3 <= 'b0;
		c_3_d <= 'b0;
		c_3_dd <= 'b0;
		c_4 <= 'b0;
		c_4_d <= 'b0;
		c_4_dd <= 'b0;
		c_5 <= 'b0;
		c_5_d <= 'b0;
		c_5_dd <= 'b0;
		cic_out <= 'b0;
		cic_rdy <= 'b0;
	end
	else if (decimation_valid)
	begin
		c_1 <= sample_data;
		c_1_d <= c_1;
		c_1_dd <= c_1_d;
		c_2 <= c_1 - c_1_dd;
		c_2_d <= c_2;
		c_2_dd <= c_2_d;
		c_3 <= c_2 - c_2_dd;
		c_3_d <= c_3;
		c_3_dd <= c_3_d;
		c_4 <= c_3 - c_3_dd;
		c_4_d <= c_4;
		c_4_dd <= c_4_d;
		c_5 <= c_4 - c_4_dd;
		c_5_d <= c_5;
		c_5_dd <= c_5_d;
		cic_out <= c_5 - c_5_dd;
		cic_rdy <= 1'b1;
	end
	else
	begin
		cic_rdy <= 1'b0;
	end
end

assign rdy = cic_rdy;
assign dout = cic_out;

endmodule


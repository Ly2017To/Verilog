`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:24:46 03/07/2025 
// Design Name: 
// Module Name:    spi_controller 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module spi_controller(
    input clk,                 // system clock
    input rst,                 // reset signal
    input trigger,             // trigger to transmit
    input [31:0] to_device,    // data to send from controller to device
    output spi_clk,            // clock for SPI protocol
    output spi_mosi,           // controller out device in for SPI protocol
    output spi_cs,             // chip select signal for SPI protocol
    input spi_miso,            // controller in device out for SPI protocol
    output [31:0] from_device // data to receive from device to controller
   );
	
//to generate spi_clock
//generated frequency = frequency_clk/((CLK_DIV+1)*2) 
localparam CLK_DIV = 8'b00111111; // Clock division
reg [7:0] clk_cnt;
always@(posedge clk or posedge rst)
begin
	if( rst ) clk_cnt <= 8'h00;
	else if( clk_cnt < CLK_DIV )  clk_cnt <= clk_cnt + 1'b1;
	else clk_cnt <= 8'h0;
end
wire div_clk = ( clk_cnt == 8'h1 );
reg step_clk;
always@(posedge clk or posedge rst)
begin
	if( rst ) step_clk <= 1'b0;
	else if( div_clk )  step_clk <= step_clk + 1'b1;
end
wire step_clk_p = step_clk & ( clk_cnt == 8'h1 ); //for incrementing the step count

//bit controll for data out communication
reg start;
reg [5:0] bit_cnt;
wire busy = bit_cnt < 6'd34;

//chip select for data out communication
reg busy_reg;
always@(posedge clk or posedge rst)
begin
	 if( rst )   busy_reg <= 1'b0;
	 else busy_reg <= busy;
end

//fifo for buffering the data to be transmitted
wire [31:0] din_buff;
wire din_read_valid;
wire din_empty;
wire din_full;

reg din_write_en; 
always@(posedge clk or posedge rst)
begin
	if (rst) din_write_en <= 1'b0;
	else if (trigger && !din_full) din_write_en <= 1'b1;  // Enable FIFO write when trigger signal is high and FIFO is not full
	else din_write_en <= 1'b0;  // Disable write if trigger signal is not active or FIFO is full
end

reg din_read_en;
reg din_read_data;
always@(posedge clk or posedge rst)
begin
	if( rst ) 
	begin
		din_read_en <= 1'b0;
		din_read_data <= 1'b0;
	end
	else if ((!busy)&&(!din_empty)&&(!din_read_data))
	begin
		din_read_en <= 1'b1;
		din_read_data <= 1'b1;
	end
	else if (busy) din_read_en <= 1'b0;
	else if (!busy) din_read_data <= 1'b0;
end

fifo data_in_fifo_inst(
	.clk(clk),
	.rst(rst),
	.data_in(to_device),
	.write_en(din_write_en),
	.full(din_full),
	.data_out(din_buff),
	.read_en(din_read_en),
	.empty(din_empty),
	.data_out_valid(din_read_valid)
);	

always@(posedge clk or posedge rst)
begin
	if( rst )
	begin
		 start <= 1'b0;
		 bit_cnt <= 6'd34;
	end
	else if( {start, din_read_valid, busy } == 3'b010 )  start <= 1'b1;
	else if( step_clk_p )
	begin
		 if( start ) 
		 begin
			  bit_cnt <= 6'd0;
			  start <= 1'b0;
		 end
		 else if( bit_cnt < 6'd34)  bit_cnt <= bit_cnt + 1'b1;
	end
end
 
wire spi_valid = (bit_cnt>0)&(bit_cnt<6'd33);

reg sclk;
always@(posedge clk or posedge rst)
begin
if( rst )  sclk <= 1'b0;
else sclk <= (busy & spi_valid)? step_clk : 1'b0;
end

//data out
//put the data before spi_clk samples to satisfy set_up time
reg spi_mosi_reg;
always@(posedge clk or posedge rst)
begin
  if( rst ) spi_mosi_reg <= 1'b0;
  else if (spi_valid) spi_mosi_reg <= din_buff[bit_cnt-6'd1];
  else spi_mosi_reg <= 1'b0;
end

//data in
reg [31:0] spi_miso_buff; 
always@(posedge sclk or posedge rst)
begin
  if( rst ) spi_miso_buff <= 32'h0;
  else spi_miso_buff <= {spi_miso_buff[30:0], spi_miso}; 
end
//assign from_device = {spi_miso_buff[7:0],spi_miso_buff[15:8],spi_miso_buff[23:16],spi_miso_buff[31:24]};

//fifo for buffering the data to be received
wire [31:0] data_from_device = {spi_miso_buff[7:0],spi_miso_buff[15:8],spi_miso_buff[23:16],spi_miso_buff[31:24]};
wire dout_read_valid;
wire dout_empty;
wire dout_full;

reg dout_write_en; 
always@(posedge clk or posedge rst)
begin
  if( rst ) dout_write_en <= 1'b0;
  else if (step_clk_p & (bit_cnt == 6'd33)) dout_write_en <= 1'b1; 
  else dout_write_en <= 1'b0;
end

wire [31:0] dout_buff;
reg [31:0] dout_buff_reg;

fifo data_out_fifo_inst(
	.clk(clk),
	.rst(rst),
	.data_in(data_from_device),
	.write_en(dout_write_en),
	.full(dout_full),
	.data_out(dout_buff),
	.read_en(1'b1),
	.empty(dout_empty),
	.data_out_valid(dout_read_valid)
);	
 
always@(posedge clk or posedge rst)
begin
	if( rst ) dout_buff_reg <= 32'b0;
	else if (dout_read_valid) dout_buff_reg <= dout_buff;
end

assign from_device = dout_buff_reg;

assign spi_clk = sclk;     // SPI clock
assign spi_cs = ~busy_reg;  // SPI chip select  
assign spi_mosi = spi_mosi_reg; // SPI data from controller to device


endmodule

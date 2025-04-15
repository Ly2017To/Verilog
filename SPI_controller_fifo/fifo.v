`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:29:31 04/02/2025 
// Design Name: 
// Module Name:    fifo 
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
module fifo(
    input clk,                // Clock signal
    input rst,              // Active-low reset
    input write_en,           // Write enable
    input read_en,            // Read enable
    input [31:0] data_in,     // Data input (32 bits)
    output [31:0] data_out, // Data output (32 bits)
    output full,              // FIFO full flag
    output empty,             // FIFO empty flag
    output data_out_valid     // Data output valid flag
);
    
    // FIFO parameters
    parameter WIDTH = 32;     // Data width (32 bits)
    parameter DEPTH = 32;     // FIFO depth (64 entries)
    //localparam ADDR_WIDTH = $clog2(DEPTH); // Address width for depth
	 localparam ADDR_WIDTH = 5;
    
    // Internal FIFO memory (64x32 bits)
    reg [WIDTH-1:0] fifo_mem [0:DEPTH-1];
    
    // Write and read pointers
    reg [ADDR_WIDTH-1:0] write_ptr;
    reg [ADDR_WIDTH-1:0] read_ptr;
    
    // Data out valid flag
	 reg [31:0] data_out_reg; 
    reg data_out_valid_reg;
    assign data_out_valid = data_out_valid_reg;
    
    // Write operation
    always @(posedge clk or posedge rst) begin
        if (rst) 
		  begin
            write_ptr <= 1'b0;
        end 
		  else if (write_en && !full) 
		  begin
            fifo_mem[write_ptr] <= data_in; // Write data to FIFO
            write_ptr <= write_ptr + 1;
        end
    end
    
    // Read operation
    always @(posedge clk or posedge rst) begin
        if (rst) 
		  begin
            read_ptr <= 1'b0;
            data_out_valid_reg <= 1'b0; // Data valid is low when reset
				data_out_reg <= 32'b0;
        end 
		  else if (read_en && !empty) 
		  begin
            data_out_reg <= fifo_mem[read_ptr]; // Read data from FIFO
            read_ptr <= read_ptr + 1;
            data_out_valid_reg <= 1'b1; // Data is valid after a successful read
        end 
		  else 
		  begin
            data_out_valid_reg <= 1'b0; // Data is not valid if empty or not read
        end
    end
	 
	 assign data_out = data_out_reg;
	 assign full = ((write_ptr+1)==read_ptr);
    assign empty = (write_ptr==read_ptr);
	 
endmodule

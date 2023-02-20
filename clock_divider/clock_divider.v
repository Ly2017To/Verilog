module clock_divider(clk,reset,clk_out);
	input clk, reset;
	output clk_out;
	
	parameter COUNT_REG_SIZE=3;
	parameter DIV_RATIO=3;
		
	reg [COUNT_REG_SIZE-1:0] count;
	reg clk_out;
	
	always@(posedge clk, posedge reset)
		begin
			if(reset)
				begin
					count <= 0;
					clk_out <=0;
				end
			else 
				begin
					if(count==DIV_RATIO-1) 
						begin
							count  <= 0;
							clk_out <= ~clk_out;
						end
					else count  <= count+1;
				end
		end
	
endmodule
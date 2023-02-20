module divider(div_clk, reset, testn, ena);

input div_clk, reset, testn;
output ena;

reg [3:0] counter;

always@(posedge div_clk) begin
	if(~reset)
		counter <=0;
	else
		begin
			if(~testn)
				counter<=15;
			else
				counter<=counter+1;
		end
	end
	
	assign ena = (counter ==15 )?1:0;

endmodule
module clock_divider_tb;
	reg clk, reset;
	wire clk_out;
	
	always 
		begin
			#1 clk=0;
			#1 clk=1;
		end
		
	clock_divider #(.COUNT_REG_SIZE(3),.DIV_RATIO(4)) uut(.clk(clk),.reset(reset),.clk_out(clk_out));
	
	initial 
		begin
			reset=1;
			#1 reset=0;
			#40 $finish;
		end
		
	initial
		$monitor("clk_out changed to %b at time %t", clk_out, $time);
		
	initial
		begin
			$dumpfile("wave.vcd");      // create a VCD waveform dump called "wave.vcd"
			$dumpvars(0, clock_divider_tb); // dump variable changes in this testbench and all modules under it
		end
	
	
endmodule
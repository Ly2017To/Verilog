module divider_tb;
	reg clock, reset, testn;
	wire enable;

	always
		begin
			#5 clock=0;
			#3 clock=1;
		end
	
	divider uut_divider(.div_clk(clock),.reset(reset),.testn(testn),.ena(enable));
	
	initial
		begin
			reset=0;
			#50 reset=1;
		end
		
	initial
		begin
			testn=0;
			#100 testn=1;
			#50 testn=0;
			#50 $finish; //end the simulation
		end
	
	initial
		$monitor("Enable changed to %b at time %t", enable, $time);
		
	initial
		begin
			$dumpfile("wave.vcd");      // create a VCD waveform dump called "wave.vcd"
			$dumpvars(0, divider_tb); // dump variable changes in this testbench and all modules under it
		end
	
endmodule
	
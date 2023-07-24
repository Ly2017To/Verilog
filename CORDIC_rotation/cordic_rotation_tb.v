`timescale 1ns/1ps

module cordic_rotation_tb();

	reg clk;
	reg sclr;
	reg signed [15:0] x;
	reg signed [15:0] y;
	reg signed [15 : 0] phase_in;
	wire nd;
	wire signed [15:0] x_out;
	wire signed [15:0] y_out;
	wire rdy;
	
	reg [5:0] clk_cnt; //sample rate that is usually several times slower than system clk
	wire sample_clk; //the sample clock based on the value of clk_cnt

	//the number of samples in the data file
	//when processed all the samples, finish
	integer n;
	localparam num_data_samples = 2000;	
	reg [15:0] memory_i [0:num_data_samples]; //memory to store the data of channle i  
	reg [15:0] memory_q [0:num_data_samples]; //memory to store the data of channle i  

	initial
	begin
		$dumpfile("wave_pi_over_4.vcd");   // create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, cordic_rotation_tb); // dump variable changes in this testbench and all modules under it
	end
	
	//read the data file
	initial 
	begin 
		$readmemh("F:/iverilog/cordic_rotation/signal_x.csv", memory_i);
		$readmemh("F:/iverilog/cordic_rotation/signal_y.csv", memory_q);
	end
		
	// generate 32MHz clk 
    localparam   TCLK_HALF     = 15_625;
    initial begin
        clk = 1'b0 ;
        forever begin
            # TCLK_HALF ;
            clk = ~clk ;
        end
    end
	
	//  reset and finish
    initial begin
		n = 32'b0;
		#2    sclr = 1'b0 ;		
        #10   sclr = 1'b1 ;
		#5    sclr = 1'b0 ;
		x = 'b0;
		y = 'b0;
		//#1500000 $finish;
    end
	
	//  sample rate 500KHz 
    always@(posedge clk or posedge sclr)
	begin
		if(sclr) clk_cnt <= 6'b0;
		else clk_cnt <= clk_cnt + 6'b1;
	end
	
	assign sample_clk = ( clk_cnt == 6'h1); 
	assign nd = ( clk_cnt == 6'h2);
	
	always @ (posedge sample_clk) 
	begin
		x <= memory_i[n];
		y <= memory_q[n];
		phase_in <= 16'sd6434;
		n=n+1;
		if(n==num_data_samples) $stop();
	end
	
	cordic_rotation inst1(
		.clk(clk),
		.sclr(sclr),
		.nd(nd),
		.x_in(x),
		.y_in(y),
		.phase_in(phase_in),
		.x_out(x_out),
		.y_out(y_out),
		.rdy(rdy)
	);
	
endmodule
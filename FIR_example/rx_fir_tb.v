`timescale 1ns / 1ps

module rx_fir_tb;
	
	//variables for simulation
	reg clk ; //system clock
	reg rst ; //system reset

 	reg [5:0] clk_cnt; //sample rate that is usually several times slower than system clk
	wire sample_clk; //the sample clock based on the value of clk_cnt
	wire nd; //the sample data is available to process
	
	wire rdy; //filter output ready flag
	wire chan_out; //output channel indicator
	wire [17:0] data_out; //data output of channel a
	reg [15:0] data_in; //data of channel a
	
	//the number of samples in the data file
	//when processed all the samples, finish
	integer n;
	localparam num_data_samples = 5500;
	
	reg [15:0] memory[0:num_data_samples]; //memory to store the data of channle a  
	
	//for visualize with gtkwave
	localparam BUFF_LEN=63;
	localparam TAP_LEN=31;
	localparam PRODUCT_LEN=32;
	localparam SUM_1_LEN=16;
	localparam SUM_2_LEN=8;
	localparam SUM_3_LEN=4;
	localparam SUM_4_LEN=2;
	
	integer i;
	
	initial
	begin
		$dumpfile("wave.vcd");   // create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, rx_fir_tb); // dump variable changes in this testbench and all modules under it
		
		/*
		for(i = 0; i < BUFF_LEN; i = i + 1)
			$dumpvars(1, uut.xin_a_reg[i]);
			
		for(i = 0; i < TAP_LEN; i = i + 1)
			$dumpvars(2, uut.xin_a_tap[i]);
			
		for(i = 0; i < PRODUCT_LEN; i = i + 1)
			$dumpvars(3, uut.product_a[i]);
			
		for(i = 0; i < SUM_1_LEN; i = i + 1)
			$dumpvars(3, uut.sum_a_1[i]);
			
		for(i = 0; i < SUM_2_LEN; i = i + 1)
			$dumpvars(3, uut.sum_a_2[i]);
			
		for(i = 0; i < SUM_3_LEN; i = i + 1)
			$dumpvars(3, uut.sum_a_3[i]);
			
		for(i = 0; i < SUM_4_LEN; i = i + 1)
			$dumpvars(3, uut.sum_a_4[i]);
		*/
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
        rst = 1'b0 ;
		n = 32'b0;	
        #10    rst = 1'b1 ;
		#10    rst = 1'b0 ;
		//#1500000 $finish;
    end
	
	//  sample rate 500KHz 
    always@(posedge clk or posedge rst)
	begin
		if(rst) clk_cnt <= 6'b0;
		else clk_cnt <= clk_cnt + 6'b1;
	end
	
	assign sample_clk = ( clk_cnt == 6'h1); 
	assign nd = ( clk_cnt == 6'h2);
	
	// read the data file
	initial 
	begin 
		$readmemh("F:/iverilog/FIR_example/data_channel_b.csv", memory);
	end
	
	always @ (posedge sample_clk) 
	begin
		data_in <= memory[n];
		$display("memory[%d] %h", n, memory[n]);
		$display("datain_a %h",data_in);
		n=n+1;
		//if($feof(fid)) $stop();
		if(n==num_data_samples) $stop();
	end
	
	//data_channel_a chan_in = 1'b1
	//data_channle_b_chan_in = 1'b0
	
	// Instantiate the Unit Under Test (UUT)
	rx_fir uut (
		.clk(clk), 
		.sclr(rst),
		.nd(nd), 
		.din(data_in), 
		.rdy(rdy),
		.dout(data_out),
		.chan_in(1'b0),
		.chan_out(chan_out)
	);
	
endmodule
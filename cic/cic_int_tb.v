`timescale 1ns / 1ps

module cic_int_tb ;
   parameter    INPUT_WIDTH  = 15 ;
   parameter    OUTPUT_WIDTH = 21 ;
   parameter    INTERPOLATION_RATE = 8;

   reg	clk ;
   reg	[2:0] clk_cnt; //the sampling rate before upsampling
   wire	sample_clk; //the sample clock based on the value of clk_cnt
   reg	rst;
   wire	nd;
   reg	signed [INPUT_WIDTH-1:0]	din;
   wire	rdy;
   wire signed [OUTPUT_WIDTH-1:0]	dout;

   initial
   begin
      $dumpfile("wave_cic_int_tb.vcd");   // create a VCD waveform dump called "wave.vcd"
      $dumpvars(0, cic_int_tb); // dump variable changes in this testbench and all modules under it
   end

   // generate 48MHz clk 
   localparam   TCLK_HALF     = 10.417;
   initial begin
       clk = 1'b0 ;
       forever begin
           # TCLK_HALF ;
           clk = ~clk ;
       end
   end
   
   // the sampling rate before upsampling
   always@(posedge clk or posedge rst)
   begin
		if(rst) clk_cnt <= 3'b0;
		else clk_cnt <= clk_cnt + 3'b1;
   end
   assign sample_clk = ( clk_cnt == INTERPOLATION_RATE-1);
   assign nd = ( clk_cnt == INTERPOLATION_RATE-1);
   
   //  reset and finish
   initial begin
      rst = 1'b0 ;
      # 2 ;
      rst = 1'b1 ;
	  # 3;
	  rst = 1'b0 ;
      # (TCLK_HALF * 2 * 2000) ;
      $stop ;
   end
   
   // read simulation data into register
   parameter    DATA_NUM = 2000 ;
   reg          [INPUT_WIDTH-1:0] stimulus [0: DATA_NUM-1] ;
   integer      i ;
   initial begin
      $readmemh("./signal2.csv", stimulus) ;
      i         = 0 ;
      din       = 'b0 ;
      # 5 ;
      forever begin
         @(posedge sample_clk) begin
            din         <= stimulus[i] ;
            if (i == DATA_NUM-1) begin
               i = 0 ;
            end
            else begin
               i = i + 1 ;
            end
         end
      end
   end

   cic_int_n3 #(.INPUT_WIDTH(INPUT_WIDTH), .OUTPUT_WIDTH(OUTPUT_WIDTH), .INTERPOLATION_RATE(INTERPOLATION_RATE))
   u_cic (
    .clk(clk),
    .rst(rst),
    .nd(nd),
    .din(din),
    .rdy(rdy),
    .dout(dout));
	
endmodule
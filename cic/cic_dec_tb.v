`timescale 1ns / 1ps

module cic_dec_tb ;
   parameter    INPUT_WIDTH  = 15 ;
   parameter    OUTPUT_WIDTH = 38 ;
   parameter    DECIMATION_RATE = 12;

   reg                  clk ;
   reg                  rst ;
   reg                  nd ;
   reg  signed [INPUT_WIDTH-1:0]       din ;
   wire                 rdy ;
   wire signed [OUTPUT_WIDTH-1:0]      dout ;

   initial
   begin
      $dumpfile("wave_cic_dec_tb.vcd");   // create a VCD waveform dump called "wave.vcd"
      $dumpvars(0, cic_dec_tb); // dump variable changes in this testbench and all modules under it
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
      $readmemh("./signal1.csv", stimulus) ;
      i         = 0 ;
      nd        = 1'b0 ;
      din       = 'b0 ;
      # 5 ;
      forever begin
         @(posedge clk) begin
            nd          <= 1'b1 ;
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

   cic_dec_n5 #(.INPUT_WIDTH(INPUT_WIDTH), .OUTPUT_WIDTH(OUTPUT_WIDTH), .DECIMATION_RATE(DECIMATION_RATE))
   u_cic (
    .clk(clk),
    .rst(rst),
    .nd(nd),
    .din(din),
    .rdy(rdy),
    .dout(dout));

endmodule // test
module rx_fir (
  input clk,
  input sclr,
  input nd,
  input  [15 : 0] din,
  output rdy,
  output [17 : 0] dout,
  input [0 : 0] chan_in,
  output [0 : 0] chan_out
);

 //coefficents 
 //two's complement in 18 bits
 parameter COE_WIDTH = 18;
 parameter signed [COE_WIDTH-1:0] coe_0 = 
 parameter signed [COE_WIDTH-1:0] coe_1 = 
 parameter signed [COE_WIDTH-1:0] coe_2 = 
 parameter signed [COE_WIDTH-1:0] coe_3 = 
 parameter signed [COE_WIDTH-1:0] coe_4 = 
 parameter signed [COE_WIDTH-1:0] coe_5 = 
 parameter signed [COE_WIDTH-1:0] coe_6 = 
 parameter signed [COE_WIDTH-1:0] coe_7 = 
 parameter signed [COE_WIDTH-1:0] coe_8 = 
 parameter signed [COE_WIDTH-1:0] coe_9 = 
 parameter signed [COE_WIDTH-1:0] coe_10 = 
 parameter signed [COE_WIDTH-1:0] coe_11 = 
 parameter signed [COE_WIDTH-1:0] coe_12 = 
 parameter signed [COE_WIDTH-1:0] coe_13 = 
 parameter signed [COE_WIDTH-1:0] coe_14 = 
 parameter signed [COE_WIDTH-1:0] coe_15 = 
 parameter signed [COE_WIDTH-1:0] coe_16 = 
 parameter signed [COE_WIDTH-1:0] coe_17 = 
 parameter signed [COE_WIDTH-1:0] coe_18 = 
 parameter signed [COE_WIDTH-1:0] coe_19 = 
 parameter signed [COE_WIDTH-1:0] coe_20 = 
 parameter signed [COE_WIDTH-1:0] coe_21 = 
 parameter signed [COE_WIDTH-1:0] coe_22 = 
 parameter signed [COE_WIDTH-1:0] coe_23 = 
 parameter signed [COE_WIDTH-1:0] coe_24 = 
 parameter signed [COE_WIDTH-1:0] coe_25 =
 parameter signed [COE_WIDTH-1:0] coe_26 = 
 parameter signed [COE_WIDTH-1:0] coe_27 = 
 parameter signed [COE_WIDTH-1:0] coe_28 = 
 parameter signed [COE_WIDTH-1:0] coe_29 = 
 parameter signed [COE_WIDTH-1:0] coe_30 = 
 parameter signed [COE_WIDTH-1:0] coe_31 = 
  
 //shift register to store data
 parameter DATAIN_WIDTH = 18;
 parameter DATAIN_BUFF_LEN = 63;
 reg signed [DATAIN_WIDTH-1:0] xin_a_reg[DATAIN_BUFF_LEN-1:0];
 reg signed [DATAIN_WIDTH-1:0] xin_b_reg[DATAIN_BUFF_LEN-1:0];
 
 //channel ready
 wire chan_a_nd = nd & chan_in;
 wire chan_b_nd = nd & (~chan_in);
 
 //buffer finished shift ready
 reg chan_a_nd_buf = 1'b0;
 reg chan_b_nd_buf = 1'b0;
  
 always @(posedge clk) {chan_a_nd_buf,chan_b_nd_buf} <= {chan_a_nd,chan_b_nd};
   
 //buffer shift
 always@(posedge clk or posedge sclr)
 begin
	if(sclr)
	begin
		xin_a_reg[0] <= 18'b0;
		xin_a_reg[1] <= 18'b0;
		xin_a_reg[2] <= 18'b0;
		xin_a_reg[3] <= 18'b0;
		xin_a_reg[4] <= 18'b0;
		xin_a_reg[5] <= 18'b0;
		xin_a_reg[6] <= 18'b0;
		xin_a_reg[7] <= 18'b0;
		xin_a_reg[8] <= 18'b0;
		xin_a_reg[9] <= 18'b0;
		xin_a_reg[10] <= 18'b0;
		xin_a_reg[11] <= 18'b0;
		xin_a_reg[12] <= 18'b0;
		xin_a_reg[13] <= 18'b0;
		xin_a_reg[14] <= 18'b0;
		xin_a_reg[15] <= 18'b0;
		xin_a_reg[16] <= 18'b0;
		xin_a_reg[17] <= 18'b0;
		xin_a_reg[18] <= 18'b0;
		xin_a_reg[19] <= 18'b0;
		xin_a_reg[20] <= 18'b0;
		xin_a_reg[21] <= 18'b0;
		xin_a_reg[22] <= 18'b0;
		xin_a_reg[23] <= 18'b0;
		xin_a_reg[24] <= 18'b0;
		xin_a_reg[25] <= 18'b0;
		xin_a_reg[26] <= 18'b0;
		xin_a_reg[27] <= 18'b0;
		xin_a_reg[28] <= 18'b0;
		xin_a_reg[29] <= 18'b0;
		xin_a_reg[30] <= 18'b0;
		xin_a_reg[31] <= 18'b0;
		xin_a_reg[32] <= 18'b0;
		xin_a_reg[33] <= 18'b0;
		xin_a_reg[34] <= 18'b0;
		xin_a_reg[35] <= 18'b0;
		xin_a_reg[36] <= 18'b0;
		xin_a_reg[37] <= 18'b0;
		xin_a_reg[38] <= 18'b0;
		xin_a_reg[39] <= 18'b0;
		xin_a_reg[40] <= 18'b0;
		xin_a_reg[41] <= 18'b0;
		xin_a_reg[42] <= 18'b0;
		xin_a_reg[43] <= 18'b0;
		xin_a_reg[44] <= 18'b0;
		xin_a_reg[45] <= 18'b0;
		xin_a_reg[46] <= 18'b0;
		xin_a_reg[47] <= 18'b0;
		xin_a_reg[48] <= 18'b0;
		xin_a_reg[49] <= 18'b0;
		xin_a_reg[50] <= 18'b0;
		xin_a_reg[51] <= 18'b0;
		xin_a_reg[52] <= 18'b0;
		xin_a_reg[53] <= 18'b0;
		xin_a_reg[54] <= 18'b0;
		xin_a_reg[55] <= 18'b0;
		xin_a_reg[56] <= 18'b0;
		xin_a_reg[57] <= 18'b0;
		xin_a_reg[58] <= 18'b0;
		xin_a_reg[59] <= 18'b0;
		xin_a_reg[60] <= 18'b0;
		xin_a_reg[61] <= 18'b0;
		xin_a_reg[62] <= 18'b0;
	end
	else if(chan_a_nd)
	begin
		xin_a_reg[0] <= {{2{din[15]}},din};
		xin_a_reg[1] <= xin_a_reg[0];
		xin_a_reg[2] <= xin_a_reg[1];
		xin_a_reg[3] <= xin_a_reg[2];
		xin_a_reg[4] <= xin_a_reg[3];
		xin_a_reg[5] <= xin_a_reg[4];
		xin_a_reg[6] <= xin_a_reg[5];
		xin_a_reg[7] <= xin_a_reg[6];
		xin_a_reg[8] <= xin_a_reg[7];
		xin_a_reg[9] <= xin_a_reg[8];
		xin_a_reg[10] <= xin_a_reg[9];
		xin_a_reg[11] <= xin_a_reg[10];
		xin_a_reg[12] <= xin_a_reg[11];
		xin_a_reg[13] <= xin_a_reg[12];
		xin_a_reg[14] <= xin_a_reg[13];
		xin_a_reg[15] <= xin_a_reg[14];
		xin_a_reg[16] <= xin_a_reg[15];
		xin_a_reg[17] <= xin_a_reg[16];
		xin_a_reg[18] <= xin_a_reg[17];
		xin_a_reg[19] <= xin_a_reg[18];
		xin_a_reg[20] <= xin_a_reg[19];
		xin_a_reg[21] <= xin_a_reg[20];
		xin_a_reg[22] <= xin_a_reg[21];
		xin_a_reg[23] <= xin_a_reg[22];
		xin_a_reg[24] <= xin_a_reg[23];
		xin_a_reg[25] <= xin_a_reg[24];
		xin_a_reg[26] <= xin_a_reg[25];
		xin_a_reg[27] <= xin_a_reg[26];
		xin_a_reg[28] <= xin_a_reg[27];
		xin_a_reg[29] <= xin_a_reg[28];
		xin_a_reg[30] <= xin_a_reg[29];
		xin_a_reg[31] <= xin_a_reg[30];
		xin_a_reg[32] <= xin_a_reg[31];
		xin_a_reg[33] <= xin_a_reg[32];
		xin_a_reg[34] <= xin_a_reg[33];
		xin_a_reg[35] <= xin_a_reg[34];
		xin_a_reg[36] <= xin_a_reg[35];
		xin_a_reg[37] <= xin_a_reg[36];
		xin_a_reg[38] <= xin_a_reg[37];
		xin_a_reg[39] <= xin_a_reg[38];
		xin_a_reg[40] <= xin_a_reg[39];
		xin_a_reg[41] <= xin_a_reg[40];
		xin_a_reg[42] <= xin_a_reg[41];
		xin_a_reg[43] <= xin_a_reg[42];
		xin_a_reg[44] <= xin_a_reg[43];
		xin_a_reg[45] <= xin_a_reg[44];
		xin_a_reg[46] <= xin_a_reg[45];
		xin_a_reg[47] <= xin_a_reg[46];
		xin_a_reg[48] <= xin_a_reg[47];
		xin_a_reg[49] <= xin_a_reg[48];
		xin_a_reg[50] <= xin_a_reg[49];
		xin_a_reg[51] <= xin_a_reg[50];
		xin_a_reg[52] <= xin_a_reg[51];
		xin_a_reg[53] <= xin_a_reg[52];
		xin_a_reg[54] <= xin_a_reg[53];
		xin_a_reg[55] <= xin_a_reg[54];
		xin_a_reg[56] <= xin_a_reg[55];
		xin_a_reg[57] <= xin_a_reg[56];
		xin_a_reg[58] <= xin_a_reg[57];
		xin_a_reg[59] <= xin_a_reg[58];
		xin_a_reg[60] <= xin_a_reg[59];
		xin_a_reg[61] <= xin_a_reg[60];
		xin_a_reg[62] <= xin_a_reg[61];
	end
 end 
 
 always@(posedge clk or posedge sclr)
 begin
	if(sclr)
	begin
		xin_b_reg[0] <= 18'b0;
		xin_b_reg[1] <= 18'b0;
		xin_b_reg[2] <= 18'b0;
		xin_b_reg[3] <= 18'b0;
		xin_b_reg[4] <= 18'b0;
		xin_b_reg[5] <= 18'b0;
		xin_b_reg[6] <= 18'b0;
		xin_b_reg[7] <= 18'b0;
		xin_b_reg[8] <= 18'b0;
		xin_b_reg[9] <= 18'b0;
		xin_b_reg[10] <= 18'b0;
		xin_b_reg[11] <= 18'b0;
		xin_b_reg[12] <= 18'b0;
		xin_b_reg[13] <= 18'b0;
		xin_b_reg[14] <= 18'b0;
		xin_b_reg[15] <= 18'b0;
		xin_b_reg[16] <= 18'b0;
		xin_b_reg[17] <= 18'b0;
		xin_b_reg[18] <= 18'b0;
		xin_b_reg[19] <= 18'b0;
		xin_b_reg[20] <= 18'b0;
		xin_b_reg[21] <= 18'b0;
		xin_b_reg[22] <= 18'b0;
		xin_b_reg[23] <= 18'b0;
		xin_b_reg[24] <= 18'b0;
		xin_b_reg[25] <= 18'b0;
		xin_b_reg[26] <= 18'b0;
		xin_b_reg[27] <= 18'b0;
		xin_b_reg[28] <= 18'b0;
		xin_b_reg[29] <= 18'b0;
		xin_b_reg[30] <= 18'b0;
		xin_b_reg[31] <= 18'b0;
		xin_b_reg[32] <= 18'b0;
		xin_b_reg[33] <= 18'b0;
		xin_b_reg[34] <= 18'b0;
		xin_b_reg[35] <= 18'b0;
		xin_b_reg[36] <= 18'b0;
		xin_b_reg[37] <= 18'b0;
		xin_b_reg[38] <= 18'b0;
		xin_b_reg[39] <= 18'b0;
		xin_b_reg[40] <= 18'b0;
		xin_b_reg[41] <= 18'b0;
		xin_b_reg[42] <= 18'b0;
		xin_b_reg[43] <= 18'b0;
		xin_b_reg[44] <= 18'b0;
		xin_b_reg[45] <= 18'b0;
		xin_b_reg[46] <= 18'b0;
		xin_b_reg[47] <= 18'b0;
		xin_b_reg[48] <= 18'b0;
		xin_b_reg[49] <= 18'b0;
		xin_b_reg[50] <= 18'b0;
		xin_b_reg[51] <= 18'b0;
		xin_b_reg[52] <= 18'b0;
		xin_b_reg[53] <= 18'b0;
		xin_b_reg[54] <= 18'b0;
		xin_b_reg[55] <= 18'b0;
		xin_b_reg[56] <= 18'b0;
		xin_b_reg[57] <= 18'b0;
		xin_b_reg[58] <= 18'b0;
		xin_b_reg[59] <= 18'b0;
		xin_b_reg[60] <= 18'b0;
		xin_b_reg[61] <= 18'b0;
		xin_b_reg[62] <= 18'b0;
	end
	else if(chan_b_nd)
	begin
		xin_b_reg[0] <= {{2{din[15]}},din};
		xin_b_reg[1] <= xin_b_reg[0];
		xin_b_reg[2] <= xin_b_reg[1];
		xin_b_reg[3] <= xin_b_reg[2];
		xin_b_reg[4] <= xin_b_reg[3];
		xin_b_reg[5] <= xin_b_reg[4];
		xin_b_reg[6] <= xin_b_reg[5];
		xin_b_reg[7] <= xin_b_reg[6];
		xin_b_reg[8] <= xin_b_reg[7];
		xin_b_reg[9] <= xin_b_reg[8];
		xin_b_reg[10] <= xin_b_reg[9];
		xin_b_reg[11] <= xin_b_reg[10];
		xin_b_reg[12] <= xin_b_reg[11];
		xin_b_reg[13] <= xin_b_reg[12];
		xin_b_reg[14] <= xin_b_reg[13];
		xin_b_reg[15] <= xin_b_reg[14];
		xin_b_reg[16] <= xin_b_reg[15];
		xin_b_reg[17] <= xin_b_reg[16];
		xin_b_reg[18] <= xin_b_reg[17];
		xin_b_reg[19] <= xin_b_reg[18];
		xin_b_reg[20] <= xin_b_reg[19];
		xin_b_reg[21] <= xin_b_reg[20];
		xin_b_reg[22] <= xin_b_reg[21];
		xin_b_reg[23] <= xin_b_reg[22];
		xin_b_reg[24] <= xin_b_reg[23];
		xin_b_reg[25] <= xin_b_reg[24];
		xin_b_reg[26] <= xin_b_reg[25];
		xin_b_reg[27] <= xin_b_reg[26];
		xin_b_reg[28] <= xin_b_reg[27];
		xin_b_reg[29] <= xin_b_reg[28];
		xin_b_reg[30] <= xin_b_reg[29];
		xin_b_reg[31] <= xin_b_reg[30];
		xin_b_reg[32] <= xin_b_reg[31];
		xin_b_reg[33] <= xin_b_reg[32];
		xin_b_reg[34] <= xin_b_reg[33];
		xin_b_reg[35] <= xin_b_reg[34];
		xin_b_reg[36] <= xin_b_reg[35];
		xin_b_reg[37] <= xin_b_reg[36];
		xin_b_reg[38] <= xin_b_reg[37];
		xin_b_reg[39] <= xin_b_reg[38];
		xin_b_reg[40] <= xin_b_reg[39];
		xin_b_reg[41] <= xin_b_reg[40];
		xin_b_reg[42] <= xin_b_reg[41];
		xin_b_reg[43] <= xin_b_reg[42];
		xin_b_reg[44] <= xin_b_reg[43];
		xin_b_reg[45] <= xin_b_reg[44];
		xin_b_reg[46] <= xin_b_reg[45];
		xin_b_reg[47] <= xin_b_reg[46];
		xin_b_reg[48] <= xin_b_reg[47];
		xin_b_reg[49] <= xin_b_reg[48];
		xin_b_reg[50] <= xin_b_reg[49];
		xin_b_reg[51] <= xin_b_reg[50];
		xin_b_reg[52] <= xin_b_reg[51];
		xin_b_reg[53] <= xin_b_reg[52];
		xin_b_reg[54] <= xin_b_reg[53];
		xin_b_reg[55] <= xin_b_reg[54];
		xin_b_reg[56] <= xin_b_reg[55];
		xin_b_reg[57] <= xin_b_reg[56];
		xin_b_reg[58] <= xin_b_reg[57];
		xin_b_reg[59] <= xin_b_reg[58];
		xin_b_reg[60] <= xin_b_reg[59];
		xin_b_reg[61] <= xin_b_reg[60];
		xin_b_reg[62] <= xin_b_reg[61];
	end
 end 
 
 //according to the IP provided, adjust the code of multiplication and addition
 reg signed [DATAIN_WIDTH-1:0]xin_a_tap [30:0];
 reg signed [DATAIN_WIDTH-1:0]xin_b_tap [30:0];
 
 //fir can calculate product 
 reg  fir_a_product = 1'b0;
 reg  fir_b_product = 1'b0;
 
 always @(posedge clk) {fir_a_product,fir_b_product} <= {chan_a_nd_buf,chan_b_nd_buf};
 
 //registers to store the products
 reg signed [39:0]product_a [31:0];
 reg signed [39:0]product_b [31:0];
 
 //fir can calculate sum of stage 1
 reg  fir_a_sum_1 = 1'b0;
 reg  fir_b_sum_1 = 1'b0;
 
 always @(posedge clk) {fir_a_sum_1,fir_b_sum_1} <= {fir_a_product,fir_b_product};
 
 reg signed [39:0] sum_a_1 [15:0];
 reg signed [39:0] sum_b_1 [15:0];
 
 //fir can calculate sum of stage 2
 reg  fir_a_sum_2 = 1'b0;
 reg  fir_b_sum_2 = 1'b0;
 
 always @(posedge clk) {fir_a_sum_2,fir_b_sum_2} <= {fir_a_sum_1,fir_b_sum_1};
 
 reg signed [39:0] sum_a_2 [7:0];
 reg signed [39:0] sum_b_2 [7:0];
 
 //fir can calculate sum of stage 3
 reg  fir_a_sum_3 = 1'b0;
 reg  fir_b_sum_3 = 1'b0;
 
 always @(posedge clk) {fir_a_sum_3,fir_b_sum_3} <= {fir_a_sum_2,fir_b_sum_2};
 
 reg signed [39:0] sum_a_3 [3:0];
 reg signed [39:0] sum_b_3 [3:0];
 
 //fir can calculate sum of stage 4
 reg  fir_a_sum_4 = 1'b0;
 reg  fir_b_sum_4 = 1'b0;
 
 always @(posedge clk) {fir_a_sum_4,fir_b_sum_4} <= {fir_a_sum_3,fir_b_sum_3};
 
 reg signed [39:0] sum_a_4 [1:0];
 reg signed [39:0] sum_b_4 [1:0];
 
 //fir can calculate sum of stage 5
 reg  fir_a_sum_5 = 1'b0;
 reg  fir_b_sum_5 = 1'b0;
 
 always @(posedge clk) {fir_a_sum_5,fir_b_sum_5} <= {fir_a_sum_4,fir_b_sum_4};
 
 reg signed [39:0] sum_a_5;
 reg signed [39:0] sum_b_5;
 
 reg fir_a_rdy = 1'b0;
 reg fir_b_rdy = 1'b0;
 reg signed [17:0] fir_dout = 18'b0; 
 reg fir_rdy = 1'b0;
 reg fir_chan_out;
 
 always @(posedge clk) {fir_a_rdy,fir_b_rdy} <= {fir_a_sum_5,fir_b_sum_5};

 //channel a
 //sum the data with symmetry
 always@(posedge clk or posedge sclr)
 begin
	if(sclr)
	begin
		xin_a_tap[0] <= 18'b0;
		xin_a_tap[1] <= 18'b0;
		xin_a_tap[2] <= 18'b0;
		xin_a_tap[3] <= 18'b0;
		xin_a_tap[4] <= 18'b0;
		xin_a_tap[5] <= 18'b0;
		xin_a_tap[6] <= 18'b0;
		xin_a_tap[7] <= 18'b0;
		xin_a_tap[8] <= 18'b0;
		xin_a_tap[9] <= 18'b0;
		xin_a_tap[10] <= 18'b0;
		xin_a_tap[11] <= 18'b0;
		xin_a_tap[12] <= 18'b0;
		xin_a_tap[13] <= 18'b0;
		xin_a_tap[14] <= 18'b0;
		xin_a_tap[15] <= 18'b0;
		xin_a_tap[16] <= 18'b0;
		xin_a_tap[17] <= 18'b0;
		xin_a_tap[18] <= 18'b0;
		xin_a_tap[19] <= 18'b0;
		xin_a_tap[20] <= 18'b0;
		xin_a_tap[21] <= 18'b0;
		xin_a_tap[22] <= 18'b0;
		xin_a_tap[23] <= 18'b0;
		xin_a_tap[24] <= 18'b0;
		xin_a_tap[25] <= 18'b0;
		xin_a_tap[26] <= 18'b0;
		xin_a_tap[27] <= 18'b0;
		xin_a_tap[28] <= 18'b0;
		xin_a_tap[29] <= 18'b0;
		xin_a_tap[30] <= 18'b0;
	end
	else if(chan_a_nd_buf)
	begin
		xin_a_tap[0] <= xin_a_reg[0]+xin_a_reg[62];
		xin_a_tap[1] <= xin_a_reg[1]+xin_a_reg[61];
		xin_a_tap[2] <= xin_a_reg[2]+xin_a_reg[60];
		xin_a_tap[3] <= xin_a_reg[3]+xin_a_reg[59];
		xin_a_tap[4] <= xin_a_reg[4]+xin_a_reg[58];
		xin_a_tap[5] <= xin_a_reg[5]+xin_a_reg[57];
		xin_a_tap[6] <= xin_a_reg[6]+xin_a_reg[56];
		xin_a_tap[7] <= xin_a_reg[7]+xin_a_reg[55];
		xin_a_tap[8] <= xin_a_reg[8]+xin_a_reg[54];
		xin_a_tap[9] <= xin_a_reg[9]+xin_a_reg[53];
		xin_a_tap[10] <= xin_a_reg[10]+xin_a_reg[52];
		xin_a_tap[11] <= xin_a_reg[11]+xin_a_reg[51];
		xin_a_tap[12] <= xin_a_reg[12]+xin_a_reg[50];
		xin_a_tap[13] <= xin_a_reg[13]+xin_a_reg[49];
		xin_a_tap[14] <= xin_a_reg[14]+xin_a_reg[48];
		xin_a_tap[15] <= xin_a_reg[15]+xin_a_reg[47];
		xin_a_tap[16] <= xin_a_reg[16]+xin_a_reg[46];
		xin_a_tap[17] <= xin_a_reg[17]+xin_a_reg[45];
		xin_a_tap[18] <= xin_a_reg[18]+xin_a_reg[44];
		xin_a_tap[19] <= xin_a_reg[19]+xin_a_reg[43];
		xin_a_tap[20] <= xin_a_reg[20]+xin_a_reg[42];
		xin_a_tap[21] <= xin_a_reg[21]+xin_a_reg[41];
		xin_a_tap[22] <= xin_a_reg[22]+xin_a_reg[40];
		xin_a_tap[23] <= xin_a_reg[23]+xin_a_reg[39];
		xin_a_tap[24] <= xin_a_reg[24]+xin_a_reg[38];
		xin_a_tap[25] <= xin_a_reg[25]+xin_a_reg[37];
		xin_a_tap[26] <= xin_a_reg[26]+xin_a_reg[40];
		xin_a_tap[27] <= xin_a_reg[27]+xin_a_reg[40];
		xin_a_tap[28] <= xin_a_reg[28]+xin_a_reg[40];
		xin_a_tap[29] <= xin_a_reg[29]+xin_a_reg[40];
		xin_a_tap[30] <= xin_a_reg[30]+xin_a_reg[32];
	end
 end
 
 //products
 always@(posedge clk or posedge sclr)
 begin
	if(sclr)
	begin
		product_a[0] <= 40'b0;
		product_a[1] <= 40'b0;
		product_a[2] <= 40'b0;
		product_a[3] <= 40'b0;
		product_a[4] <= 40'b0;
		product_a[5] <= 40'b0;
		product_a[6] <= 40'b0;
		product_a[7] <= 40'b0;
		product_a[8] <= 40'b0;
		product_a[9] <= 40'b0;
		product_a[10] <= 40'b0;
		product_a[11] <= 40'b0;
		product_a[12] <= 40'b0;
		product_a[13] <= 40'b0;
		product_a[14] <= 40'b0;
		product_a[15] <= 40'b0;
		product_a[16] <= 40'b0;
		product_a[17] <= 40'b0;
		product_a[18] <= 40'b0;
		product_a[19] <= 40'b0;
		product_a[20] <= 40'b0;
		product_a[21] <= 40'b0;
		product_a[22] <= 40'b0;
		product_a[23] <= 40'b0;
		product_a[24] <= 40'b0;
		product_a[25] <= 40'b0;
		product_a[26] <= 40'b0;
		product_a[27] <= 40'b0;
		product_a[28] <= 40'b0;
		product_a[29] <= 40'b0;
		product_a[30] <= 40'b0;
		product_a[31] <= 40'b0;
	end
	else if(fir_a_product)
	begin
		product_a[0] <= xin_a_tap[0]*coe_0;
		product_a[1] <= xin_a_tap[1]*coe_1;
		product_a[2] <= xin_a_tap[2]*coe_2;
		product_a[3] <= xin_a_tap[3]*coe_3;
		product_a[4] <= xin_a_tap[4]*coe_4;
		product_a[5] <= xin_a_tap[5]*coe_5;
		product_a[6] <= xin_a_tap[6]*coe_6;
		product_a[7] <= xin_a_tap[7]*coe_7;
		product_a[8] <= xin_a_tap[8]*coe_8;
		product_a[9] <= xin_a_tap[9]*coe_9;
		product_a[10] <= xin_a_tap[10]*coe_10;
		product_a[11] <= xin_a_tap[11]*coe_11;
		product_a[12] <= xin_a_tap[12]*coe_12;
		product_a[13] <= xin_a_tap[13]*coe_13;
		product_a[14] <= xin_a_tap[14]*coe_14;
		product_a[15] <= xin_a_tap[15]*coe_15;
		product_a[16] <= xin_a_tap[16]*coe_16;
		product_a[17] <= xin_a_tap[17]*coe_17;
		product_a[18] <= xin_a_tap[18]*coe_18;
		product_a[19] <= xin_a_tap[19]*coe_19;
		product_a[20] <= xin_a_tap[20]*coe_20;
		product_a[21] <= xin_a_tap[21]*coe_21;
		product_a[22] <= xin_a_tap[22]*coe_22;
		product_a[23] <= xin_a_tap[23]*coe_23;
		product_a[24] <= xin_a_tap[24]*coe_24;
		product_a[25] <= xin_a_tap[25]*coe_25;
		product_a[26] <= xin_a_tap[26]*coe_26;
		product_a[27] <= xin_a_tap[27]*coe_27;
		product_a[28] <= xin_a_tap[28]*coe_28;
		product_a[29] <= xin_a_tap[29]*coe_29;
		product_a[30] <= xin_a_tap[30]*coe_30;
		product_a[31] <= xin_a_reg[31]*coe_31;
	end
 end
 
 //sum at stage 1
 always@(posedge clk or posedge sclr)
 begin
	if(sclr)
	begin
		sum_a_1[0] <= 40'b0;
		sum_a_1[1] <= 40'b0;
		sum_a_1[2] <= 40'b0;
		sum_a_1[3] <= 40'b0;
		sum_a_1[4] <= 40'b0;
		sum_a_1[5] <= 40'b0;
		sum_a_1[6] <= 40'b0;
		sum_a_1[7] <= 40'b0;
		sum_a_1[8] <= 40'b0;
		sum_a_1[9] <= 40'b0;
		sum_a_1[10] <= 40'b0;
		sum_a_1[11] <= 40'b0;
		sum_a_1[12] <= 40'b0;
		sum_a_1[13] <= 40'b0;
		sum_a_1[14] <= 40'b0;
		sum_a_1[15] <= 40'b0;
	end
	else if(fir_a_sum_1)
	begin
	    sum_a_1[0] <= product_a[0]+product_a[1];
		sum_a_1[1] <= product_a[2]+product_a[3];
		sum_a_1[2] <= product_a[4]+product_a[5];
		sum_a_1[3] <= product_a[6]+product_a[7];
		sum_a_1[4] <= product_a[8]+product_a[9];
		sum_a_1[5] <= product_a[10]+product_a[11];
		sum_a_1[6] <= product_a[12]+product_a[13];
		sum_a_1[7] <= product_a[14]+product_a[15];
		sum_a_1[8] <= product_a[16]+product_a[17];
		sum_a_1[9] <= product_a[18]+product_a[19];
		sum_a_1[10] <= product_a[20]+product_a[21];
		sum_a_1[11] <= product_a[22]+product_a[23];
		sum_a_1[12] <= product_a[24]+product_a[25];
		sum_a_1[13] <= product_a[26]+product_a[27];
		sum_a_1[14] <= product_a[28]+product_a[29];
		sum_a_1[15] <= product_a[30]+product_a[31];
	end
 end
 
 //sum at stage 2
 always@(posedge clk or posedge sclr)
 begin
	if(sclr)
	begin
		sum_a_2[0] <= 40'b0;
		sum_a_2[1] <= 40'b0;
		sum_a_2[2] <= 40'b0;
		sum_a_2[3] <= 40'b0;
		sum_a_2[4] <= 40'b0;
		sum_a_2[5] <= 40'b0;
		sum_a_2[6] <= 40'b0;
		sum_a_2[7] <= 40'b0;
	end
	else if(fir_a_sum_2)
	begin
	    sum_a_2[0] <= sum_a_1[0]+sum_a_1[1];
		sum_a_2[1] <= sum_a_1[2]+sum_a_1[3];
		sum_a_2[2] <= sum_a_1[4]+sum_a_1[5];
		sum_a_2[3] <= sum_a_1[6]+sum_a_1[7];
		sum_a_2[4] <= sum_a_1[8]+sum_a_1[9];
		sum_a_2[5] <= sum_a_1[10]+sum_a_1[11];
		sum_a_2[6] <= sum_a_1[12]+sum_a_1[13];
		sum_a_2[7] <= sum_a_1[14]+sum_a_1[15];
	end
 end
 
 //sum at stage 3
 always@(posedge clk or posedge sclr)
 begin
	if(sclr)
	begin
		sum_a_3[0] <= 40'b0;
		sum_a_3[1] <= 40'b0;
		sum_a_3[2] <= 40'b0;
		sum_a_3[3] <= 40'b0;
	end
	else if(fir_a_sum_3)
	begin
	    sum_a_3[0] <= sum_a_2[0]+sum_a_2[1];
		sum_a_3[1] <= sum_a_2[2]+sum_a_2[3];
		sum_a_3[2] <= sum_a_2[4]+sum_a_2[5];
		sum_a_3[3] <= sum_a_2[6]+sum_a_2[7];
	end
 end
 
 //sum at stage 4
 always@(posedge clk or posedge sclr)
 begin
	if(sclr)
	begin
		sum_a_4[0] <= 40'b0;
		sum_a_4[1] <= 40'b0;
	end
	else if(fir_a_sum_4)
	begin
	    sum_a_4[0] <= sum_a_3[0]+sum_a_3[1];
		sum_a_4[1] <= sum_a_3[2]+sum_a_3[3];
	end
 end
 
 //sum at stage 5
 always@(posedge clk or posedge sclr)
 begin
	if(sclr)
		sum_a_5 <= 40'b0;
	else if(fir_a_sum_5)
	    sum_a_5 <= sum_a_4[0]+sum_a_4[1];
 end
 
 //channel b
 //sum the data with symmetry
 always@(posedge clk or posedge sclr)
 begin
	if(sclr)
	begin
		xin_b_tap[0] <= 18'b0;
		xin_b_tap[1] <= 18'b0;
		xin_b_tap[2] <= 18'b0;
		xin_b_tap[3] <= 18'b0;
		xin_b_tap[4] <= 18'b0;
		xin_b_tap[5] <= 18'b0;
		xin_b_tap[6] <= 18'b0;
		xin_b_tap[7] <= 18'b0;
		xin_b_tap[8] <= 18'b0;
		xin_b_tap[9] <= 18'b0;
		xin_b_tap[10] <= 18'b0;
		xin_b_tap[11] <= 18'b0;
		xin_b_tap[12] <= 18'b0;
		xin_b_tap[13] <= 18'b0;
		xin_b_tap[14] <= 18'b0;
		xin_b_tap[15] <= 18'b0;
		xin_b_tap[16] <= 18'b0;
		xin_b_tap[17] <= 18'b0;
		xin_b_tap[18] <= 18'b0;
		xin_b_tap[19] <= 18'b0;
		xin_b_tap[20] <= 18'b0;
		xin_b_tap[21] <= 18'b0;
		xin_b_tap[22] <= 18'b0;
		xin_b_tap[23] <= 18'b0;
		xin_b_tap[24] <= 18'b0;
		xin_b_tap[25] <= 18'b0;
		xin_b_tap[26] <= 18'b0;
		xin_b_tap[27] <= 18'b0;
		xin_b_tap[28] <= 18'b0;
		xin_b_tap[29] <= 18'b0;
		xin_b_tap[30] <= 18'b0;
	end
	else if(chan_b_nd_buf)
	begin
		xin_b_tap[0] <= xin_b_reg[0]+xin_b_reg[62];
		xin_b_tap[1] <= xin_b_reg[1]+xin_b_reg[61];
		xin_b_tap[2] <= xin_b_reg[2]+xin_b_reg[60];
		xin_b_tap[3] <= xin_b_reg[3]+xin_b_reg[59];
		xin_b_tap[4] <= xin_b_reg[4]+xin_b_reg[58];
		xin_b_tap[5] <= xin_b_reg[5]+xin_b_reg[57];
		xin_b_tap[6] <= xin_b_reg[6]+xin_b_reg[56];
		xin_b_tap[7] <= xin_b_reg[7]+xin_b_reg[55];
		xin_b_tap[8] <= xin_b_reg[8]+xin_b_reg[54];
		xin_b_tap[9] <= xin_b_reg[9]+xin_b_reg[53];
		xin_b_tap[10] <= xin_b_reg[10]+xin_b_reg[52];
		xin_b_tap[11] <= xin_b_reg[11]+xin_b_reg[51];
		xin_b_tap[12] <= xin_b_reg[12]+xin_b_reg[50];
		xin_b_tap[13] <= xin_b_reg[13]+xin_b_reg[49];
		xin_b_tap[14] <= xin_b_reg[14]+xin_b_reg[48];
		xin_b_tap[15] <= xin_b_reg[15]+xin_b_reg[47];
		xin_b_tap[16] <= xin_b_reg[16]+xin_b_reg[46];
		xin_b_tap[17] <= xin_b_reg[17]+xin_b_reg[45];
		xin_b_tap[18] <= xin_b_reg[18]+xin_b_reg[44];
		xin_b_tap[19] <= xin_b_reg[19]+xin_b_reg[43];
		xin_b_tap[20] <= xin_b_reg[20]+xin_b_reg[42];
		xin_b_tap[21] <= xin_b_reg[21]+xin_b_reg[41];
		xin_b_tap[22] <= xin_b_reg[22]+xin_b_reg[40];
		xin_b_tap[23] <= xin_b_reg[23]+xin_b_reg[39];
		xin_b_tap[24] <= xin_b_reg[24]+xin_b_reg[38];
		xin_b_tap[25] <= xin_b_reg[25]+xin_b_reg[37];
		xin_b_tap[26] <= xin_b_reg[26]+xin_b_reg[40];
		xin_b_tap[27] <= xin_b_reg[27]+xin_b_reg[40];
		xin_b_tap[28] <= xin_b_reg[28]+xin_b_reg[40];
		xin_b_tap[29] <= xin_b_reg[29]+xin_b_reg[40];
		xin_b_tap[30] <= xin_b_reg[30]+xin_b_reg[32];
	end
 end
 
 //products
 always@(posedge clk or posedge sclr)
 begin
	if(sclr)
	begin
		product_b[0] <= 40'b0;
		product_b[1] <= 40'b0;
		product_b[2] <= 40'b0;
		product_b[3] <= 40'b0;
		product_b[4] <= 40'b0;
		product_b[5] <= 40'b0;
		product_b[6] <= 40'b0;
		product_b[7] <= 40'b0;
		product_b[8] <= 40'b0;
		product_b[9] <= 40'b0;
		product_b[10] <= 40'b0;
		product_b[11] <= 40'b0;
		product_b[12] <= 40'b0;
		product_b[13] <= 40'b0;
		product_b[14] <= 40'b0;
		product_b[15] <= 40'b0;
		product_b[16] <= 40'b0;
		product_b[17] <= 40'b0;
		product_b[18] <= 40'b0;
		product_b[19] <= 40'b0;
		product_b[20] <= 40'b0;
		product_b[21] <= 40'b0;
		product_b[22] <= 40'b0;
		product_b[23] <= 40'b0;
		product_b[24] <= 40'b0;
		product_b[25] <= 40'b0;
		product_b[26] <= 40'b0;
		product_b[27] <= 40'b0;
		product_b[28] <= 40'b0;
		product_b[29] <= 40'b0;
		product_b[30] <= 40'b0;
		product_b[31] <= 40'b0;
	end
	else if(fir_b_product)
	begin
		product_b[0] <= xin_b_tap[0]*coe_0;
		product_b[1] <= xin_b_tap[1]*coe_1;
		product_b[2] <= xin_b_tap[2]*coe_2;
		product_b[3] <= xin_b_tap[3]*coe_3;
		product_b[4] <= xin_b_tap[4]*coe_4;
		product_b[5] <= xin_b_tap[5]*coe_5;
		product_b[6] <= xin_b_tap[6]*coe_6;
		product_b[7] <= xin_b_tap[7]*coe_7;
		product_b[8] <= xin_b_tap[8]*coe_8;
		product_b[9] <= xin_b_tap[9]*coe_9;
		product_b[10] <= xin_b_tap[10]*coe_10;
		product_b[11] <= xin_b_tap[11]*coe_11;
		product_b[12] <= xin_b_tap[12]*coe_12;
		product_b[13] <= xin_b_tap[13]*coe_13;
		product_b[14] <= xin_b_tap[14]*coe_14;
		product_b[15] <= xin_b_tap[15]*coe_15;
		product_b[16] <= xin_b_tap[16]*coe_16;
		product_b[17] <= xin_b_tap[17]*coe_17;
		product_b[18] <= xin_b_tap[18]*coe_18;
		product_b[19] <= xin_b_tap[19]*coe_19;
		product_b[20] <= xin_b_tap[20]*coe_20;
		product_b[21] <= xin_b_tap[21]*coe_21;
		product_b[22] <= xin_b_tap[22]*coe_22;
		product_b[23] <= xin_b_tap[23]*coe_23;
		product_b[24] <= xin_b_tap[24]*coe_24;
		product_b[25] <= xin_b_tap[25]*coe_25;
		product_b[26] <= xin_b_tap[26]*coe_26;
		product_b[27] <= xin_b_tap[27]*coe_27;
		product_b[28] <= xin_b_tap[28]*coe_28;
		product_b[29] <= xin_b_tap[29]*coe_29;
		product_b[30] <= xin_b_tap[30]*coe_30;
		product_b[31] <= xin_b_reg[31]*coe_31;
	end
 end
 
 //sum at stage 1
 always@(posedge clk or posedge sclr)
 begin
	if(sclr)
	begin
		sum_b_1[0] <= 40'b0;
		sum_b_1[1] <= 40'b0;
		sum_b_1[2] <= 40'b0;
		sum_b_1[3] <= 40'b0;
		sum_b_1[4] <= 40'b0;
		sum_b_1[5] <= 40'b0;
		sum_b_1[6] <= 40'b0;
		sum_b_1[7] <= 40'b0;
		sum_b_1[8] <= 40'b0;
		sum_b_1[9] <= 40'b0;
		sum_b_1[10] <= 40'b0;
		sum_b_1[11] <= 40'b0;
		sum_b_1[12] <= 40'b0;
		sum_b_1[13] <= 40'b0;
		sum_b_1[14] <= 40'b0;
		sum_b_1[15] <= 40'b0;
	end
	else if(fir_b_sum_1)
	begin
	    sum_b_1[0] <= product_b[0]+product_b[1];
		sum_b_1[1] <= product_b[2]+product_b[3];
		sum_b_1[2] <= product_b[4]+product_b[5];
		sum_b_1[3] <= product_b[6]+product_b[7];
		sum_b_1[4] <= product_b[8]+product_b[9];
		sum_b_1[5] <= product_b[10]+product_b[11];
		sum_b_1[6] <= product_b[12]+product_b[13];
		sum_b_1[7] <= product_b[14]+product_b[15];
		sum_b_1[8] <= product_b[16]+product_b[17];
		sum_b_1[9] <= product_b[18]+product_b[19];
		sum_b_1[10] <= product_b[20]+product_b[21];
		sum_b_1[11] <= product_b[22]+product_b[23];
		sum_b_1[12] <= product_b[24]+product_b[25];
		sum_b_1[13] <= product_b[26]+product_b[27];
		sum_b_1[14] <= product_b[28]+product_b[29];
		sum_b_1[15] <= product_b[30]+product_b[31];
	end
 end
 
 //sum at stage 2
 always@(posedge clk or posedge sclr)
 begin
	if(sclr)
	begin
		sum_b_2[0] <= 40'b0;
		sum_b_2[1] <= 40'b0;
		sum_b_2[2] <= 40'b0;
		sum_b_2[3] <= 40'b0;
		sum_b_2[4] <= 40'b0;
		sum_b_2[5] <= 40'b0;
		sum_b_2[6] <= 40'b0;
		sum_b_2[7] <= 40'b0;
	end
	else if(fir_b_sum_2)
	begin
	    sum_b_2[0] <= sum_b_1[0]+sum_b_1[1];
		sum_b_2[1] <= sum_b_1[2]+sum_b_1[3];
		sum_b_2[2] <= sum_b_1[4]+sum_b_1[5];
		sum_b_2[3] <= sum_b_1[6]+sum_b_1[7];
		sum_b_2[4] <= sum_b_1[8]+sum_b_1[9];
		sum_b_2[5] <= sum_b_1[10]+sum_b_1[11];
		sum_b_2[6] <= sum_b_1[12]+sum_b_1[13];
		sum_b_2[7] <= sum_b_1[14]+sum_b_1[15];
	end
 end
 
 //sum at stage 3
 always@(posedge clk or posedge sclr)
 begin
	if(sclr)
	begin
		sum_b_3[0] <= 40'b0;
		sum_b_3[1] <= 40'b0;
		sum_b_3[2] <= 40'b0;
		sum_b_3[3] <= 40'b0;
	end
	else if(fir_b_sum_3)
	begin
	    sum_b_3[0] <= sum_b_2[0]+sum_b_2[1];
		sum_b_3[1] <= sum_b_2[2]+sum_b_2[3];
		sum_b_3[2] <= sum_b_2[4]+sum_b_2[5];
		sum_b_3[3] <= sum_b_2[6]+sum_b_2[7];
	end
 end
 
 //sum at stage 4
 always@(posedge clk or posedge sclr)
 begin
	if(sclr)
	begin
		sum_b_4[0] <= 40'b0;
		sum_b_4[1] <= 40'b0;
	end
	else if(fir_b_sum_4)
	begin
	    sum_b_4[0] <= sum_b_3[0]+sum_b_3[1];
		sum_b_4[1] <= sum_b_3[2]+sum_b_3[3];
	end
 end
 
 //sum at stage 5
 always@(posedge clk or posedge sclr)
 begin
	if(sclr)
		sum_b_5 <= 40'b0;
	else if(fir_b_sum_5)
	    sum_b_5 <= sum_b_4[0]+sum_b_4[1];
 end
 
 always @(posedge clk) fir_rdy <= (fir_a_rdy | fir_b_rdy);
 
 //fir output ready 
 always@(posedge clk)
 begin
	if(fir_a_rdy)
	begin
		fir_dout <= sum_a_5 [39:22]; 
		fir_chan_out <= chan_in;
	end
	else if(fir_b_rdy)
	begin
		fir_dout <= sum_b_5 [39:22];
		fir_chan_out <= chan_in;
	end
 end
 
 assign dout = fir_dout;
 assign rdy = fir_rdy;
 assign chan_out = fir_chan_out;
 

endmodule
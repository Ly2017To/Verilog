module spi_controller (
    input clk,                 // system clock
    input rst,                 // reset signal
    input trigger_out,         // trigger to transmit
    input gpio_trigger,        // to simulate gpio signal to trigger data transfer to controller from device
    input [31:0] to_device,    // data to send from controller to device
    output spi_clk,            // clock for SPI protocol
    output spi_mosi,           // controller out device in for SPI protocol
    output spi_cs,             // chip select signal for SPI protocol
    input spi_miso,            // controller in device out for SPI protocol
    output [31:0] from_device, // data to receive from device to controller
    output from_device_rdy     // data out ready
);
    
    //to generate spi_clock
    //generated frequency = frequency_clk/((CLK_DIV+1)*2) 
    reg [3:0] clk_div_cnt;        // Clock division counter for SCK generation
    localparam CLK_DIV = 8'b00011000; // Clock division
    reg [7:0] clk_cnt;
    always@(posedge clk or posedge rst)
    begin
        if( rst ) clk_cnt <= 8'h00;
        else if( clk_cnt < CLK_DIV )  clk_cnt <= clk_cnt + 1'b1;
        else clk_cnt <= 8'h0;
    end
    wire div_clk = ( clk_cnt == 8'h1 );
    reg step_clk;
    always@(posedge clk or posedge rst)
    begin
        if( rst ) step_clk <= 1'b0;
        else if( div_clk )  step_clk <= step_clk + 1'b1;
    end
    wire step_clk_p = step_clk & ( clk_cnt == 8'h1 ); //for incrementing the step count

    //bit controll for data out communication
    reg start_out;
    reg [5:0] bit_out_cnt;
    wire busy_out = (bit_out_cnt < 6'd32 );
    always@(posedge clk or posedge rst)
    begin
        if( rst )
        begin
            start_out <= 1'b0;
            bit_out_cnt <= 6'd32;
        end
        else if( {start_out, trigger_out, busy_out } == 3'b010 )  start_out <= 1'b1;
        else if( step_clk_p )
        begin
            if( start_out ) 
            begin
                bit_out_cnt <= 6'd0;
                start_out <= 1'b0;
            end
            else if( bit_out_cnt < 6'd32 )  bit_out_cnt <= bit_out_cnt + 1'b1;
        end
    end

    //chip select for data out communication
    reg busy_out_reg;
    always@(posedge clk or posedge rst)
    begin
        if( rst )   busy_out_reg <= 1'b0;
        else busy_out_reg <= busy_out;
    end

    //data out
    reg spi_mosi_reg;
    always@(posedge clk or posedge rst)
    begin
        if( rst ) spi_mosi_reg <= 1'b0;
        else if (bit_out_cnt < 6'd32) spi_mosi_reg <= to_device[bit_out_cnt];
    end

    //gpio_trigger for data in
    reg [1:0] gpio_trigger_buf;
    always@(posedge clk or posedge rst)
    begin
        if( rst ) gpio_trigger_buf <= 1'b1;
        else gpio_trigger_buf <= {gpio_trigger_buf[0],gpio_trigger};
    end
    wire trigger_in = (gpio_trigger_buf==2'b10);

    //bit controll for data in communication
    reg start_in;
    reg [5:0] bit_in_cnt;
    wire busy_in = (bit_in_cnt < 6'd32 );
    always@(posedge clk or posedge rst)
    begin
        if( rst )
        begin
            start_in <= 1'b0;
            bit_in_cnt <= 6'd33;
        end
        else if( {start_in, trigger_in} == 2'b01 )  start_in <= 1'b1;
        else if( step_clk_p )
        begin
            if( start_in ) 
            begin
                bit_in_cnt <= 6'd0;
                start_in <= 1'b0;
            end
            else if( bit_in_cnt < 6'd32 )  bit_in_cnt <= bit_in_cnt + 1'b1;
        end
    end

    //chip select for data out communication
    reg busy_in_reg;
    always@(posedge clk or posedge rst)
    begin
        if( rst )   busy_in_reg <= 1'b0;
        else busy_in_reg <= busy_in;
    end

    //data in
    reg [31:0] spi_miso_buff; 
    always@(posedge step_clk or posedge rst)
    begin
        if( rst ) spi_miso_buff <= 32'b0;
        else if (bit_in_cnt < 6'd32) spi_miso_buff <= {spi_miso_buff[30:0],spi_miso};
    end

    reg from_device_rdy_reg;
    reg [31:0] from_device_reg;
    always@(posedge step_clk or posedge rst)
    begin
        if( rst )
        begin
            from_device_rdy_reg <= 1'b0;
            from_device_reg <= 32'b0;
        end
        else if(bit_in_cnt==6'd32)
        begin
            from_device_reg <= spi_miso_buff;
            from_device_rdy_reg <= 1'b1;
            //bit_in_cnt <= 6'b0;
        end
        else from_device_rdy_reg <= 1'b0;
    end

    assign from_device = from_device_reg;
    assign from_device_rdy = from_device_rdy_reg;

    assign spi_clk = step_clk;      // SPI clock
    assign spi_cs = ((~busy_in_reg)&(~busy_out_reg));  // SPI chip select  
    assign spi_mosi = spi_mosi_reg; // SPI data from controller to device

endmodule
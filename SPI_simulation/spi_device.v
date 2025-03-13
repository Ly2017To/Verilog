module spi_device (
    input clk,             // system clock
    input rst,             // reset signal
    input spi_clk,         // SPI clock (SCK) from the controller
    input spi_mosi,        // controller out device in for SPI protocol
    input spi_cs,          // chip select signal for SPI protocol from the controller
    input gpio_trigger,    // to simulate gpio signal to trigger data transfer to controller from device
    input [31:0] to_controller, // data to be sent to controller when gpio triggers enabled
    output spi_miso        // controller in device out for SPI protocol 
);

    reg [31:0] data_from_controller;    // 32-bit register to store the data from controller
    reg [31:0] data_to_controller;      //32-bit register to store the data to controller
    reg [5:0] bit_in_cnt;   // 6-bit counter for bit positions (0-31 for 32 bits)
    reg [5:0] bit_out_cnt;  // 6-bit counter for bit positions (0-31 for 32 bits)
    reg active;              // Indicates if SPI is active
    reg spi_miso_reg;        // register for data to be transmitted to controller

    // Reset or setup initial conditions
    always @(posedge clk or posedge rst) 
    begin
        if (rst) active <= 1'b0; // set active signal to low
        else if (spi_cs == 1'b0) active <= 1'b1; // SPI is active when CS is low
        else active <= 1'b0;     // SPI is inactive when CS is high
    end

    // receive data from controller and store it into a register
    always @(posedge spi_clk or posedge rst) 
    begin
        if (rst) 
        begin
           data_from_controller <= 32'b0;  // clear data register
           bit_in_cnt <= 6'b0;     // reset bit counter
        end 
        else if (active)
        begin
            if (bit_in_cnt < 6'd32) 
            begin
                bit_in_cnt <= bit_in_cnt + 1;
                data_from_controller <= {data_from_controller[30:0], spi_mosi};
            end 
            else bit_in_cnt <= 6'b0;
        end
    end

    // send data to controller when gpio enables
    // gpio_trigger for data in
    reg [1:0] gpio_trigger_buf;
    always@(posedge clk or posedge rst)
    begin
        if( rst ) gpio_trigger_buf <= 1'b1;
        else gpio_trigger_buf <= {gpio_trigger_buf[0],gpio_trigger};
    end
    wire trigger_out = (gpio_trigger_buf==2'b10);

    always @(posedge clk or posedge rst) 
    begin
        if (rst) data_to_controller <= 32'b0;  
        else if(trigger_out) data_to_controller <= to_controller;
    end

    reg start_out;
    always @(posedge spi_clk or posedge rst) 
    begin
        if (rst)
        begin
            bit_out_cnt <= 6'b0;
            spi_miso_reg <= 1'b0;
            start_out <= 1'b0;
        end
        else if (active)
        begin
            if ({trigger_out,start_out}==2'b10) 
            begin
                start_out <=1'b1;
                spi_miso_reg <= data_to_controller[0];
                bit_out_cnt <= 1;
            end
            else 
            begin
                if (bit_out_cnt < 6'd32)
                begin
                    bit_out_cnt <= bit_out_cnt + 1;
                    spi_miso_reg <= data_to_controller[bit_out_cnt];
                end 
                else
                begin 
                    bit_out_cnt <= 6'b0;
                    start_out <= 1'b0;
                end
            end 
        end
    end

    assign spi_miso = spi_miso_reg;

endmodule
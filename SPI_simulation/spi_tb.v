`timescale 1ns / 1ps

module spi_tb;
    reg clk;
    reg rst;
    reg trigger_out;
    reg gpio_trigger;
    reg [31:0] data_to_device;
    reg [31:0] data_to_controller;
    wire [31:0] data_from_device;
    wire data_from_device_rdy;
    wire spi_clk;
    wire spi_mosi;
    wire spi_miso;
    wire spi_cs;

    spi_controller uut_controller (
        .clk(clk),              
        .rst(rst),               
        .trigger_out(trigger_out),
        .gpio_trigger(gpio_trigger),         
        .to_device(data_to_device),    
        .spi_clk(spi_clk),          
        .spi_mosi(spi_mosi),         
        .spi_cs(spi_cs),           
        .spi_miso(spi_miso),          
        .from_device(data_from_device),  
        .from_device_rdy(data_from_device_rdy)      
    );

    spi_device uut_device (
        .clk(clk),
        .rst(rst),
        .spi_clk(spi_clk),
        .spi_mosi(spi_mosi),
        .spi_cs(spi_cs),
        .gpio_trigger(gpio_trigger),
        .to_controller(data_to_controller),
        .spi_miso(spi_miso)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // Generate clock with period of 10 time units, so 100MHz
    end

    initial begin

        // Set up VCD file for waveform dump
        $dumpfile("spi_tb.vcd");   // Specify the VCD file name
        $dumpvars(0, spi_tb);      // Dump all signals in the top-level module (spi_tb)

        clk = 0;
        rst = 0;
        trigger_out = 0;
        data_to_device = 32'hA5A5A5A5; // data to transmit from controller to device
        data_to_controller = 32'h5A5A5A5A; // data to transmit from device to controller

        // Reset the system
        rst = 1;
        gpio_trigger = 1; // gpio is idle when state is 1, it triggers transmittion when goes to 0
        #10;
        rst = 0;
        #10;

        // Start the SPI communication, transmit data_to_device
        trigger_out = 1;
        #17000;
        trigger_out = 0;
        #3000;

        // Start the SPI communication, transmit data_to_controller
        gpio_trigger = 0;
        #17000;
        gpio_trigger = 1;
        #3000;

        $finish;
    end
endmodule
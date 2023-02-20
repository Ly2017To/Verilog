module led_sequencer_tb;
    parameter MAX_LEN = 8;
    wire [MAX_LEN-1:0] led;
    reg clk,rst;

    initial
        begin 
            $dumpfile("wave.vcd");      // create a VCD waveform dump called "wave.vcd"
            $dumpvars(0, led_sequencer_tb); // dump variable changes in this testbench and all modules under it
            
            clk=1'b0;
            rst=1'b1;
            #11 rst=1'b0;
        end

    always
        begin
            #1 clk=1'b0;
            #2 clk=1'b1;

            if($time>200)
                $finish;
        end

    led_sequencer #(.MAX_LENGTH(MAX_LEN)) uut(.clk(clk), .rst(rst), .led_out(led));

    always@(led)
        $display("At time",$time,",LEDS=%b",led);
        
endmodule
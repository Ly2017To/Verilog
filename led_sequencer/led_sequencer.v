module led_sequencer(
    clk,
    rst,
    led_out
   );
    
    parameter MAX_LENGTH=8;

    input clk,rst;
    output reg[MAX_LENGTH-1:0] led_out;

    always@(posedge clk, posedge rst)
        if(rst)
            led_out <= {MAX_LENGTH{1'b0}};
        else
            if(led_out == {MAX_LENGTH{1'b1}})
                led_out <= {MAX_LENGTH{1'b0}};
            else
                led_out <= {1'b1,led_out[MAX_LENGTH-1:1]};

endmodule
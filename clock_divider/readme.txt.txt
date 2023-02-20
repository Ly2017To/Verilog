This exercise is a clock divider.

parameter COUNT_REG_SIZE //the length of the bits of the counter
parameter DIV_RATIO //the ratio to divide
//for example, COUNT_REG_SIZE=2, DIV_RATIO=4; 

Simulator: Icarus Verilog

iverilog -o divider_test.o *.v
vvp divider_test.o
gtkwave wave.vcd

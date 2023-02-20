This exercise is from book A Verilog HDL Primer, 3rd Edition

Simulator: Icarus Verilog

iverilog -o divider_test.o *.v
vvp divider_test.o
gtkwave wave.vcd

This exercise is from book A Verilog HDL Primer, 3rd Edition

Each bit of the shift register shows the state of a led

Simulator: Icarus Verilog

iverilog -o led_test.o *.v
vvp led_test.o
gtkwave wave.vcd

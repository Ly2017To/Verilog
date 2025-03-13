# This repository contains VERILOG SIMULATION for SPI protocol.

SPI (Serial Peripheral Interface) is a widely used full duplex and synchronous communication protocol that enables data transfer between a controller device and one or more devices. It uses a clock signal (SCK), a chip select (CS) signal, a MOSI line, and a MISO line for communication.

- The **controller** is responsible for generating the clock signal (`SCK`), controlling the chip select (`CS`) line, and sending data via the **MOSI** line.
- The **device** receives the clock signal (`SCK`), chip select (`CS`), and data from the **MOSI** line. It then transmits data back to the controller via the **MISO** line.

## Key Terms:
- **Controller**: The entity that controls the communication (generates the clock, selects the device, and sends/receives data).
- **Device**: The entity that responds to the controller's commands and communicates back. It can also sends GPIO to controller to notify controller to receive data. So there are two counters for sending and receiving data from both sides.

### Overview of Verilog Example:

1. **SPI Controller Module**: 
    - Generates the clock signal.
    - Sends data to the device via MOSI.
    - Receives data from the device via MISO.

2. **SPI Device Module**: 
    - Receives data via MOSI.
    - Responds to the controller’s clock signal.
    - Sends data back to the controller via MISO.

3. **Testbench**:
    - Simulates data transfer between the controller and the device.
    - Monitors the communication and checks if data is transferred correctly.

### Simulation Steps with Iverilog and GTKWave:
1.iverilog -o test.vvp spi_controller.v spi_device.v spi_tb.v
2.vvp test.vvp
3.gtkwave spi_tb.vcd

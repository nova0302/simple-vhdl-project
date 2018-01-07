
* Important
  - the pin file should have one blank line at the top of the file.

* This is a sample project for vhdl rtl && gate sim and pnr with Modelsim and Quartus.

** rtl simulation.
   1. put your vhdl design files in ./rtl/vhdl/
   2. go to ./design/sim/rtl_sim
   3. "make"

** pnr your design
   1. go to ./pnr/quartus
   2. "make"

** gate simulation
1. go to ./design/sim/gate_sim
2. "make"

** download the design to FPGA
   1. go to ./design/pnr/quartus
   2. "make program"


open_hw
connect_hw_server -url localhost:3121
current_hw_target [get_hw_targets]
set_property PARAM.FREQUENCY 15000000 [get_hw_targets */xilinx_tcf/Digilent/210279A6A6F9A]
open_hw_target

# Program and Refresh the XC7K325T Device
set_property PROGRAM.FILE {led_test.bit} [lindex [get_hw_devices] 1]
program_hw_devices [lindex [get_hw_devices] 1]

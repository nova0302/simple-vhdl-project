set TOP led_test
set PART xc7z010clg400-1


# Assemble the Design Source Files
read_vhdl -vhdl2008 ./../../../rtl/vhdl/led_test.vhd
#read_vhdl -vhdl2008 [glob ./../../../rtl/vhdl/*.vhd]
#read_verilog [glob ./../../../rtl/verilog/*.v]
#read_edif ./Sources/top.edif
#read_ip ./Sources/IP/my_ip.xco ./Sources/IP/my_ip2.xci
#         ~~.xco -> core generator   ~~.xci -> vivado
read_xdc ZYBO_Master.xdc


set outputDir ./output_files

#Run Synthesis and Implementation

file mkdir $outputDir

# Run Synthesis and Implementation
synth_design -top $TOP -part $PART
write_checkpoint -force $outputDir/post_synth

report_utilization -file $outputDir/post_route_util.rpt
report_timing -sort_by group -max_paths 6 -path_type summary -file $outputDir/post_synth_timing.rpt
report_timing_summary -file $outputDir/post_route_timing.rpt

opt_design

place_design
write_checkpoint -force $outputDir/post_place

route_design
write_checkpoint -force $outputDir/post_route

#generate reports
report_timing_summary -file $outputDir/post_route_timing_summary.rpt
report_timing -sort_by group -max_paths 100 -path_type summary -file $outputDir/post_route_timing.rpt
report_utilization -file $outputDir/post_route_util.rpt
report_drc -file $outputDir/post_imp_drc.rpt
write_verilog -force $outputDir/led_test_imp_netlist.v
write_xdc -no_fixed_only -force $outputDir/led_test_imp.xdc

#Generate Bit File
write_bitstream ./led_test.bit

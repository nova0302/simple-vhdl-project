set TOP led_test
set PART xc7z010clg400-1
set outputDir ./output_files
file mkdir $outputDir

#Assemble
read_vhdl -vhdl2008 ./../../../rtl/vhdl/edge_detect.vhd
read_vhdl -vhdl2008 ./../../../rtl/vhdl/led_test.vhd
read_xdc ZYBO_Master.xdc

#Synthesis
synth_design -top $TOP -part $PART
opt_design
place_design
route_design

#generate reports
report_timing_summary -file $outputDir/post_route_timing_summary.rpt
report_utilization -file $outputDir/post_route_util.rpt

#bit file generation
write_bitstream ./$TOP.bit

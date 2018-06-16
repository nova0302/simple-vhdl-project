PRJ = led_test
OUTPUT_DIR=output_files

$(PRJ).bit:my-build.tcl
	@echo "---  Building the project ----"
#	vivado -mode batch -source my-build.tcl
	vivado -mode batch -source npb-build.tcl
program: $(PRJ).bit
	@echo "---  Programming the device ----"
	vivado -mode batch -source my-download.tcl
clean:
	@echo "---  Deleting the files ----"
	rm -rf $(PRJ).bit *.log *.jou *.html *.xml $(OUTPUT_DIR) .xil *.xml *.str *.jou *.html *.xpr *.cache led_test.*

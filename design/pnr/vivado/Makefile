PRJ = led_test
OUTPUT_DIR=output_files

$(PRJ).bit:
	vivado -mode batch -source my-build.tcl
program: $(PRJ).bit
	@echo "script is not created yet!!!"
	vivado -mode batch -source my-download.tcl
clean:
	rm -rf $(PRJ).bit *.log *.jou *.html *.xml $(OUTPUT_DIR) .xil *.xml *.str *.jou *.html

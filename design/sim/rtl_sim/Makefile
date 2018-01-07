VLIB =  vlib
VCOM =  vcom
VSIM =  vsim

WORK = work

VCOM_OPTIONS = -2008
VSIM_OPTIONS = -c -novopt -do "run -all; quit"
GVSIM_OPTIONS = -novopt -do "add wave *; radix -hex; run -all; quit"

VDIR =./../../../rtl/vhdl
VSRCS =$(wildcard $(VDIR)/*.vhd)

DUT  = led_test
TB   = $(DUT)_tb
V=@
all: lib com sim
sim:
	$(V)echo " "
	$(V)echo " -------   Starting Simulation!!!!!  --------------------"
	$(VSIM) $(VSIM_OPTIONS) $(WORK).$(TB)
gsim:
	$(V)echo " "
	$(V)echo " -------   Starting Simulation!!!!!  --------------------"
	$(VSIM) $(GVSIM_OPTIONS) $(WORK).$(TB)
com:
	$(V)echo " "
	$(V)echo " -------   Compiling verilog source files !!! ------------"
	$(VCOM) $(VCOM_OPTIONS) -work $(WORK) $(VSRCS)
	$(V)echo " "
	$(V)echo " -------   Compiling testbench !!! ------------"
	$(VCOM) $(VCOM_OPTIONS) -work $(WORK) $(VDIR)/$(TB).vhd
#	$(VLOG) $(Vcom_OPTIONS) -f vcom.args

lib:
	$(V)echo " -------   Generate $(WORK) directory if it does not exist!!! ----------"
	$(V)if [ -d $(WORK) ]; then vdel -lib $(WORK) -all && vlib $(WORK); fi
	@if [ -d $(WORK) ]; then vdel -lib $(WORK) && vlib $(WORK); fi
	@if [ ! -d $(WORK) ]; then vlib $(WORK); fi

clean:
	rm -rf $(WORK) transcript *.wlf

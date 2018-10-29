VLIB =  vlib
VCOM =  vcom
VLOG =  vlog
VSIM =  vsim

WORK = work

VCOM_OPTIONS = -2008
VLOG_OPTIONS = -sv
VSIM_OPTIONS = -c -novopt -do "run -all; quit"
GVSIM_OPTIONS = -novopt -do "add wave *; radix -hex; run -all; quit"

DUT  = led_test
TB   = $(DUT)_tb

VDIR =./../../../rtl/vhdl
_SRCS=edge_detect.vhd $(DUT).vhd  $(TB).vhd 

SRCS=$(addprefix $(VDIR)/,$(_SRCS))
#SRCS =$(wildcard $(VDIR)/*.vhd)

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
	$(VLOG) $(VLOG_OPTIONS) -f vlog.args
#	$(VCOM) $(VCOM_OPTIONS) -work $(WORK) $(SRCS)
#	$(V)echo " "
#	$(V)echo " -------   Compiling testbench !!! ------------"
#	$(VCOM) $(VCOM_OPTIONS) -work $(WORK) $(VDIR)/$(TB).vhd
#	$(VLOG) $(Vcom_OPTIONS) -f vcom.args

lib:
	$(V)echo " -------   Generate $(WORK) directory if it does not exist!!! ----------"
	@if [ -d $(WORK) ]; then rm -rf $(WORK) && vlib $(WORK); fi
	@if [ ! -d $(WORK) ]; then vlib $(WORK); fi

clean:
	rm -rf $(WORK) transcript *.wlf
test:
	echo $(SRCS)

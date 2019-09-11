# TARGET = tb-dsp-32add
TARGET = tb-dsp-16mul
# TARGET = tb-dsp-triple16mul
PINCONFIG = pins.pcf

RM		= rm -rf
DEL		= rm -rf

all: yosys nextpnr icepack run

yosys:
	yosys -qp "synth_ice40 -blif $(TARGET).blif; write_json $(TARGET).json" $(TARGET).v
nextpnr:
	nextpnr-ice40 -q --up5k --package uwg30 --json $(TARGET).json --pcf $(PINCONFIG) --asc $(TARGET).asc
icepack:
	icepack $(TARGET).asc $(TARGET).bin
run:
	sudo iceprog -S $(TARGET).bin
clean:
	rm *.json *.bin *.blif *.asc
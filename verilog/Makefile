# TARGET = tb-upe-add16
# TARGET = tb-upe-add32
# TARGET = tb-upe-add64
# TARGET = tb-upe-mul16
TARGET = tb-upe-triplemul16
# TARGET = tb-upe-negate32
# TARGET = tb-upe-negate16
# TARGET = tb-upe-abs16
# TARGET = tb-upe-abs32
PINCONFIG = pins.pcf


all: yosys nextpnr icepack run clean

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
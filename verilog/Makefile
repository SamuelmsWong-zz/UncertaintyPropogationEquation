# TARGET = tb-upe-add16
# TARGET = tb-upe-add32
# TARGET = tb-upe-add64
# TARGET = tb-upe-mul16
# TARGET = tb-upe-triplemul16
# TARGET = tb-upe-tripleadd32
# TARGET = tb-upe-tripleadd64
# TARGET = tb-upe-negate16
# TARGET = tb-upe-negate32
# TARGET = tb-upe-negate64
# TARGET = tb-upe-abs16
# TARGET = tb-upe-abs32
# TARGET = tb-upe-resign64
TARGET = tb-upe

PINCONFIG = pins.pcf


all: yosys nextpnr icepack run clean

yosys:
	yosys -p "synth_ice40 -blif $(TARGET).blif; write_json $(TARGET).json; stat" $(TARGET).v
nextpnr:
	nextpnr-ice40 --up5k --package uwg30 --json $(TARGET).json --pcf $(PINCONFIG) --asc $(TARGET).asc
icepack:
	icepack $(TARGET).asc $(TARGET).bin
run:
	sudo iceprog -S $(TARGET).bin
clean:
	rm *.json *.bin *.blif *.asc

	yosys -p 'hierarchy -top picorv32; proc_arst; proc_dff; techmap t:$dff t:$adff; opt_clean; select -count t:$_DFF*_' picorv32.v
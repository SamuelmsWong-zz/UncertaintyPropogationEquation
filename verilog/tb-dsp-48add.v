`include "dsp-add.v"
module tb_dsp_48add(led0);
	output led0;

	wire		clk;
	reg		LED0status = 0;
	reg [31:0]	count = 0;
	reg [5:0]	bitnum = 0;

	reg [47:0]	x1;
	reg [47:0]	x2;
	reg		carryin = 1;

	wire [47:0]	y;
	wire		carryout;

	/*
	 *	Creates a 10kHz clock signal from
	 *	internal oscillator of the iCE40
	 */
	SB_LFOSC OSCInst1 (
		.CLKLFPU(1'b1),
		.CLKLFEN(1'b1),
		.CLKLF(clk)
	);
	dsp_48add adder(
		.A(x1[47:0]),
		.B(x2[47:0]),
		.Out(y[47:0]),
		.carryin(carryin),
		.carryout(carryout),
	);

	initial begin
		x1 = 48'h007FFF3CF7D7;
		x2 = 48'hFFFFFFFFFFFF;
		// y = 48'h007FFF3CF7D7; You might recognise this rythym...
	end

	always @(posedge clk) begin
		if (count > 1250) begin
			count <= 0;
			bitnum <= bitnum + 1;
			if (bitnum > 47) begin
				bitnum <= 0;
			end
			LED0status <= y[bitnum];
		end
		else begin
			count <= count + 1;
		end
	end

	assign	led0 = LED0status;
endmodule

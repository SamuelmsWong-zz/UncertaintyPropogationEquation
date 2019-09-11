`include "dsp-add.v"
module tb_dsp_16add(led0);
	output led0;

	wire		clk;
	reg		LED0status = 0;
	reg [31:0]	count = 0;
	reg [4:0]	bitnum = 0;

	reg [31:0]	x1;
	reg [31:0]	x2;
	reg		carryin;

	wire [31:0]	y;
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
	dsp_16adduu adder(
		.A(x1[31:16]),
		.B(x1[15:0]),
		.C(x2[31:16]),
		.D(x2[15:0]),
		.Out1(y[31:16]),
		.Out2(y[15:0]),
	);
	initial begin
		x1 = 32'h67510B12;
		x2 = 32'hCD840A1F;
		// y = 32'h34D51531; You might recognise this rythym...

		// x1 = 32'h7F7DF7D8;
		// x2 = 32'hFFFFFFFF;
		// // y = 32'h7F7DF7D7; You might recognise this rythym...

		// x1 = 32'h55555556;
		// x2 = 32'hFFFFFFFF;
		// // y = 32'h7F7DF7D7; You might recognise this rythym...
	end

	always @(posedge clk) begin
		if (count > 1250) begin
			count <= 0;
			bitnum <= bitnum + 1;
			LED0status <= y[bitnum];
		end
		else begin
			count <= count +1;
		end
	end

	assign	led0 = LED0status;
endmodule

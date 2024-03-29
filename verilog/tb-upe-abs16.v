`include "upe-abs.v"

module tb_upe_abs16(led0);
	output led0;

	wire		clk;
	reg		LED0status = 0;
	reg [31:0]	count = 0;
	reg [4:0]	bitnum = 0;

	reg [31:0]	x;

	wire [31:0]	y;

	/*
	 *	Creates a 10kHz clock signal from
	 *	internal oscillator of the iCE40
	 */
	SB_LFOSC OSCInst1
	(
		.CLKLFPU(1'b1),
		.CLKLFEN(1'b1),
		.CLKLF(clk)
	);

	upe_abs16s abs
	(
		.In1(x[31:16]),
		.In2(x[15:0]),
		.Out1(y[31:16]),
		.Out2(y[15:0]),
	);

	initial begin
		// x = 32'hCB2BEACF;
		x = 32'h34D51531;
		// // y = 32'h34D51531; You might recognise this rythym...
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

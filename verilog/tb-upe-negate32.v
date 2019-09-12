`include "upe-negate.v"
module tb_upe_negate32(led0);
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
	SB_LFOSC OSCInst1 (
		.CLKLFPU(1'b1),
		.CLKLFEN(1'b1),
		.CLKLF(clk)
	);
	upe_negate32 negate(
		.In(x[31:0]),
		.Out(y[31:0]),
	);
	initial begin
		x = 32'hCB2AEACF;
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

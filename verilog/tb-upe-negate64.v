`include "upe-negate.v"
module tb_upe_negate64(led0);
	output led0;

	wire		clk;
	reg		LED0status = 0;
	reg [31:0]	count = 0;
	reg [5:0]	bitnum = 0;

	reg [63:0]	x;

	wire [63:0]	y;

	/*
	 *	Creates a 10kHz clock signal from
	 *	internal oscillator of the iCE40
	 */
	SB_LFOSC OSCInst1 (
		.CLKLFPU(1'b1),
		.CLKLFEN(1'b1),
		.CLKLF(clk)
	);

	upe_negate64u negate(
		.In(x[63:0]),
		.Out(y[63:0]),
	);

	initial begin
		x = 64'hA32AEACECB2AEACE;
		// // y = 32'h5CD5153134D51531; You might recognise this rythym...
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

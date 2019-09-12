`include "upe-add.v"
module tb_upe_add64(led0);
	output led0;

	wire		clk;
	reg		LED0status = 0;
	reg [31:0]	count = 0;
	reg [6:0]	bitnum = 0;

	reg [63:0]	x1;
	reg [63:0]	x2;
	reg		carryin = 1;

	wire [63:0]	y;
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
	upe_add64uu adder(
		.A(x1[63:0]),
		.B(x2[63:0]),
		.Out(y[63:0]),
		.carryin(carryin),
		.carryout(carryout),
	);

	initial begin
		x1 = 64'h5CD5153134D51531;
		x2 = 64'hFFFFFFFFFFFFFFFF;
		// y = 64'h007FFF3CF7D7; You might recognise this rythym...
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

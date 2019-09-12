`include "upe-mul.v"
module tb_upe_mul16(led0);
	output led0;

	wire		clk;
	reg		LED0status = 0;
	reg [31:0]	count = 0;
	reg [4:0]	bitnum = 0;

	reg [15:0]	x1;
	reg [15:0]	x2;

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
	upe_mul16uu muler(
		.A(x1[15:0]),
		.B(x2[15:0]),
		.Out(y[31:0]),
		.A_SIGNED(1'b1),
		.B_SIGNED(1'b1),
	);

	initial begin
		x1 = 16'h3953;
		x2 = 16'h5ACD;
		// y = 32'h14551577; You might recognise this rythym...
	end

	always @(posedge clk) begin
		if (count > 1250) begin
			count <= 0;
			bitnum <= bitnum + 1;
			LED0status <= y[bitnum];
		end
		else begin
			count <= count + 1;
		end
	end

	assign	led0 = LED0status;
endmodule

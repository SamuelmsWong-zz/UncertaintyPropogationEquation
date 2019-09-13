`include "upe-mul.v"
module tb_upe_mul16(led0, led1, led2);
	output led0;
	output led1;
	output led2;

	wire		clk;
	reg		LED0status = 0;
	reg		LED1status = 0;
	reg		LED2status = 0;
	reg [31:0]	count = 0;
	reg [4:0]	bitnum = 0;

	reg [15:0]	x1;
	reg [15:0]	x2;

	wire [31:0]	y;
	reg [31:0]	test;

	/*
	 *	Creates a 10kHz clock signal from
	 *	internal oscillator of the iCE40
	 */
	SB_LFOSC OSCInst1(
		.CLKLFPU(1'b1),
		.CLKLFEN(1'b1),
		.CLKLF(clk)
	);

	upe_mul16uu muler(
		.A(x1[15:0]),
		.B(x2[15:0]),
		.Out(y[31:0]),
	);

	initial begin
		// x1 = 16'h0003;
		// x2 = 16'h0003;
		x1 = 16'h3953;
		x2 = 16'h5ACD;
		// y = 32'h14551577; You might recognise this rythym...
		// test = 32'h00000009;
	end

	always @(posedge clk) begin
		if (count > 1000) begin
			count <= 0;
			bitnum <= bitnum + 1;
			LED0status <= y[bitnum];
			// LED0status <= test[bitnum];
		end
		else begin
			count <= count + 1;
		end
	end

	assign	led0 = LED0status;
	assign	led1 = LED1status;
	assign	led2 = LED2status;

endmodule

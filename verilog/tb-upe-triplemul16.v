`include "upe-triplemul.v"
module tb_upe_triplemul16(led0, led1, led2);
	output led0;
	output led1;
	output led2;

	wire		clk;
	wire [63:0]	y;
	wire [63:0]	test;

	reg		LED0status = 0;
	reg		LED1status = 0;
	reg		LED2status = 0;
	reg [31:0]	count = 0;
	reg [6:0]	bitnum = 0;

	reg [15:0]	x1;
	reg [15:0]	x2;
	reg [15:0]	x3;



	/*
	 *	Creates a 10kHz clock signal from
	 *	internal oscillator of the iCE40
	 */
	SB_LFOSC OSCInst1(
		.CLKLFPU(1'b1),
		.CLKLFEN(1'b1),
		.CLKLF(clk)
	);

	upe_triplemul16uuu upe_triplemuler(
		.A(x1[15:0]),
		.B(x2[15:0]),
		.C(x3[15:0]),
		.Out(y[63:0]),
		.probe(test),
	);

	initial begin
		x1 = 16'h0003;
		x2 = 16'h0003;
		x3 = 16'h0003;
		// y = 64'h000000007F7DF7D7; You might recognise this rythym...

		// x1 = 16'h3281;
		// x2 = 16'h1E6D;
		// x3 = 16'h1553;
		// y = 64'h0000007FFF3CF7D7; You might recognise this rythym...
		// test = 64'h5555555555555555;
	end

	always @(posedge clk) begin
		if (count > 1250) begin
			count <= 0;
			bitnum <= bitnum + 1;
			// LED0status <= y[bitnum];
			LED0status <= test[bitnum];
		end
		else begin
			count <= count +1;
		end
	end

	assign	led0 = LED0status;
	assign	led1 = LED1status;
	assign	led2 = LED2status;
endmodule

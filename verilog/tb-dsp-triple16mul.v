`include "dsp-triple16mul.v"
module tb_dsp_triple16mul(led0/*,led1*/);
	output led0;
	// output led1;

	wire		clk;
	reg		LED0status = 0;
	reg [31:0]	count = 0;
	reg [5:0]	bitnum = 0;

	reg [15:0]	x1;
	reg [15:0]	x2;
	reg [15:0]	x3;

	wire [47:0]	y;

	/*
	 *	Creates a 10kHz clock signal from
	 *	internal oscillator of the iCE40
	 */
	SB_LFOSC OSCInst1(
		.CLKLFPU(1'b1),
		.CLKLFEN(1'b1),
		.CLKLF(clk)
	);
	dsp_triple16mul dsp_triple16muler(
		.A(x1[15:0]),
		.B(x2[15:0]),
		.C(x3[15:0]),
		.Out(y[47:0]),
	);

	initial begin
		// x1 = 16'h1395;
		// x2 = 16'h0529;
		// x3 = 16'h0143;
		// y = 48'h00007F7DF7D7; You might recognise this rythym...

		x1 = 16'h3281;
		x2 = 16'h1E6D;
		x3 = 16'h1553;
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
	// assign	led1 = LED0status;
endmodule

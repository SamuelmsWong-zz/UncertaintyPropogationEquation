`include "upe.v"
// `include "upe-noDSP.v"

module tb_upe (led0, led1, led2);
	output		led0;
	output		led1;
	output		led2;

	wire		clk;
	wire [63:0]	var_z;

	reg		LED0status = 0;
	reg		LED2status = 0;
	reg [31:0]	count = 0;
	reg [6:0]	bitnum = 0;

	reg [15:0]	var_x;
	reg [15:0]	var_y;
	reg [15:0]	covar_xy;
	reg [15:0]	dfdx;
	reg [15:0]	dfdy;

	reg		on;


	/*
	 *	Creates a 10kHz clock signal from
	 *	internal oscillator of the iCE40
	 */
	SB_LFOSC OSCInst1 (
		.CLKLFPU(1'b1),
		.CLKLFEN(1'b1),
		.CLKLF(clk)
	);

	upe	propagate
	(
		.var_x(var_x),
		.var_y(var_y),
		.covar_xy(covar_xy),
		.dfdx(dfdx),
		.dfdy(dfdy),
		.var_z(var_z),
	);

	initial begin
		on = 1'b1;
		var_x = 	16'h 1395;
		dfdx = 		16'h 0529;
		covar_xy = 	16'h 0143;
		dfdy = 		16'h 3281;
		var_y = 	16'h 1E6D;

		// var_x = 	16'h1111;
		// dfdx = 		16'h1111;
		// covar_xy = 	16'h1111;
		// dfdy = 		16'h1111;
		// var_y = 	16'h1111;
		// max 64'h0000 E0FD 3F02 DFFF 002096A3765
		// max 64'h0000 D2ED 5D02 CFFF 00291A0CC76
		// max 64'h0000 E0FD 3F02 DFFF 12F255A5F6D
		//			       133C0656348
		//	536C12C5DF1
		// 10011001001110111100101001111110100001101
		// var_z = 64'h0000 007F FF3C F7D7; You might recognise this rythym...
	end

	always @(posedge clk) begin
		if (count > 100) begin
			LED2status <= !LED2status;
		end

		if (on == 1'b1) begin
			if (count > 100) begin
				count <= 0;
				bitnum <= bitnum + 1;
				if (bitnum > 63) begin
					on <= 1'b0;
				end
				LED0status <= var_z[bitnum];
			end
			else begin
				count <= count + 1;
			end
		end
		else begin
			LED0status <= 0;
		end
	end

	// assign	led0 = LED0status;
	// assign	led1 = LED0status;
	// assign	led2 = LED2status;

	assign	led0 = 1'b1;
	assign	led1 = 1'b1;
	assign	led2 = 1'b1;


endmodule
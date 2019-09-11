`include "dsp-32add.v"
`include "dsp-triple16mul.v"
module upe(var_x, var_y, covar_xy, dfdx, dfdy, var_z);
	wire		clk;

	input [15:0]	var_x;
	input [15:0]	var_y;
	input [15:0]	covar_xy;
	input [15:0]	dfdx;
	input [15:0]	dfdy;
	output [15:0]	var_z;


	/*
	 *	SB_HFOSC generates a 48MHz clock
	 */
	SB_HFOSC OSCInst1
	(
		.CLKHFPU(1'b1),
		.CLKHFEN(1'b1),
		.CLKHF(clk)
	);
	dsp_triple16mul mulx
	(
		.A(),
		.B(),
		.C(),
		.O(),
	);
	dsp_triple16mul muly
	(
		.A(),
		.B(),
		.C(),
		.O(),
	);

	always @(posedge clk) begin

		var_z <= var_x + var_y;
	end

endmodule


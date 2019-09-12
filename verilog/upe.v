`ifndef GOT_UPE_TRIPLEADDV
	`include "upe-tripleadd.v"
`endif
`ifndef GOT_UPE_TRIPLEMUL16V
	`include "upe-triplemul.v"
`endif
`ifndef GOT_UPE_ABSV
	`include "upe-abs.v"
`endif

`define GOT_UPEV

module upe(var_x, var_y, covar_xy, dfdx, dfdy, var_z);
	wire		clk;

	input [15:0]	var_x;
	input [15:0]	var_y;
	input [15:0]	covar_xy;
	input [15:0]	dfdx;
	input [15:0]	dfdy;
	output [63:0]	var_z;

	wire [15:0]	abs_covar_xy;
	wire [15:0]	abs_dfdx;
	wire [15:0]	abs_dfdy;

	wire		sign_covar_xy;
	wire		sign_dfdx;
	wire		sign_dfdy;

	wire [63:0]	term_x;
	wire [63:0]	abs_term_xy;
	wire [63:0]	term_xy;
	wire [63:0]	term_y;


	/*
	 *	SB_HFOSC generates a 48MHz clock
	 */
	SB_HFOSC OSCInst1
	(
		.CLKHFPU(1'b1),
		.CLKHFEN(1'b1),
		.CLKHF(clk)
	);

	upe_abs16s abs_grad
	(
		.In1(dfdx),
		.In2(dfdx),
		.Out1(abs_dfdx),
		.Out2(abs_dfdx),
		.popsign1(sign_dfdx),
		.popsign2(sign_dfdy),
	);

	upe_abs16s abs_covar
	(
		.In1(covar_xy),
		.In2(16'h0000), // default
		.Out1(abs_covar_xy),
		.Out2(), // default
		.popsign1(sign_covar_xy),
		.popsign2(), // default
	);

	upe_triplemul16uuu mul_term_x
	(
		.A(var_x),
		.B(abs_dfdx),
		.C(abs_dfdx),
		.O(term_x),
	);

	upe_triplemul16uuu mul_term_xy
	(
		.A(abs_covar_xy),
		.B(abs_dfdy),
		.C(abs_dfdx),
		.O(abs_term_xy),
	);

	upe_triplemul16uuu mul_term_y
	(
		.A(var_y),
		.B(abs_dfdy),
		.C(abs_dfdy),
		.Out(term_y),
	);

	upe_resign64u resign
	(
		.In({abs_term_xy[62:0],1'b0}), // Multiply by 2
		.sign(sign_covar_xy ^ sign_dfdx ^ sign_dfdy),
		.Out(term_xy),
	);

	upe_tripleadd64 add
	(
		.A(term_x),
		.B(term_xy),
		.C(term_y),
		.Out(var_z),
		.carryin1(1'b0),
		.carryin2(1'b0),
		.carryout1(),
		.carryout2(),
	);


endmodule

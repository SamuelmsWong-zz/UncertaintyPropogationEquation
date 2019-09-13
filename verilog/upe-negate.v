`ifndef GOT_UPE_ADDV
	`include "upe-add.v"
`endif


`define GOT_UPE_NEGATEV

module upe_negate16u(In1, In2, Out1, Out2); // Out1 = -In1, Out2 = -In2
	input [15:0]	In1;
	input [15:0]	In2;
	output [15:0]	Out1;
	output [15:0]	Out2;

	wire [15:0]	flipped1;
	wire [15:0]	flipped2;

	upe_add16uu adder
	(
		.A(flipped1),
		.B(flipped2),
		.C(16'h0001),
		.D(16'h0001),
		.Out1(Out1),
		.Out2(Out2),
	);

	assign flipped1 = ~In1;
	assign flipped2 = ~In2;

endmodule

module upe_negate32u(In, Out); // Out = -In
	input [31:0]	In;
	output [31:0]	Out;

	wire [31:0]	flipped;

	upe_add32 adder
	(
		.AB(flipped),
		.CD(32'h00000001),
		.Out(Out),
		.carryin(), // default
		.carryout(), // default
	);

	assign flipped = ~In;

endmodule


module upe_negate64u(In, Out); // Out = -In
	input [63:0]	In;
	output [63:0]	Out;

	wire [63:0]	flipped;

	upe_add64uu adderlo
	(
		.A(flipped),
		.B(64'h0000000000000001),
		.Out(Out),
		.carryin(1'b0),
		.carryout(),
	);

	assign flipped = ~In;

endmodule

`ifndef GOT_UPE_NEGATEV
	`include "upe-negate.v"
`endif


`define GOT_UPE_RESIGNV

module upe_resign32u(In, Out, sign); // Out = sign-In
	input [31:0]	In;
	input		sign;
	output [31:0]	Out;

	wire [31:0]	negative;
	wire [31:0]	signext;

	upe_negate32 negate
	(
		.In(In),
		.Out(negative),
	);

	assign signext = {32{sign}};

	assign Out = (signext&negative)|((~signext)&In);

endmodule

module upe_resign16u(In1, In2, Out1, Out2, sign1, sign2); // Out1 = |In1|, Out2 = |In2|
	input [15:0]	In1;
	input [15:0]	In2;
	input		sign1;
	input		sign2;
	output [15:0]	Out1;
	output [15:0]	Out2;

	wire [15:0]	negative1;
	wire [15:0]	negative2;
	wire [15:0]	signext1;
	wire [15:0]	signext2;

	upe_negate16 negate
	(
		.In1(In1),
		.In2(In2),
		.Out1(negative1),
		.Out2(negative2),
	);

	assign signext1 = {16{sign1}};
	assign signext2 = {16{sign2}};

	assign Out1 = (signext1 & negative1) | ( (~signext1) & In1);
	assign Out2 = (signext2 & negative2) | ( (~signext2) & In2);

endmodule
`ifndef GOT_UPE_NEGATEV
	`include "upe-negate.v"
`endif


`define GOT_UPE_ABSV

module upe_abs32s(In, Out, popsign); // Out = |In|
	input [31:0]	In;
	output [31:0]	Out;
	output		popsign;

	wire [31:0]	flipped;
	wire [31:0]	sign;

	upe_negate32u negate
	(
		.In(In),
		.Out(flipped),
	);

	assign sign = {32{In[31]}};

	assign Out = (sign&flipped)|((~sign)&In);
	assign popsign = In[31];
endmodule

module upe_abs16s(In1, In2, Out1, Out2, popsign1, popsign2); // Out1 = |In1|, Out2 = |In2|
	input [15:0]	In1;
	input [15:0]	In2;
	output [15:0]	Out1;
	output [15:0]	Out2;
	output		popsign1;
	output		popsign2;

	wire [15:0]	flipped1;
	wire [15:0]	flipped2;
	wire [15:0]	sign1;
	wire [15:0]	sign2;

	upe_negate16u negate
	(
		.In1(In1),
		.In2(In2),
		.Out1(flipped1),
		.Out2(flipped2),
	);

	assign sign1 = {16{In1[15]}};

	assign sign2 = {16{In2[15]}};

	assign Out1 = (sign1 & flipped1) | ( (~sign1) & In1);
	assign Out2 = (sign2 & flipped2) | ( (~sign2) & In2);

	assign popsign1 = In1[15];
	assign popsign2 = In2[15];
endmodule
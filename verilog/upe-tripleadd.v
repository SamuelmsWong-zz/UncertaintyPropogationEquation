`ifndef GOT_UPE_ADDV
	`include "upe-add.v"
`endif

`define GOT_UPE_TRIPLEADDV

module upe_tripleadd32 (A, B, C, Out, carryin1, carryin2, carryout1, carryout2);
	input [31:0]	A;
	input [31:0]	B;
	input [31:0]	C;
	input		carryin1;
	input		carryin2;

	output [31:0]	Out;
	output		carryout1;
	output		carryout2;

	wire [31:0]	AplusB;

	upe_add32ss add1
	(
		.AB(A),
		.CD(B),
		.Out(AplusB),
		.carryin(carryin1),
		.carryout(carryout1),
	);

	upe_add32ss add2
	(
		.AB(AplusB),
		.CD(C),
		.Out(Out),
		.carryin(carryin2),
		.carryout(carryout2),
	);

endmodule

module upe_tripleadd64 (A, B, C, Out, carryin1, carryin2, carryout1, carryout2);
	input [63:0]	A;
	input [63:0]	B;
	input [63:0]	C;
	input		carryin1;
	input		carryin2;

	output [63:0]	Out;
	output		carryout1;
	output		carryout2;

	wire		midcarry1;
	wire		midcarry2;

	upe_tripleadd32 addlo
	(
		.A(A[31:0]),
		.B(B[31:0]),
		.C(C[31:0]),
		.Out(Out[31:0]),
		.carryin1(carryin1),
		.carryin2(carryin2),
		.carryout1(midcarry1),
		.carryout2(midcarry2),
	);

	upe_tripleadd32 addhi
	(
		.A(A[63:32]),
		.B(B[63:32]),
		.C(C[63:32]),
		.Out(Out[63:32]),
		.carryin1(midcarry1),
		.carryin2(midcarry2),
		.carryout1(carryout1),
		.carryout2(carryout2),
	);

endmodule
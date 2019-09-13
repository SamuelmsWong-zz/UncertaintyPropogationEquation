`ifndef GOT_UPE_MULV
	`include "upe-mul.v"
`endif
`ifndef GOT_UPE_ADDV
	`include "upe-add.v"
`endif


`define GOT_UPE_TRIPLEMULV

// module upe_triplemul16uuu(A, B, C, Out, probe); // Out = A * B * C
// 	input [15:0]	A;
// 	input [15:0]	B;
// 	input [15:0]	C;

// 	output [63:0]	Out;
// 	output [63:0]	probe;

// 	assign Out = A*B*C;
// 	assign probe = 0;
// endmodule

module upe_triplemul16uuu(A, B, C, Out, probe); // Out = A * B * C
	input [15:0]	A;
	input [15:0]	B;
	input [15:0]	C;

	output [63:0]	Out;
	output [63:0]	probe;

	wire [31:0]	AtimesB;
	wire [63:0]	Out1;
	wire [63:0]	Out2;

	upe_mul16uu mul1
	(
		.A(A),
		.B(B),
		.Out(AtimesB),
		);

	upe_mul16uu mul2
	(
		.A(AtimesB[15:0]),
		.B(C),
		.Out(Out1[31:0]),
		);

	upe_mul16uu mul3
	(
		.A(AtimesB[31:16]),
		.B(C),
		.Out(Out2[47:16]),
		);

	upe_add64uu add
	(
		.A(Out1),
		.B(Out2),
		.Out(Out),
		.carryin(1'b0), // default
		.carryout(), // default
		);

	assign Out1[63:32] = {32'h00000000};
	assign Out2[63:48] = {16'h0000};
	assign Out2[15: 0] = {16'h0000};
	assign probe = {32'h00000000, AtimesB};

endmodule
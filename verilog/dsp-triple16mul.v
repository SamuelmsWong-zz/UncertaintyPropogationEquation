`include "dsp-add.v"
`include "dsp-16mul.v"
`include "abs.v"
module dsp_triple16mul(A, B, C, Out); // Out = A * B * C
	input [15:0]	A;
	input [15:0]	B;
	input [15:0]	C;
	output [47:0]	Out;

	wire [15:0]	absA;
	wire [15:0]	absB;
	wire [15:0]	absC;
	wire [47:0]	absOut;

	wire		signA;
	wire		signB;
	wire		signC;
	wire		signOut;

	wire [31:0]	AtimesB;
	wire [31:0]	Outlower;
	wire [31:0]	Outupper;

	abs16bit abs1
	(
		.In1(A),
		.In2(B),
		.Out1(absA),
		.Out2(absB),
		.popsign1(signA),
		.popsign2(signB),
	);

	abs16bit abs2
	(
		.In1(C),
		.In2(16'h0000), // default
		.Out1(absC),
		.Out2(), // default
		.popsign1(signC),
		.popsign2(), // default
	);

	dsp_16mul mul1
	(
		.A(absA),
		.B(absB),
		.Out(AtimesB),
		);

	dsp_16mul mul2
	(
		.A(AtimesB[15:0]),
		.B(absC),
		.Out(Outlower),
		);

	dsp_16mul mul3
	(
		.A(AtimesB[31:16]),
		.B(absC),
		.Out(Outupper),
		);

	dsp_32add add
	(
		.AB(Outupper),
		.CD({16'h0000,OutLower[15:0]}),
		.Out(absOut[47:16]),
		.carryin(1'b0), // default
		.carryout(), // default
		);

	assign Outlower[15:0] = absOut[15:0];
	assign signOut = signA ^ signB ^ signC;
	/*TODO*/
endmodule
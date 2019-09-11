`include "dsp-add.v"

module negate16bit(In1, In2, Out1, Out2); // Out1 = -In1, Out2 = -In2
	input [15:0]	In1;
	input [15:0]	In2;
	output [15:0]	Out1;
	output [15:0]	Out2;

	wire [15:0]	flipped1;
	wire [15:0]	flipped2;

	dsp_16adduu adder
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

module negate32bit(In, Out); // Out = -In
	input [31:0]	In;
	output [31:0]	Out;

	wire [31:0]	flipped;

	dsp_32add adder
	(
		.AB(flipped),
		.CD(32'h00000001),
		.Out(Out),
		.carryin(), // default
		.carryout(), // default
	);

	assign flipped = ~In;
endmodule


module negate48bit(In, Out); // Out = -In
	input [47:0]	In;
	output [47:0]	Out;

	wire [47:0]	flipped;
	wire		carry;

	dsp_32add adder32
	(
		.AB(flipped[31:0]),
		.CD(32'h00000001),
		.Out(Out),
		.carryin(1'b0), // default
		.carryout(carry), // default
	);

	dsp_16adduu adder16
	(
		.A(flipped1),
		.B(16'h0000), // default
		.C(16'h0001),
		.D(16'h0000), // default
		.Out1(Out1),
		.Out2(),  // default
	);

	assign flipped = ~In;
	/*TODO*/
endmodule

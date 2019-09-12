`define GOT_UPE_ADDV

module upe_add16uu(A, B, C, D, Out1, Out2); // Out1 = A + C, Out2 = B + D
	input [15:0]	A;
	input [15:0]	B;
	input [15:0]	C;
	input [15:0]	D;

	output [15:0]	Out1;
	output [15:0]	Out2;


	/*
	 *	Refer to SB_MAC16 upe Functional Model
	 */
	SB_MAC16 i_sbmac16
	(
	.A(A[15:0]),
	.B(B[15:0]),
	.C(C[15:0]),
	.D(D[15:0]),
	.O({Out1,Out2}),
	.CLK(), // default
	.CE(1'b1), // default
	.IRSTTOP(1'b0), // default
	.IRSTBOT(1'b0), // default
	.ORSTTOP(1'b0), // default
	.ORSTBOT(1'b0), // default
	.AHOLD(1'b0), // default
	.BHOLD(1'b0), // default
	.CHOLD(1'b0), // default
	.DHOLD(1'b0), // default
	.OHOLDTOP(1'b0), // default
	.OHOLDBOT(1'b0), // default
	.OLOADTOP(1'b0),
	.OLOADBOT(1'b0),
	.ADDSUBTOP(1'b0),
	.ADDSUBBOT(1'b0),
	.CI(1'b0),
	.CO(),
	.ACCUMCI(1'b0), // default
	.ACCUMCO(), // default
	.SIGNEXTIN(1'b0), // default
	.SIGNEXTOUT(), // default
	);

	/*
	 *	Refer to SB_MAC16 upe Functional Model
	 */
	defparam i_sbmac16.NEG_TRIGGER = 1'b0; // Set clock polarity to rising edge

	defparam i_sbmac16.C_REG = 1'b0; // C0: C is non-register
	defparam i_sbmac16.A_REG = 1'b0; // C1: A is non-register
	defparam i_sbmac16.B_REG = 1'b0; // C2: B is non-register
	defparam i_sbmac16.D_REG = 1'b0; // C3: D is non-register

	defparam i_sbmac16.TOP_8x8_MULT_REG = 1'b0; // C4: default
	defparam i_sbmac16.BOT_8x8_MULT_REG = 1'b0; // C5: default
	defparam i_sbmac16.PIPELINE_16x16_MULT_REG1 = 1'b0; // C6: default
	defparam i_sbmac16.PIPELINE_16x16_MULT_REG2 = 1'b0; // C7: default

	defparam i_sbmac16.TOPOUTPUT_SELECT = 2'b00; // C9-8: Top output is from non-register addition
	defparam i_sbmac16.TOPADDSUB_LOWERINPUT = 2'b00; // C11-10: Feed input A into top adder
	defparam i_sbmac16.TOPADDSUB_UPPERINPUT = 1'b1; // C12: Feed input C into top adder
	defparam i_sbmac16.TOPADDSUB_CARRYSELECT = 2'b00; // C14-13: Carry zero from bot adder

	defparam i_sbmac16.BOTOUTPUT_SELECT = 2'b00; // C16-15: Bot output is from non-register addition
	defparam i_sbmac16.BOTADDSUB_UPPERINPUT = 1'b1; // C17: Feed input D into bot adder
	defparam i_sbmac16.BOTADDSUB_LOWERINPUT = 2'b00; // C19-18: Feed input B into bot adder
	defparam i_sbmac16.BOTADDSUB_CARRYSELECT = 2'b00; // C21-20: Carry zero from lower dsp

	defparam i_sbmac16.MODE_8x8 = 1'b0; // C22: Not 8x8 power save mode
	defparam i_sbmac16.A_SIGNED = 1'b0; // C23: A is unsigned
	defparam i_sbmac16.B_SIGNED = 1'b0; // C24: B is unsigned

endmodule

module upe_add32uu(AB, CD, Out, carryin, carryout); // Out = AB + CD
	input [31:0]	AB;
	input [31:0]	CD;
	input		carryin;

	output [31:0]	Out;
	output		carryout;

	/*
	 *	Refer to SB_MAC16 upe Functional Model
	 */
	SB_MAC16 i_sbmac16
	(
	.A(AB[31:16]),
	.B(AB[15:0]),
	.C(CD[31:16]),
	.D(CD[15:0]),
	.O(Out),
	.CLK(), // default
	.CE(1'b1), // default
	.IRSTTOP(1'b0), // default
	.IRSTBOT(1'b0), // default
	.ORSTTOP(1'b0), // default
	.ORSTBOT(1'b0), // default
	.AHOLD(1'b0), // default
	.BHOLD(1'b0), // default
	.CHOLD(1'b0), // default
	.DHOLD(1'b0), // default
	.OHOLDTOP(1'b0), // default
	.OHOLDBOT(1'b0), // default
	.OLOADTOP(1'b0),
	.OLOADBOT(1'b0),
	.ADDSUBTOP(1'b0),
	.ADDSUBBOT(1'b0),
	.CI(carryin),
	.CO(carryout),
	.ACCUMCI(1'b0), // default
	.ACCUMCO(), // default
	.SIGNEXTIN(1'b0), // default
	.SIGNEXTOUT(), // default
	);

	/*
	 *	Refer to SB_MAC16 upe Functional Model
	 */
	defparam i_sbmac16.NEG_TRIGGER = 1'b0; // Set clock polarity to rising edge

	defparam i_sbmac16.C_REG = 1'b0; // C0: C is non-register
	defparam i_sbmac16.A_REG = 1'b0; // C1: A is non-register
	defparam i_sbmac16.B_REG = 1'b0; // C2: B is non-register
	defparam i_sbmac16.D_REG = 1'b0; // C3: D is non-register

	defparam i_sbmac16.TOP_8x8_MULT_REG = 1'b0; // C4: default
	defparam i_sbmac16.BOT_8x8_MULT_REG = 1'b0; // C5: default
	defparam i_sbmac16.PIPELINE_16x16_MULT_REG1 = 1'b0; // C6: default
	defparam i_sbmac16.PIPELINE_16x16_MULT_REG2 = 1'b0; // C7: default

	defparam i_sbmac16.TOPOUTPUT_SELECT = 2'b00; // C9-8: Top output is from non-register addition
	defparam i_sbmac16.TOPADDSUB_LOWERINPUT = 2'b00; // C11-10: Feed input A into top adder
	defparam i_sbmac16.TOPADDSUB_UPPERINPUT = 1'b1; // C12: Feed input C into top adder
	defparam i_sbmac16.TOPADDSUB_CARRYSELECT = 2'b11; // C14-13: Carry bit from bot adder

	defparam i_sbmac16.BOTOUTPUT_SELECT = 2'b00; // C16-15: Bot output is from non-register addition
	defparam i_sbmac16.BOTADDSUB_UPPERINPUT = 1'b1; // C17: Feed input D into bot adder
	defparam i_sbmac16.BOTADDSUB_LOWERINPUT = 2'b00; // C19-18: Feed input B into bot adder
	defparam i_sbmac16.BOTADDSUB_CARRYSELECT = 2'b11; // C21-20: Carry bit from lower dsp

	defparam i_sbmac16.MODE_8x8 = 1'b0; // C22: Not 8x8 power save mode
	defparam i_sbmac16.A_SIGNED = 1'b0; // C23: A is unsigned
	defparam i_sbmac16.B_SIGNED = 1'b0; // C24: B is unsigned

endmodule

module upe_add32ss(AB, CD, Out, carryin, carryout); // Out = AB + CD
	input [31:0]	AB;
	input [31:0]	CD;
	input		carryin;

	output [31:0]	Out;
	output		carryout;

	/*
	 *	Refer to SB_MAC16 upe Functional Model
	 */
	SB_MAC16 i_sbmac16
	(
	.A(AB[31:16]),
	.B(AB[15:0]),
	.C(CD[31:16]),
	.D(CD[15:0]),
	.O(Out),
	.CLK(), // default
	.CE(1'b1), // default
	.IRSTTOP(1'b0), // default
	.IRSTBOT(1'b0), // default
	.ORSTTOP(1'b0), // default
	.ORSTBOT(1'b0), // default
	.AHOLD(1'b0), // default
	.BHOLD(1'b0), // default
	.CHOLD(1'b0), // default
	.DHOLD(1'b0), // default
	.OHOLDTOP(1'b0), // default
	.OHOLDBOT(1'b0), // default
	.OLOADTOP(1'b0),
	.OLOADBOT(1'b0),
	.ADDSUBTOP(1'b0),
	.ADDSUBBOT(1'b0),
	.CI(carryin),
	.CO(carryout),
	.ACCUMCI(1'b0), // default
	.ACCUMCO(), // default
	.SIGNEXTIN(1'b0), // default
	.SIGNEXTOUT(), // default
	);

	/*
	 *	Refer to SB_MAC16 upe Functional Model
	 */
	defparam i_sbmac16.NEG_TRIGGER = 1'b0; // Set clock polarity to rising edge

	defparam i_sbmac16.C_REG = 1'b0; // C0: C is non-register
	defparam i_sbmac16.A_REG = 1'b0; // C1: A is non-register
	defparam i_sbmac16.B_REG = 1'b0; // C2: B is non-register
	defparam i_sbmac16.D_REG = 1'b0; // C3: D is non-register

	defparam i_sbmac16.TOP_8x8_MULT_REG = 1'b0; // C4: default
	defparam i_sbmac16.BOT_8x8_MULT_REG = 1'b0; // C5: default
	defparam i_sbmac16.PIPELINE_16x16_MULT_REG1 = 1'b0; // C6: default
	defparam i_sbmac16.PIPELINE_16x16_MULT_REG2 = 1'b0; // C7: default

	defparam i_sbmac16.TOPOUTPUT_SELECT = 2'b00; // C9-8: Top output is from non-register addition
	defparam i_sbmac16.TOPADDSUB_LOWERINPUT = 2'b00; // C11-10: Feed input A into top adder
	defparam i_sbmac16.TOPADDSUB_UPPERINPUT = 1'b1; // C12: Feed input C into top adder
	defparam i_sbmac16.TOPADDSUB_CARRYSELECT = 2'b11; // C14-13: Carry bit from bot adder

	defparam i_sbmac16.BOTOUTPUT_SELECT = 2'b00; // C16-15: Bot output is from non-register addition
	defparam i_sbmac16.BOTADDSUB_UPPERINPUT = 1'b1; // C17: Feed input D into bot adder
	defparam i_sbmac16.BOTADDSUB_LOWERINPUT = 2'b00; // C19-18: Feed input B into bot adder
	defparam i_sbmac16.BOTADDSUB_CARRYSELECT = 2'b11; // C21-20: Carry bit from lower dsp

	defparam i_sbmac16.MODE_8x8 = 1'b0; // C22: Not 8x8 power save mode
	defparam i_sbmac16.A_SIGNED = 1'b1; // C23: A is signed
	defparam i_sbmac16.B_SIGNED = 1'b1; // C24: B is signed

endmodule

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

module upe_add64uu(A, B, Out, carryin, carryout); // Out = A + B
	input [63:0]	A;
	input [63:0]	B;
	input 		carryin;

	output [63:0]	Out;
	output		carryout;

	wire		midcarry;

	upe_add32uu addupper32
	(
		.AB(A[63:32]),
		.CD(B[63:32]),
		.Out(Out[63:32]),
		.carryin(midcarry),
		.carryout(carryout),
	);

	upe_add32uu addlower32
	(
		.AB(A[31:0]),
		.CD(B[31:0]),
		.Out(Out[31:0]),
		.carryin(carryin),
		.carryout(midcarry),
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
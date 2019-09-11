`include "signextend.v"

module dsp_16addu(B, D, Out, carryin, carryout); // Out = B + D
	input [15:0]	B;
	input [15:0]	D;
	input		carryin;

	output [15:0]	Out;
	output		carryout;

	wire [31:0]	Out32;


	/*
	 *	Refer to SB_MAC16 DSP Functional Model
	 */
	SB_MAC16 i_sbmac16
	(
	.A(16'h0000),
	.B(B[15:0]),
	.C(16'h0000),
	.D(D[15:0]),
	.O(Out32),
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
	.OLOADTOP(1'b0), // default
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
	 *	Refer to SB_MAC16 DSP Functional Model
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
	defparam i_sbmac16.TOPADDSUB_CARRYSELECT = 2'b10; // C14-13: Carry bit from bot adder

	defparam i_sbmac16.BOTOUTPUT_SELECT = 2'b00; // C16-15: Bot output is from non-register addition
	defparam i_sbmac16.BOTADDSUB_UPPERINPUT = 1'b1; // C17: Feed input D into bot adder
	defparam i_sbmac16.BOTADDSUB_LOWERINPUT = 2'b00; // C19-18: Feed input B into bot adder
	defparam i_sbmac16.BOTADDSUB_CARRYSELECT = 2'b10; // C21-20: Carry bit from lower DSP

	defparam i_sbmac16.MODE_8x8 = 1'b0; // C22: Not 8x8 power save mode
	defparam i_sbmac16.A_SIGNED = 1'b0; // C23: A is unsigned
	defparam i_sbmac16.B_SIGNED = 1'b0; // C24: B is unsigned

	assign Out = Out32[15:0];

endmodule

module dsp_16adduu(A, B, C, D, Out1, Out2); // Out1 = A + C, Out2 = B + D
	input [15:0]	A;
	input [15:0]	B;
	input [15:0]	C;
	input [15:0]	D;

	output [15:0]	Out1;
	output [15:0]	Out2;


	/*
	 *	Refer to SB_MAC16 DSP Functional Model
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
	 *	Refer to SB_MAC16 DSP Functional Model
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
	defparam i_sbmac16.BOTADDSUB_CARRYSELECT = 2'b00; // C21-20: Carry zero from lower DSP

	defparam i_sbmac16.MODE_8x8 = 1'b0; // C22: Not 8x8 power save mode
	defparam i_sbmac16.A_SIGNED = 1'b0; // C23: A is unsigned
	defparam i_sbmac16.B_SIGNED = 1'b0; // C24: B is unsigned

endmodule

module dsp_32adduu(AB, CD, Out, carryin, carryout); // Out = AB + CD
	input [31:0]	AB;
	input [31:0]	CD;
	input		carryin;

	output [31:0]	Out;
	output		carryout;

	/*
	 *	Refer to SB_MAC16 DSP Functional Model
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
	 *	Refer to SB_MAC16 DSP Functional Model
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
	defparam i_sbmac16.BOTADDSUB_CARRYSELECT = 2'b11; // C21-20: Carry bit from lower DSP

	defparam i_sbmac16.MODE_8x8 = 1'b0; // C22: Not 8x8 power save mode
	defparam i_sbmac16.A_SIGNED = 1'b0; // C23: A is unsigned
	defparam i_sbmac16.B_SIGNED = 1'b0; // C24: B is unsigned

endmodule

module dsp_32addss(AB, CD, Out, carryin, carryout); // Out = AB + CD
	input [31:0]	AB;
	input [31:0]	CD;
	input		carryin;

	output [31:0]	Out;
	output		carryout;

	/*
	 *	Refer to SB_MAC16 DSP Functional Model
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
	 *	Refer to SB_MAC16 DSP Functional Model
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
	defparam i_sbmac16.BOTADDSUB_CARRYSELECT = 2'b11; // C21-20: Carry bit from lower DSP

	defparam i_sbmac16.MODE_8x8 = 1'b0; // C22: Not 8x8 power save mode
	defparam i_sbmac16.A_SIGNED = 1'b1; // C23: A is signed
	defparam i_sbmac16.B_SIGNED = 1'b1; // C24: B is signed

endmodule

module dsp_48addss(A, B, Out, carryin, carryout); // Out = A + B
	input [47:0]	A;
	input [47:0]	B;
	input 		carryin;

	output [47:0]	Out;
	output		carryout;

	wire		upperA;
	wire		upperB;
	wire		midcarry;
	wire [31:0]	Outupper;


	ext16to32bit extA
	(
		.In(A[47:32]),
		.Out(upperA),
	);

	ext16to32bit extB
	(
		.In(B[47:32]),
		.Out(upperB),
	);

	dsp_32add addupper32
	(
		.AB(upperA),
		.CD(upperB),
		.Out(Outupper),
		.carryin(midcarry),
		.carryout(), // default
	);

	dsp_32add addlower32
	(
		.AB(A[31:0]),
		.CD(B[31:0]),
		.Out(Out[31:0]),
		.carryin(carryin),
		.carryout(midcarry),
	);

	assign Out[47:32] = Outupper[15:0];
	assign carryout = Outupper[16];
endmodule
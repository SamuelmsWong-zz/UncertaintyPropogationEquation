module dsp_32add(AB, CD, O, carryin, carryout);
	input [31:0]	AB;
	input [31:0]	CD;
	input		carryin;

	output [31:0]	O;
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
	.O(O),
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
	// defparam i_sbmac16.PIPELINE_16X16_MULT_REG1 = 1'b0; // C6: default
	// defparam i_sbmac16.PIPELINE_16X16_MULT_REG2 = 1'b0; // C7: default

	defparam i_sbmac16.TOPOUTPUT_SELECT = 2'b00; // C9-8: Top output is from non-register addition
	defparam i_sbmac16.TOPADDSUB_LOWERINPUT = 2'b00; // C11-10: Feed input A into top adder
	defparam i_sbmac16.TOPADDSUB_UPPERINPUT = 1'b1; // C12: Feed input C into top adder
	defparam i_sbmac16.TOPADDSUB_CARRYSELECT = 2'b11; // C14-13: Carry bit from bot adder

	defparam i_sbmac16.BOTOUTPUT_SELECT = 2'b00; // C16-15: Bot output is from non-register addition
	defparam i_sbmac16.BOTADDSUB_UPPERINPUT = 1'b1; // C17: Feed input D into bot adder
	defparam i_sbmac16.BOTADDSUB_LOWERINPUT = 2'b00; // C19-18: Feed input B into bot adder
	defparam i_sbmac16.BOTADDSUB_CARRYSELECT = 2'b11; // C21-20: Carry bit from lower DSP

	defparam i_sbmac16.MODE_8x8 = 1'b0; // C22: Not 8x8 power save mode
	defparam i_sbmac16.A_SIGNED = 1'b0; // C23: A is signed
	defparam i_sbmac16.B_SIGNED = 1'b0; // C24: B is signed

endmodule

// module dsp_32tripleadd(x1,x2,x3,carryout);
// 	input 	x1;
// 	input	x2;
// 	input	x3;
// 	output	carryout;

// 	dsp_32add doubleadd1(
// 		)
// endmodule
`define GOT_UPE_SIGNEXTV

module ext16to32bit(In,Out);
	input [15:0]	In;
	output [31:0]	Out;

	assign Out[15:0] = In[15:0];
	assign Out[31:16] = {16{In[15]}};
endmodule
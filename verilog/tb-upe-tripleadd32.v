`include "upe-tripleadd.v"
module tb_upe_tripleadd32(led0, led1, led2);
	output led0;
	output led1;
	output led2;


	wire		clk;
	reg [31:0]	count;
	reg [4:0]	bitnum;
	reg		LED0status;
	reg		LED1status;
	reg		LED2status;

	reg [31:0]	x1;
	reg [31:0]	x2;
	reg [31:0]	x3;

	reg [31:0]	y;
	reg c1;
	reg c2;

	SB_LFOSC OSCInst1 (
		.CLKLFPU(1'b1),
		.CLKLFEN(1'b1),
		.CLKLF(clk)
	);

	upe_tripleadd32 add
	(
		.A(x1),
		.B(x2),
		.C(x3),
		.Out(y),
		.carryin1(1'b1), // default
		.carryin2(1'b0), // default
		.carryout1(c1), // default
		.carryout2(c2), // default
	);

	initial begin
		x1 = 32'h34D51531;
		x2 = 32'hEEEEEEEE;
		x3 = 32'h11111111;
		// y = 32'h34D51531; // You might recognise this rythym...
	end

	always @(posedge clk) begin
		if (count > 100) begin
			count <= 0;
			bitnum <= bitnum + 1;
			LED0status <= y[bitnum];
			LED1status <= c1;
			LED2status <= c2;
			// LED2status <= !LED2status;
		end
		else begin
			count <= count +1;
		end
	end

	assign led0 = LED0status;
	assign led1 = LED1status;
	assign led2 = LED2status;
	// assign led1 = 1'b1;
	// assign led2 = 1'b0;

endmodule

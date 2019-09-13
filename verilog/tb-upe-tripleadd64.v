`include "upe-tripleadd.v"
module tb_upe_tripleadd64(led0, led1, led2);
	output led0;
	output led1;
	output led2;

	wire		clk;
	reg [31:0]	count;
	reg [10:0]	bitnum;
	reg [31:0]	interval;
	reg		LED0status;
	reg		LED1status;
	reg		LED2status;
	reg		on;

	reg [63:0]	x1;
	reg [63:0]	x2;
	reg [63:0]	x3;

	reg [63:0]	y;
	reg [63:0]	test;

	SB_LFOSC OSCInst1 (
		.CLKLFPU(1'b1),
		.CLKLFEN(1'b1),
		.CLKLF(clk)
	);

	upe_tripleadd64 add
	(
		.A(x1),
		.B(x2),
		.C(x3),
		.Out(y),
		.carryin1(1'b0), // default
		.carryin2(1'b0), // default
		.carryout1(), // default
		.carryout2(), // default
		.probe1(LED1status),
		.probe2(LED2status),
	);

	initial begin
		on = 1'b1;
		interval = 1250;
		x1 = 64'h5CD5153134D51531;
		x2 = 64'hEEEEEEEEEEEEEEEE;
		x3 = 64'h1111111111111112;
		// y = 64'h5CD5153134D51531; // You might recognise this rythym...
		test = 64'h5CD5153134D51531;
	end


	always @(posedge clk) begin
		// if (count > interval) begin
		// 	LED2status <= !LED2status;
		// end
		if (on == 1'b1) begin
			if (count > (interval)) begin
				count <= 0;
				bitnum <= bitnum + 1;
				if (bitnum > 63) begin
					on <= 1'b0;
				end
				LED0status <= y[bitnum];
				// LED0status <= test[bitnum];
			end
			else begin
				count <= count +1;
			end
		end
		else begin
			LED0status <= 0;
		end
	end

	assign	led0 = LED0status;
	assign	led1 = LED1status;
	assign	led2 = LED2status;

endmodule

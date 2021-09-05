module test_alu_base(
	output reg clock,
	output reg enable,
	output reg [2:0] funct3,
	output reg [31:0] register_data_1,
	output reg [31:0] register_data_2,
	input      [31:0] register_data_out);

parameter
	CLOCK_PERIOD = 1;

	always
	begin
		#CLOCK_PERIOD clock = !clock;
	end

	initial
	begin
		clock = 0;
		enable = 1;
		funct3 = 0;
		register_data_1 = 0;
		register_data_2 = 0;
		# 2
		register_data_1 = 1;
		register_data_2 = 2;
		#10 $finish;
	end
endmodule

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
		$dumpfile("test_alu_base_riscv32i.vcd");
		$dumpvars(clock);
		// initialize registers
		clock = 0;
		enable = 1;
		// set ALU to SUM
		funct3 = 0;
		// set SUM inputs 0, 0 result=> 0
		register_data_1 = 0;
		register_data_2 = 0;
		# 5
		// change SUM inputs result=> 3
		register_data_1 = 1;
		register_data_2 = 2;
		#100 $finish;
	end
	initial begin
		forever
		@(posedge clock) begin
			$display("clock = %b, funct3 = %b, register_data_1 = %b, register_data_2 = %b", clock, funct3, register_data_1, register_data_2);
		end
	end
endmodule

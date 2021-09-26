module test_bench_alu;
	wire clock;
	wire enable;
	wire [2:0] funct3;
	wire [6:0] funct7;
	wire [31:0] register_data_1;
	wire [31:0] register_data_2;
	wire [31:0] register_data_out;

	alu alu_rv32i(clock, enable, funct3, funct7, register_data_1, register_data_2, register_data_out);

	test_alu test_alu_rv32i(clock, enable, funct3, funct7, register_data_1, register_data_2, register_data_out);
	
endmodule

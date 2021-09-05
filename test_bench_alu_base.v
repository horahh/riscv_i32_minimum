module test_bench_alu_base;
	wire clock;
	wire enable;
	wire [2:0] funct3;
	wire [31:0] register_data_1;
	wire [31:0] register_data_2;
	wire [31:0] register_data_out;

	alu_base alu_base_rv32i(clock, enable, funct3, register_data_1, register_data_2, register_data_out);

	test_alu_base test_alu_base_rv32i(clock, enable, funct3, register_data_1, register_data_2, register_data_out);

endmodule

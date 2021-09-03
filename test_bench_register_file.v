module test_bench_register_file;
	wire clock;
	wire reset;
	wire write_enable;
	wire [4:0] rs1;
	wire [4:0] rs2;
	wire [4:0] register_write_select;
	wire [31:0] register_data_write;
	wire [31:0] register_data_1;
	wire [31:0] register_data_2;

	register_file        register_file_rv32i(clock, reset, write_enable, rs1, rs2, register_write_select, register_data_write, register_data_1, register_data_2);
	test_register_file   test_register_file_rv32i(clock, reset, write_enable, rs1, rs2, register_write_select, register_data_write, register_data_1, register_data_2);
endmodule

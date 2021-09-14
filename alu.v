// reference:
// https://github.com/riscv/riscv-opcodes/blob/master/opcodes-rv32i

module alu(
	input          clock,
	input          enable,
	input  [2:0]   funct3, // select operation
	input  [6:0]   funct7, // select operation type
	input  [31:0]  register_data_1,
	input  [31:0]  register_data_2,
	output [31:0]  register_data_out);

	alu_base alu_base_rv32i(clock, alu_base_enable, funct3, register_data_1, register_data_2, register_data_out);
	alu_extra alu_extra_rv32i(clock, alu_extra_enable, funct3, register_data_1, register_data_2, register_data_out);
	alu_select alu_select_rv32i(clock, enable, funct7, alu_base_enable, alu_extra_enable);

endmodule

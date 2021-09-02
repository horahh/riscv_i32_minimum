// reference:
// https://github.com/riscv/riscv-opcodes/blob/master/opcodes-rv32i

`define HIGH_IMPEDANCE 32'hZZZZZZZZ

module alu_base(
	input         clock,
	input         enable,
	input  [2:0]  funct3,
	input  [31:0] register_data_1,
	input  [31:0] register_data_2,
	output [31:0] register_data_out);
parameter
	ADD  = 0,
	SUB  = 0, // bit select 31..25 = 32 -> means subtract
	SLL  = 1,
	SLT  = 2,
	SLTU = 3,
	XOR  = 4,
	SRL  = 5,
	SRA  = 5, // bit select 31..25 = 32 -> means SRA 
	OR   = 6,
	AND  = 7;

	reg register_data_out;

	always @(posedge clock & enable) begin
		case(funct3)
			ADD: register_data_out <= register_data_1 + register_data_2;
			SLL: register_data_out <= register_data_1 << register_data_2;
			SLTU:  register_data_out <= register_data_1 < register_data_2 ? 1 : 0;
			XOR: register_data_out <= register_data_1 ^ register_data_2;
			SRL: register_data_out <= register_data_1 >> register_data_2;
			SRA: register_data_out <= register_data_1 >>> register_data_2;
			OR:  register_data_out <= register_data_1 | register_data_2;
			AND: register_data_out <= register_data_1 & register_data_2;
			default: register_data_out <= 0;
		endcase
	end
	always @(posedge clock & !enable) begin
		register_data_out <= `HIGH_IMPEDANCE;
	end
endmodule


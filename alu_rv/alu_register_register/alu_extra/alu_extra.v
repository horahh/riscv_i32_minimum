// reference:
// https://github.com/riscv/riscv-opcodes/blob/master/opcodes-rv32i
`define HIGH_IMPEDANCE 32'hz
`define ZERO           32'h0

module alu_extra(
	input         clock,
	input         alu_extra_enable,
	input  [2:0]  funct3,
	input  [31:0] rs1_value,
	input  [31:0] rs2_value,
	output [31:0] rd_value);

   parameter [2:0] SUB  = 3'h0; // bit select 31..25 = 32 -> means subtract
	parameter [2:0] SRA  = 3'h5; // bit select 31..25 = 32 -> means Shift Right Aritmethic which carries the MSB to the left

	reg rd_value;
	always @(posedge clock & alu_extra_enable) begin
		case(funct3)
			SUB: rd_value <= rs1_value - rs2_value;
			SRA: rd_value <= rs1_value >>> rs2_value;
			default: rd_value <= `ZERO;
		endcase
	end
	always @(posedge clock & !alu_extra_enable) begin
		rd_value <= `HIGH_IMPEDANCE;
	end
endmodule

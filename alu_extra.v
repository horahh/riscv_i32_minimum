// reference:
// https://github.com/riscv/riscv-opcodes/blob/master/opcodes-rv32i
`define HIGH_IMPEDANCE 32'hFFFFFFFF

module alu_extra(
	input         clock,
	input         enable,
	input  [2:0]  funct3,
	input  [31:0] register_data_1,
	input  [31:0] register_data_2,
	output [31:0] register_data_out);
parameter
	SUB  = 3'h0, // bit select 31..25 = 32 -> means subtract
	SRA  = 3'h5; // bit select 31..25 = 32 -> means SRA 

	reg register_data_out;
	always @(posedge clock & enable) begin
		case(funct3)
			SUB: register_data_out <= register_data_1 - register_data_2;
			SRA: register_data_out <= register_data_1 >>> register_data_2;
			default: register_data_out <= 0;
		endcase
	end
	always @(posedge clock & ~enable) begin
		register_data_out <= `HIGH_IMPEDANCE;
	end
endmodule

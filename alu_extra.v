// reference:
// https://github.com/riscv/riscv-opcodes/blob/master/opcodes-rv32i
module alu_extra(
	input         clock,
	input  [6:0]  select,
	input  [6:0]  opcode,
	input  [31:0] register_data_1,
	input  [31:0] register_data_2,
	output [31:0] register_data_out);
parameter
	SUB  = 0; // bit select 31..25 = 32 -> means subtract
	SRA  = 5; // bit select 31..25 = 32 -> means SRA 

	always@(posedge clock) begin
		case(opcode)
			SUB: register_data_out <= register_data_1 - register_data_2;
			SRA: register_data_out <= register_data_1 >>> register_data_2;
			default: register_data_out <= 0;
		endcase
	end
endmodule


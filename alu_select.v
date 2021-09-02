module alu_select(
	input         clock,
	input         enable,
	input [6:0] funct7, // select operation type
	output alu_base_enable,
	output alu_extra_enable);

parameter
	BASE = 0,
	EXTRA  = 32;

	reg alu_base_enable;
	reg alu_extra_enable;

	always @(posedge clock & enable) begin
		case(funct7)
			BASE: alu_base_enable = 1;
			default: alu_base_enable = 0;
		endcase
	end
	always @(posedge clock & enable) begin
		case(funct7)
			EXTRA: alu_extra_enable = 1;
			default: alu_extra_enable = 0;
		endcase
	end
endmodule

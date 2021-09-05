module alu_select(
	input         clock,
	input         enable,
	input [6:0] funct7, // select operation type
	output alu_base_enable,
	output alu_extra_enable);

parameter
	BASE = 7'h0,
	EXTRA  = 7'h20; // 32 dec

	reg alu_base_enable;
	reg alu_extra_enable;

	always @(posedge clock & enable) begin
		case(funct7)
			BASE: alu_base_enable <= 1'b1;
			default: alu_base_enable <= 1'b0;
		endcase
	end
	always @(posedge clock & enable) begin
		case(funct7)
			EXTRA: alu_extra_enable <= 1'b1;
			default: alu_extra_enable <= 1'b0;
		endcase
	end
endmodule

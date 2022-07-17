// reference:
// https://github.com/riscv/riscv-opcodes/blob/master/opcodes-rv32i

`define HIGH_IMPEDANCE 32'bz
`define ZERO           32'b0
`define ONE            32'b1

module alu_base(
	input             clock,
	input             alu_base_enable,
	input      [2:0]  funct3,
	input      [31:0] rs1_value,
	input      [31:0] rs2_value,
	output reg [31:0] rd_value
);

	parameter [2:0] ADD  = 3'h0;
	parameter [2:0] SLL  = 3'h1;
	parameter [2:0] SLT  = 3'h2;
	parameter [2:0] SLTU = 3'h3;
	parameter [2:0] XOR  = 3'h4;
	parameter [2:0] SRL  = 3'h5;
	parameter [2:0] OR   = 3'h6;
	parameter [2:0] AND  = 3'h7;

	always @(posedge clock & alu_base_enable) begin
		case(funct3)
			ADD:     rd_value <=         rs1_value  +          rs2_value;
			SLL:     rd_value <=         rs1_value  <<         rs2_value;
			SLT:     rd_value <= $signed(rs1_value) <  $signed(rs2_value) ? `ONE : `ZERO;
			SLTU:    rd_value <=         rs1_value  <          rs2_value  ? `ONE : `ZERO;
			XOR:     rd_value <=         rs1_value  ^          rs2_value;
			SRL:     rd_value <=         rs1_value  >>         rs2_value;
			OR:      rd_value <=         rs1_value  |          rs2_value;
			AND:     rd_value <=         rs1_value  &          rs2_value;
			default: rd_value <=         `ZERO;
		endcase
	end

	always @(posedge clock & !alu_base_enable) begin
		rd_value <= `HIGH_IMPEDANCE;
	end

endmodule

// reference:
// https://github.com/riscv/riscv-opcodes/blob/master/opcodes-rv32i

`define HIGH_IMPEDANCE 32'bz

module alu_base(
	input             clock,
	input             enable,
	input      [2:0]  funct3,
	input      [31:0] register_data_1,
	input      [31:0] register_data_2,
	output reg [31:0] register_data_out);

	parameter [2:0] ADD  = 3'h0;
	parameter [2:0] SLL  = 3'h1;
	parameter [2:0] SLT  = 3'h2;
	parameter [2:0] SLTU = 3'h3;
	parameter [2:0] XOR  = 3'h4;
	parameter [2:0] SRL  = 3'h5;
	parameter [2:0] OR   = 3'h6;
	parameter [2:0] AND  = 3'h7;

	// reg [31:0] register_data_result;
	// assign register_data_out = register_data_result;

	always @(posedge clock ) begin
		case(funct3)
			3'b000:     register_data_out = register_data_1 +  register_data_2;
			3'b001:     register_data_out = register_data_1 << register_data_2;
			3'b010:     register_data_out = register_data_1 <  register_data_2 ? 32'b1 : 32'b0; // need to implement for unsigned
			3'b011:     register_data_out = register_data_1 <  register_data_2 ? 32'b1 : 32'b0;
			3'b100:     register_data_out = register_data_1 ^  register_data_2;
			3'b101:     register_data_out = register_data_1 >> register_data_2;
			3'b110:     register_data_out = register_data_1 |  register_data_2;
			3'b111:     register_data_out = register_data_1 &  register_data_2;
			default:    register_data_out = 32'b0;
		endcase
	end
	/*
	always @(posedge clock ) begin
		case(funct3)
			ADD:     register_data_out = register_data_1 +  register_data_2;
			SLL:     register_data_out = register_data_1 << register_data_2;
			SLTU:    register_data_out = register_data_1 <  register_data_2 ? 32'b1 : 32'b0;
			XOR:     register_data_out = register_data_1 ^  register_data_2;
			SRL:     register_data_out = register_data_1 >> register_data_2;
			OR:      register_data_out = register_data_1 |  register_data_2;
			AND:     register_data_out = register_data_1 &  register_data_2;
			default: register_data_out = 32'b0;
		endcase
	end
	*/
	/*
	always @(posedge clock & ~enable) begin
		register_data_out <= `HIGH_IMPEDANCE;
	end
	*/
endmodule


`define HIGH_IMPEDANCE 32'bz
`define ZERO 32'b0
`define ONE  32'b1

module register_file(
	input         clock,
	input         reset,
	input         register_file_write_enable,
	input  [4:0]  rs1,
	input  [4:0]  rs2,
	input  [4:0]  rd,
	input  [31:0] rd_value,
	output [31:0] rs1_value,
	output [31:0] rs2_value);

   // register zero here can be written to any value but when read the zero this
   // value is just ignored
	reg    [31:0] registers[31:0];

   // define a register stuck at zero apart from the others
   reg    [31:0] register_zero = `ZERO;

	always@(posedge clock & register_file_write_enable) begin
			registers[rd] <= rd_value;
	end

	assign rs1_value = rs1 ? registers[rs1] : register_zero;
	assign rs2_value = registers[rs2];

endmodule

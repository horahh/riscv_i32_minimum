`define HIGH_IMPEDANCE 32'bz
`define ZERO 32'b0
`define ONE  32'b1

module register_file(
	input  clock,
	input  reset,
	input  write_enable,
	input  [4:0] rs1,
	input  [4:0] rs2,
	input  [4:0] register_write_select,
	input  [31:0] register_data_write,
	output [31:0] register_data_1,
	output [31:0] register_data_2);

   // register zero here can be written to any value but when read the zero this
   // value is just ignored
	reg    [31:0] registers[31:0];

   // define a register stuck at zero apart from the others
   reg    [31:0] register_zero = `ZERO;

	always@(posedge clock & write_enable) begin
			registers[register_write_select] <= register_data_write;
	end

	assign register_data_1 = rs1 ? registers[rs1] : register_zero;
	assign register_data_2 = registers[rs2];

endmodule

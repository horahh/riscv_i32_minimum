
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

	reg    [31:0] registers[31:0];

	always@(posedge clock & write_enable) begin
      if (register_write_select == 0) begin
			registers[register_write_select] <= `ZERO;
      end
      else begin
			registers[register_write_select] <= register_data_write;
      end
	end

	assign register_data_1 = registers[rs1];
	assign register_data_2 = registers[rs2];

endmodule

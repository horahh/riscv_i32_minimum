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

	always@(posedge clock) begin
		if (write_enable)
			registers[register_write_select] <= register_data_write;
	end

	assign register_data_1 = registers[rs1];
	assign register_data_2 = registers[rs2];

endmodule





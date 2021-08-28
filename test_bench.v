
module test_bench;
	wire clock;
	wire reset;
	wire write_enable;
	wire [4:0] rs1;
	wire [4:0] rs2;
	wire [4:0] register_write_select;
	wire [31:0] register_data_write;
	wire [31:0] register_data_1;
	wire [31:0] register_data_2;


	design_register_file(clock, reset, write_enable, rs1, rs2, register_write_select, register_data_write, register_data_1, register_data_2);
	test_register_file(clock, reset, write_enable, rs1, rs2, register_write_select, register_data_write, register_data_1, register_data_2);
endmodule


module test_register_file(
	output  clock,
	output  reset,
	output  write_enable,
	output  [4:0] rs1,
	output  [4:0] rs2,
	output  [4:0] register_write_select,
	output  [31:0] register_data_write,
	input [31:0] register_data_1,
	input [31:0] register_data_2);

parameter
CLOCK_PERIOD = 10;

reg clock;
reg reset;
reg write_enable;
reg rs1;
reg rs2;
reg register_write_select;
reg register_data_write;


initial
begin
	clock = 0;
	forever
	@(posedge clock) begin
		$display( "clock = %b, reset = %b, write_enable = %b", clock, reset, write_enable);
		$display( "rs1 = 0x%x, rs2 = 0x%x, register_write_select = 0x%x", rs1,rs2, register_write_select);
		$display( "register_data_write = 0x%x, register_data_1 = 0x%x, register_data_2 = 0x%x", register_data_write, register_data_1, register_data_2);
	end
end

always
	#CLOCK_PERIOD clock = !clock;
endmodule




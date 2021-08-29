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

	register_file        register_file_rv32i(clock, reset, write_enable, rs1, rs2, register_write_select, register_data_write, register_data_1, register_data_2);
	test_register_file   test_register_file32i(clock, reset, write_enable, rs1, rs2, register_write_select, register_data_write, register_data_1, register_data_2);
endmodule

module test_register_file(
	output clock,
	output reset,
	output write_enable,
	output [4:0] rs1,
	output [4:0] rs2,
	output [4:0] register_write_select,
	output [31:0] register_data_write,
	input  [31:0] register_data_1,
	input  [31:0] register_data_2);

	parameter
	CLOCK_PERIOD = 10;

	reg clock;
	reg reset;
	reg write_enable;
	reg rs1;
	reg rs2;
	reg register_write_select;
	reg register_data_write;


	always
	begin
		#CLOCK_PERIOD clock = !clock;
	end

	initial
	begin
		//initialize registers 
		clock = 0; 
		reset = 0;
		// write values to all registers
		write_enable = 1;
		rs1 = 0;
		rs2 = 0;
		register_write_select = 0;
		register_data_write = 0;
		// time to read register values
		#32 ;
		write_enable = 0;


		#100 $finish;
		// write to registers values from 0 to 31
		forever @(posedge clock) begin
			register_write_select +=1;
			register_data_write +=1;
		end
		// display all registers in the rs1 output one by one
		forever @(posedge clock) begin
			rs1 +=1;
		end


		forever
		@(posedge clock) begin
			$display( "clock = %b, reset = %b, write_enable = %b", clock, reset, write_enable);
			$display( "rs1 = 0x%x, rs2 = 0x%x, register_write_select = 0x%x", rs1,rs2, register_write_select);
			$display( "register_data_write = 0x%x, register_data_1 = 0x%x, register_data_2 = 0x%x", register_data_write, register_data_1, register_data_2);
		end

	end
	initial
	begin
	end
endmodule




module test_register_file(
	output reg clock,
	output reg reset,
	output reg write_enable,
	output reg [4:0] rs1,
	output reg [4:0] rs2,
	output reg [4:0] register_write_select,
	output reg [31:0] register_data_write,
	input  [31:0] register_data_1,
	input  [31:0] register_data_2);

parameter
	CLOCK_PERIOD = 1;

	always
	begin
		#CLOCK_PERIOD clock = !clock;
	end

	initial
	begin
		$dumpfile("test_register_file_riscv32i.vcd");
		$dumpvars(clock);
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
		#66 ;
		write_enable = 0;
		#100 $finish;
	end

	initial begin
		// write to registers values from 0 to 31
		forever @(negedge clock) begin
			register_write_select +=1;
			register_data_write +=1;
		end
	end
	initial begin
		// display all registers in the rs1 output one by one
		forever @(negedge clock) begin
			rs1 +=1;
		end
	end

	initial begin
		forever
		@(posedge clock) begin
			$display( "clock = %b, reset = %b, write_enable = %b", clock, reset, write_enable);
			$display( "rs1 = 0x%x, rs2 = 0x%x, register_write_select = 0x%x", rs1,rs2, register_write_select);
			$display( "register_data_write = 0x%x, register_data_1 = 0x%x, register_data_2 = 0x%x", register_data_write, register_data_1, register_data_2);
		end
	end
endmodule

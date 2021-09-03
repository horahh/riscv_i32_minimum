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
	CLOCK_PERIOD = 1;

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
		$dumpfile("riscv32i.vcd");
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

`timescale 1s/100ms

module test_alu_base(
	output reg        clock,
	output reg        enable,
	output reg [2:0]  funct3,
	output reg [31:0] register_data_1,
	output reg [31:0] register_data_2,
	input      [31:0] register_data_out);


parameter
	CLOCK_PERIOD = 1;

	always
	begin
		#CLOCK_PERIOD clock = !clock;
	end

	initial
	begin
		$dumpfile("test_case_alu_base.vcd");
		$dumpvars();
		// initialize registers
		clock  = 0;
		enable = 0;
		// set ALU to SUM
		funct3 = 0;
		// set SUM inputs 0, 0 result=> 0
		register_data_1 = 0;
		register_data_2 = 0;
		#5
      enable = 1;
		// change SUM inputs result=> 3
		register_data_1 = 1;
		register_data_2 = 2;
		#100 $finish;
	end

	initial begin
      #7
		// display all registers in the rs1 output one by one
		forever @(negedge clock) begin
         if (register_data_2 < 10 )
            register_data_2 +=1;
         else
            register_data_2 =0;
		end
	end
   
	initial begin
		forever @(posedge clock) begin
         $display("%0t", $time);
			$display("clock = %b, funct3 = %h, register_data_1 = %h, register_data_2 = %h, register_data_out = %h", clock, funct3, register_data_1, register_data_2, register_data_out);
		end
	end
   
endmodule

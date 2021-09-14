`timescale 1s/1ms

module test_alu(
	output reg clock,
	output reg enable,
	output reg [2:0] funct3,
	output reg [6:0] funct7,
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
		clock = 0;
		enable = 1;
		register_data_1 = 1;
		register_data_2 = 2;
		funct3 = 0;
		funct7 = 0;
      #10 funct7 = 32;
		#100 $finish;
	end
	initial begin
		forever @(negedge clock) begin
			register_data_1 +=1;
			register_data_2 +=1;
		end
	end

module test_bench_program_counter;

wire        clock;
wire [31:0] instruction;
wire [31:0] pc;

test_case_program_counter test_case_program_counter1(clock,instruction, pc);
program_counter program_counter1                    (clock,instruction, pc);

endmodule

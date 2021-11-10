`timescale 1s/100ms

module test_case_rv32(
   output reg clock,
   output reg enable
);

parameter CLOCK_HALF_PERIOD = 1;

initial begin
   $dumpfile("test_case_rv32.vcd");
   $dumpvars();
   $monitor("clock=%h, pc=%h, pc_value=%h, rd=%h, rd_select=%d\n", clock, test_bench_rv32.pc, test_bench_rv32.execute_0.register_file_0.register_data_write, test_bench_rv32.execute_0.register_file_0.register_write_select );
   #100 
   $finish;
end

initial begin
   clock  = 0;
   enable = 1;
   forever begin
      #CLOCK_HALF_PERIOD clock = !clock;
   end
end

endmodule

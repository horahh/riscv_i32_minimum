`timescale 1s/100ms

module test_case_rv32(
   output reg clock,
   output reg enable
);

parameter CLOCK_HALF_PERIOD = 1;

initial begin
   $dumpfile("test_case_rv32.vcd");
   $dumpvars();
   $monitor("clock=%h, pc=%h\n", clock, test_bench_rv32.pc);
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

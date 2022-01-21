`timescale 1s/100ms

module test_case_program_counter(
      output reg        clock,
      output reg [31:0] instruction,
      input      [31:0] pc);

   parameter CLOCK_HALF = 10;

   initial begin
      clock = 0;
      instruction = 0;
      #100 $finish;
   end

   always
   begin
      #CLOCK_HALF clock = !clock;
   end

   initial begin
      $dumpfile("test_case_program_counter.vcd");
      $dumpvars();
      $monitor("clock=%b, instruction=%h, pc=%h\n", clock,instruction,pc);
   end
endmodule

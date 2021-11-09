`timescale 1s/100ms

module test_case_rv32(
   output reg clock,
   output reg enable
);

parameter CLOCK_HALF_PERIOD = 1;

initial begin
   #0 
   clock  = 0;
   enable = 1;
   #100 
   $finish;
end

initial begin
   forever begin
      #CLOCK_HALF_PERIOD clock = !clock;
   end
end

endmodule

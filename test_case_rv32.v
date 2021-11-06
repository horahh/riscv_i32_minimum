`define CLOCK_HALF_PERIOD 1

module test_case_rv32(
   output clock,
   output enable
);

initial begin
   #0 
   clock = 0;
   enable = 1;
   #100 $finish;
end

initial begin
   forever begin
      #CLOCK_HALF_PERIOD clock = !clock;
   end
end

endmodule

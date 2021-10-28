`define FINISH_MEMORY_TIME 100
`define CLOCK_HALF_PERIOD 1

module test_case_memory(
   output reg clock,
   output reg read_enable,
   output reg [31:0] read_address,
   input [31:0] read_value,
   output reg write_enable,
   output reg [31:0] write_address,
   output reg [31:0] write_value);

reg clock2;

initial
begin
   clock = 0;
   clock2 = 0;
   read_enable = 1;
   read_address = 0;
   write_enable=0;
   write_address = 0;
   read_address = 0;
   forever @(negedge clock2)
   begin
      read_address+=1;
   end
end

initial
begin
   #`FINISH_MEMORY_TIME $finish;
end

always
begin
   #`CLOCK_HALF_PERIOD clock = !clock;
end

always @(posedge clock)
begin
   clock2 = !clock2;
end


endmodule


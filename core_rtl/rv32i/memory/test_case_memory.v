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
		$dumpfile("test_case_memory.vcd");
		$dumpvars();
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

   initial begin
      forever @(posedge clock) begin
         $display("read_enable=%x, read_address=%x, read_value= %x", read_enable, read_address, read_value);
         $display("write_enable=%x, write_address=%x, write_value=%x", write_enable, write_address, write_value);
      end
   end


endmodule


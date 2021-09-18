module write_back(
   input               clock,
   input               enable,
   input        [31:0] write_address,
   output reg   [31:0] address_value,
   output              write_enable,
   output       [31:0] memory_address,
   output       [31:0] memory_value);

   always @(posedge clock & enable) begin
      memory_address = pc_address;
   end

   always @(posedge clock & enable) begin
      pc_address_value = memory_value;
   end

   assign write_enable = enable;

endmodule

module write_back(
   input               clock,
   input               enable,
   input        [31:0] write_address,
   input        [31:0] address_value,
   output              write_enable,
   output reg   [31:0] memory_address,
   output reg   [31:0] memory_value);

   always @(posedge clock & enable) begin
      memory_address <= write_address;
      memory_value   <= address_value;
   end

   assign write_enable = enable;

endmodule

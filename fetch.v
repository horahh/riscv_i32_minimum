module fetch(
   input             clock,
   input             enable,
   input      [31:0] pc_address,
   output reg [31:0] pc_address_value,
   output            read_enable,
   output     [31:0] memory_address,
   input      [31:0] memory_value);

   always @(posedge clock) begin
      memory_address = pc_address;
   end
   always @(posedge clock) begin
      pc_address_value = memory_value;
   end

   assign read_enable = enable;
   
endmodule

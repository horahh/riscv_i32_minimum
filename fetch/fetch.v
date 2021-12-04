module fetch(
   input             clock,
   input             enable,
   input      [31:0] pc,
   output reg [31:0] value_at_pc_address,
   output            read_enable,
   input      [31:0] memory_value
);

   always @(posedge clock) begin
      value_at_pc_address <= memory_value;
   end

   assign read_enable = enable;
   
endmodule

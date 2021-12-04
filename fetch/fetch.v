module fetch(
   input             clock,
   input             enable,
   input      [31:0] pc,
   output            pc_enable,
   input      [31:0] pc_value,
   output reg [31:0] instruction
);

   assign pc_enable = enable;

// for now this module is for illustrative purpose
   always @(posedge clock) begin
      instruction <= pc_value;
   end

   // PC can be used to prefetch a batch of instructions, complemented with
   // an OOO execution unit in execute module

endmodule

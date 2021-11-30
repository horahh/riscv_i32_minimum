/***********************************************************************
jal     rd jimm20                          6..2=0x1b 1..0=3
***********************************************************************/

module alu_jal(
   input             clock,
   input             enable,
   input      [31:0] jimmediate20,
   output     [31:0] rd,
   input      [31:0] pc,
   output reg [31:0] next_pc
);

always @(posedge clock) begin
   next_pc <= pc + jimmediate20;
   rd      <= pc + 4;
end

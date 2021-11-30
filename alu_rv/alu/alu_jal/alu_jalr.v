/***********************************************************************
jalr    rd rs1 imm12              14..12=0 6..2=0x19 1..0=3
***********************************************************************/
module alu_jal(
   input             clock,
   input             enable,
   input      [31:0] immediate12,
   input      [31:0] rs1,
   input      [2:0]  funct3,
   output     [31:0] rd,
   input      [31:0] pc,
   output reg [31:0] next_pc
);

always @(posedge clock) begin
   next_pc <= rs1 + immediate12;
   rd      <= pc  + 4;
end

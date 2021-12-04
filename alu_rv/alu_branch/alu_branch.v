/***********************************************************************
beq     bimm12hi rs1 rs2 bimm12lo 14..12=0 6..2=0x18 1..0=3
bne     bimm12hi rs1 rs2 bimm12lo 14..12=1 6..2=0x18 1..0=3
blt     bimm12hi rs1 rs2 bimm12lo 14..12=4 6..2=0x18 1..0=3
bge     bimm12hi rs1 rs2 bimm12lo 14..12=5 6..2=0x18 1..0=3
bltu    bimm12hi rs1 rs2 bimm12lo 14..12=6 6..2=0x18 1..0=3
bgeu    bimm12hi rs1 rs2 bimm12lo 14..12=7 6..2=0x18 1..0=3
***********************************************************************/
module alu_branch(
   input             clk,
   input             enable,
   input      [2:0]  funct3,
   input      [31:0] rs1_value,
   input      [31:0] rs2_value,
   input      [31:0] immediate12,
   input      [31:0] pc,
   output reg [31:0] next_pc
   );

parameter [2:0] BEQ  = 3'h0;
parameter [2:0] BNE  = 3'h1;
parameter [2:0] BLT  = 3'h4;
parameter [2:0] BGE  = 3'h5;
parameter [2:0] BLTU = 3'h6;
parameter [2:0] BGEU = 3'h7;

always @(posedge clock) begin
   case(funct3)
      BEQ:     next_pc <= (rs1_value == rs2_value) ? pc + immediate : pc + 4;
      BNE:     next_pc <= (rs1_value != rs2_value) ? pc + immediate : pc + 4;
      BGE:     next_pc <= (rs1_value >= rs2_value) ? pc + immediate : pc + 4;
      BLTU:    next_pc <= (rs1_value <  rs2_value) ? pc + immediate : pc + 4;
      BGEU:    next_pc <= (rs1_value >= rs2_value) ? pc + immediate : pc + 4;
      default: next_pc <= pc + 4;
   endcase
end

endmodule

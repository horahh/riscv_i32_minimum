/***********************************************************************
jalr    rd rs1 imm12              14..12=0 6..2=0x19 1..0=3
***********************************************************************/
`define HIGH_IMPEDANCE 32'bz
module alu_unconditional_jalr(
   input             clock,
   input             alu_unconditional_jalr_enable,
   input      [31:0] immediate12_itype,
   input      [31:0] rs1_value,
   input      [2:0]  funct3,
   output reg [31:0] rd_value,
   input      [31:0] pc,
   output reg [31:0] next_pc
);

always @(posedge clock & alu_unconditional_jalr_enable ) begin
   next_pc    <= rs1_value + immediate12_itype;
   rd_value   <= pc  + 4;
end

always @(posedge clock & !alu_unconditional_jalr_enable ) begin
   next_pc    <= `HIGH_IMPEDANCE;
   rd_value   <= `HIGH_IMPEDANCE;
end
endmodule

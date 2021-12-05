/***********************************************************************
jal     rd jimm20                          6..2=0x1b 1..0=3
***********************************************************************/

module alu_unconditional_jal(
   input             clock,
   input             alu_unconditional_jal_enable,
   input      [31:0] immediate20_jtype,
   output reg [31:0] rd_value,
   input      [31:0] pc,
   output reg [31:0] next_pc
);

always @(posedge clock & alu_unconditional_jal_enable ) begin
   next_pc  <= pc + immediate20_jtype;
   rd_value <= pc + 4;
end

endmodule

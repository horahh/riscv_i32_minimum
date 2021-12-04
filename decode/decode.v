/*
R-type: register-register.
I-type: short immediates and loads.
S-type: stores.
B-type: conditional branches, a variation of S-type.
U-type: long immediates.
J-type: unconditional jumps, a variation of U-type.
*/

`define ZERO 1'b0
`define ONE  1'b1

module decode(
   input            clock,
   input      [6:0] opcode,
   output reg       alu_branch_enable,
   output reg       alu_unconditional_jalr_enable,
   output reg       alu_unconditional_jal_enable,
   output reg       alu_upper_immediate_lui_enable,
   output reg       alu_upper_immediate_auipc_enable,
   output reg       alu_register_immediate_enable,
   output reg       alu_register_register_enable,
   output reg       load_enable,
   output reg       store_enable,
   output reg       fence_enable
);

   parameter [6:0] ALU_BRANCH                     = 7'h63; 
   parameter [6:0] ALU_UNCONDITIONAL_JALR         = 7'h67; 
   parameter [6:0] ALU_UNCONDITIONAL_JAL          = 7'h6f;
   parameter [6:0] ALU_UPPER_IMMEDIATE_LUI        = 7'h37;
   parameter [6:0] ALU_UPPER_IMMEDIATE_AUIPC      = 7'h17;
   parameter [6:0] ALU_REGISTER_IMMEDIATE         = 7'h0C;
   parameter [6:0] ALU_REGISTER_REGISTER          = 7'h33;
   parameter [6:0] LOAD                           = 7'h03;
   parameter [6:0] STORE                          = 7'h23;
   parameter [6:0] FENCE                          = 7'h0F;

   always @(posedge clock) begin
      alu_branch_enable                <= opcode == ALU_BRANCH                     ? `ONE : `ZERO;
      alu_unconditional_jalr_enable    <= opcode == ALU_UNCONDITIONAL_JALR         ? `ONE : `ZERO;
      alu_unconditional_jal_enable     <= opcode == ALU_UNCONDITIONAL_JAL          ? `ONE : `ZERO;
      alu_upper_immediate_lui_enable   <= opcode == ALU_UPPER_IMMEDIATE_LUI        ? `ONE : `ZERO;
      alu_upper_immediate_auipc_enable <= opcode == ALU_UPPER_IMMEDIATE_AUIPC      ? `ONE : `ZERO;
      alu_register_immediate_enable    <= opcode == ALU_REGISTER_IMMEDIATE         ? `ONE : `ZERO;
      alu_register_register_enable     <= opcode == ALU_REGISTER_REGISTER          ? `ONE : `ZERO;
      load_enable                      <= opcode == LOAD                           ? `ONE : `ZERO;
      store_enable                     <= opcode == STORE                          ? `ONE : `ZERO;
      fence_enable                     <= opcode == FENCE                          ? `ONE : `ZERO;
   end

endmodule

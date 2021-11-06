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

module rv32i_decode(
   input      [6:0] opcode,
   output reg       branch_type,
   output reg       register_type_alu,
   output reg       integer_type_jump,
   output reg       jump_type,
   output reg       unconditional_type_load,
   output reg       unconditional_type_add, 
   output reg       integer_type_alu,
   output reg       integer_type_load,
   output reg       store_type,
   output reg       fence_type
);

   parameter [6:0] BRANCH_TYPE_OPCODE       = 7'h63; 
   parameter [6:0] INTEGER_TYPE_JUMP_OPCODE = 7'h67; 
   parameter [6:0] JUMP_TYPE                = 7'h6f;
   parameter [6:0] UNCONDITIONAL_TYPE_LOAD  = 7'h37;
   parameter [6:0] UNCONDITIONAL_TYPE_ADD   = 7'h17;
   parameter [6:0] INTEGER_TYPE_ALU_OPCODE  = 7'h0C;
   parameter [6:0] REGISTER_TYPE_ALU_OPCODE = 7'h33;
   parameter [6:0] INTEGER_TYPE_LOAD_OPCODE = 7'h03;
   parameter [6:0] STORE_TYPE_OPCODE        = 7'h23;
   parameter [6:0] FENCE_TYPE_OPCODE        = 7'h0F;

   always @(posedge clock) begin
      branch_type             <= opcode == BRANCH_TYPE_OPCODE             ? `ONE : `ZERO;
      integer_type_jump       <= opcode == INTEGER_TYPE_JUMP_OPCODE       ? `ONE : `ZERO;
      jump_type               <= opcode == JUMP_TYPE_OPCODE               ? `ONE : `ZERO;
      unconditional_type_load <= opcode == UNCONDITIONAL_TYPE_LOAD_OPCODE ? `ONE : `ZERO;
      unconditional_type_add  <= opcode == UNCONDITIONAL_TYPE_ADD_OPCODE  ? `ONE : `ZERO;
      integer_type_alu        <= opcode == INTEGER_TYPE_ALU_OPCODE        ? `ONE : `ZERO;
      register_type_alu       <= opcode == REGISTER_TYPE_ALU_OPCODE       ? `ONE : `ZERO;
      integer_type_load       <= opcode == INTEGER_TYPE_LOAD_OPCODE       ? `ONE : `ZERO;
      store_type              <= opcode == STORE_TYPE_OPCODE              ? `ONE : `ZERO;
      fence_type              <= opcode == FENCE_TYPE_OPCODE              ? `ONE : `ZERO;
   end

endmodule

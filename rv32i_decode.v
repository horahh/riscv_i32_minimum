/*
R-type: register-register.
I-type: short immediates and loads.
S-type: stores.
B-type: conditional branches, a variation of S-type.
U-type: long immediates.
J-type: unconditional jumps, a variation of U-type.
*/

module rv32i_decode(
   input      [6:0] opcode
   output reg       branch_type,
   output reg       register_type_alu,
   output reg       integer_type_jump,
   output reg       jump_type,
   output reg       unconditional_type_load,
   output reg       unconditional_type_add, 
   output reg       integer_type_alu,
   output reg       register_type_alu,
   output reg       integer_type_load,
   output reg       store_type,
   output reg       fence_type
);

   parameter [6:0] BRANCH_TYPE_OPCODE = 0x063; 
   parameter [6:0] INTEGER_TYPE_JUMP_OPCODE = 0x067; 
   parameter [6:0] JUMP_TYPE = 0x6f;
   parameter [6:0] UNCONDITIONAL_TYPE_LOAD = 0x37;
   parameter [6:0] UNCONDITIONAL_TYPE_ADD = 0x17;
   parameter [6:0] INTEGER_TYPE_ALU_OPCODE = 0x00C;
   parameter [6:0] REGISTER_TYPE_ALU_OPCODE = 0x033;
   parameter [6:0] INTEGER_TYPE_LOAD_OPCODE = 0x003;
   parameter [6:0] STORE_TYPE_OPCODE = 0x023;
   parameter [6:0] FENCE_TYPE_OPCODE = 0x0F;

   branch_type = opcode == BRANCH_TYPE_OPCODE ? `ONE : ZERO;
   integer_type_jump = opcode == INTEGER_TYPE_JUMP_OPCODE ? `ONE : ZERO;
   jump_type = opcode == JUMP_TYPE_OPCODE ? `ONE : ZERO;
   unconditional_type_load = opcode == UNCONDITIONAL_TYPE_LOAD_OPCODE ? `ONE : ZERO;
   unconditional_type_add = opcode == UNCONDITIONAL_TYPE_ADD_OPCODE ? `ONE : ZERO;
   integer_type_alu = opcode == INTEGER_TYPE_ALU_OPCODE ? `ONE : ZERO;
   register_type_alu = opcode == REGISTER_TYPE_ALU_OPCODE ? `ONE : ZERO;
   integer_type_load = opcode == INTEGER_TYPE_LOAD_OPCODE ? `ONE : ZERO;
   store_type = opcode == STORE_TYPE_OPCODE ? `ONE : ZERO;
   fence_type = opcode == FENCE_TYPE_OPCODE ? `ONE : ZERO;

endmodule
   



module execute(
   input         clock,
   // feed from decode
   input  [31:0] instruction,
   input         alu_branch_enable,
   input         alu_unconditional_jalr_enable,
   input         alu_unconditional_jal_enable,
   input         alu_upper_immediate_lui_enable,
   input         alu_upper_immediate_auipc_enable,
   input         alu_register_immediate_enable,
   input         alu_register_register_enable,
   // interactions with pc
   input  [31:0] pc,
   output        next_pc_valid,
   output [31:0] next_pc,
   //interactions with registers
   output        register_file_write_enable,
   input  [31:0] rs1_value,
   input  [31:0] rs2_value,
   output [31:0] rd_value
);

   reg register_file_write_enable = 1'b1;
// instantiate functional units
   alu_rv alu_rv_0(
      .clock(clock), 
      .register_type_alu(register_type_alu), 
      .immediate_type_alu(immediate_type_alu),
      .instruction(instruction), 
      .rs1_value(rs1_value),
      .rs2_value(rs2_value),
      .rd_value(rd_value)
   );

endmodule

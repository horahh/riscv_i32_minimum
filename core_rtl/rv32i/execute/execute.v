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

// TODO: remove this
   reg register_file_write_enable = 1'b1;
// instantiate functional units
   alu_rv alu_rv_0(
      .clock(clock), 
      .instruction(instruction), 
      .alu_branch_enable(alu_branch_enable),
      .alu_unconditional_jalr_enable(alu_unconditional_jalr_enable),
      .alu_unconditional_jal_enable(alu_unconditional_jal_enable),
      .alu_upper_immediate_lui_enable(alu_upper_immediate_lui_enable),
      .alu_upper_immediate_auipc_enable(alu_upper_immediate_auipc_enable),
      .alu_register_immediate_enable(alu_register_immediate_enable),
      .alu_register_register_enable(alu_register_register_enable), 
      .pc(pc),
      .next_pc_valid(next_pc_valid),
      .next_pc(next_pc),
      .rs1_value(rs1_value),
      .rs2_value(rs2_value),
      .rd_value(rd_value)
   );

endmodule

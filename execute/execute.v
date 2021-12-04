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
   output reg    write_enable,
   output [4:0]  rs1,
   output [4:0]  rs2,
   output [4:0]  rd,
   output [31:0] rs1_value,
   output [31:0] rs2_value,
   output [31:0] rd_value
);

   wire [4:0] register_data_1_select;
   wire [4:0] register_data_2_select;
   wire [4:0] register_data_write_select;

   wire [31:0] register_data_1_value;
   wire [31:0] register_data_2_value;
   wire [31:0] register_data_write_value;

// instantiate functional units
   alu_rv alu_rv0(
      .clock(clock), 
      .register_type_alu(register_type_alu), 
      .immediate_type_alu(immediate_type_alu),
      .instruction(instruction), 
      .rs1_value(rs1_value),
      .rs2_value(rs2_value),
      .rs1(rs1),
      .rs2(rs2),
      .rd(rd),
      .rd_value(rd_value)
   );

endmodule

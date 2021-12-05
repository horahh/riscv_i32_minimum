module alu_rv(
   input         clock,
   input         register_type_alu,
   input         immediate_type_alu,
   input  [31:0] instruction,
   // Register File
   input  [31:0] rs1_value,
   input  [31:0] rs2_value,
   output [31:0] rd_value,
   // PC interactions
   input  [31:0] pc,
   output        next_pc_valid,
   output [31:0] next_pc
);

   wire        clock;
   wire [31:0] instruction;
   wire [2:0]  funct3;
   wire [6:0]  funct7;
   wire [6:0]  opcode;
   // unconnected because repeated decode_field module in top bench
   wire [4:0]  rs1;
   wire [4:0]  rs2;
   wire [4:0]  rd;
   // end unconnected because repeated decode_field module in top bench
   wire [31:0] immediate12_itype;
   wire [31:0] immediate12_stype;
   wire [31:0] immediate12_btype;
   wire [31:0] immediate20_utype;
   wire [31:0] immediate20_jtype;

decode_field decode_field_0(
   .clock(clock),
   .instruction(instruction),
   .funct3(funct3),
   .funct7(funct7),
   .opcode(opcode),
   .rs1(rs1),
   .rs2(rs2),
   .rd(rd),
   .immediate12_itype(immediate12_itype),
   .immediate12_stype(immediate12_stype),
   .immediate12_btype(immediate12_btype),
   .immediate20_utype(immediate20_utype),
   .immediate20_jtype(immediate20_jtype)
);

alu_branch alu_branch_0(
   .clock(clock),
   .alu_branch_enable(alu_branch_enable),
   .funct3(funct3),
   .rs1_value(rs1_value),
   .rs2_value(rs2_value),
   .immediate12_btype(immediate12_btype),
   .pc(pc),
   .next_pc(next_pc)
);

alu_unconditional_jalr alu_unconditional_jalr_0(
   .clock(clock),
   .alu_unconditional_jalr_enable(alu_unconditional_jalr_enable),
   .immediate12_itype(immediate12_itype),
   .rs1_value(rs1_value),
   .funct3(funct3),
   .rd_value(rd_value),
   .pc(pc),
   .next_pc(next_pc)
);

alu_unconditional_jal alu_unconditional_jal_0(
   .clock(clock),
   .alu_unconditional_jal_enable(alu_unconditional_jal_enable),
   .immediate20_jtype(immediate20_jtype),
   .rd_value(rd_value),
   .pc(pc),
   .next_pc(next_pc)
);

alu_upper_immediate_lui alu_upper_immediate_lui_0(
   .clock(clock),
   .alu_upper_immediate_lui_enable(alu_upper_immediate_lui_enable),
   .immediate20_utype(immediate20_utype),
   .rs1_value(rs1_value),
   .rd_value(rd_value),
   .pc(pc)
);

alu_upper_immediate_auipc alu_upper_immediate_auipc_0(
   .clock(clock),
   .alu_upper_immediate_auipc_enable(alu_upper_immediate_auipc_enable),
   .rs1_value(rs1_value),
   .rd_value(rd_value),
   .pc(pc)
);

alu_register_immediate alu_register_immediate_0(
   .clock(clock),
   .alu_register_immediate_enable(alu_register_immediate_enable),
   .funct3(funct3),
   .rs1_value(rs1_value),
   .immediate12_itype(immediate12_itype),
   .rd_value(rd_value)
);

alu_register_register alu_register_register_0(
   .clock(clock),
   .alu_register_register_enable(alu_register_register_enable), 
   .funct3(funct3),
   .funct7(funct7),
   .rs1_value(rs1_value),
   .rs2_value(rs2_value),
   .rd_value(rd_value)
);

endmodule

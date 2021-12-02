`define ZERO 7'b0

module alu_rv(
   input         clock,
   input         register_type_alu,
   input         immediate_type_alu,
   input  [31:0] instruction,
   // Register File
   input  [31:0] rs1_value,
   input  [31:0] rs2_value,
   output [4:0]  rs1,
   output [4:0]  rs2,
   output [4:0]  rd,
   output [31:0] rd_result
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
   wire [4:0]  rs1;
   wire [4:0]  rs2;
   wire [4:0]  rd;
   wire [31:0] immediate12_itype;
   wire [31:0] immediate12_stype;
   wire [31:0] immediate12_btype;
   wire [31:0] immediate20_utype;
   wire [31:0] immediate20_jtype;

field_decode field_decode_0(
   .clock(clock),
   .instruction(instruction),
   .funct3(funct3),
   .funct7(funct7),
   .opcode(
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
   .clk(clk),
   .alu_branch_enable(alu_branch_enable),
   .funct3(funct3),
   .rs1_value(rs1_value),
   .rs2_value(rs2_value),
   .immediate12(immediate12),
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
   .jimmediate20(jimmediate20),
   .rd_value(rd_value),
   .pc(pc),
   .next_pc(next_pc)
);

alu_upper_immediate_lui alu_upper_immediate_lui_0(
   .clk(clk),
   .alu_upper_immediate_lui_enable(alu_upper_immediate_lui_enable),
   .immediate20_utype(immediate20_utype),
   .rs1_value(rs1_value),
   .rd_value(rd_value),
   .pc(pc)
);

alu_upper_immediate_auipc alu_upper_immediate_auipc_0(
   .clk(clk),
   .alu_upper_immediate_auipc_enable(alu_upper_immediate_auipc_enable),
   .alu_upper_immediate_auipc_enable(alu_upper_immediate_auipc_enable),
   .rs1_value(rs1_value),
   .rd_value(rd_value),
   .pc(pc)
);

alu_register_immediate alu_register_immediate_0(
   .clock(clock),
   .alu_register_immediate_enable(alu_register_immediate_enable),
   .funct3(funct3),
   .rs1(rs1),
   .immediate12_itype(immediate12_itype),
   .rd_value(rd_value)
);

alu_register_register alu_register_register_0(
   .clock(clock),
   .alu_register_register_enable(alu_register_register_enable), 
   .funct3(funct3),
   .funct7(funct7),
   .operand_0(rs1_value),
   .operand_1(operand_2_value),
   .destination(rd_result)
);

endmodule

module test_bench_rv32;
   wire        clock;
   wire        read_pc_address_enable;
   wire        enable;
   wire [31:0] pc;
   wire        read_enable;
   wire [31:0] memory_read_address;
   wire [31:0] memory_read_value;
   wire        memory_write_enable;
   wire [31:0] memory_write_address;
   wire [31:0] memory_write_value;
   wire [31:0] pc_instruction;
   wire        write_back_enable;
   wire        next_pc_valid;
   wire [31:0] next_pc;

   test_case_rv32 test_case_rv32_0(
      .clock(clock),
      .enable(enable)
   );

   // MEMORY AND REGISTERS

   wire [31:0] pc_value;
   memory memory_0(
      .clock(clock),
      .pc_enable(pc_enable),
      .pc(pc),
      .pc_value(pc_value),
      .read_enable(read_enable),
      .read_address(memory_read_address),
      .read_value(memory_read_value),
      .write_enable(memory_write_enable),
      .write_address(memory_write_address),
      .write_value(memory_write_value)
   );

   program_counter program_counter_0(
      .clock(clock),
      .control_instruction(control_instruction),
      .next_pc(next_pc),
      .pc(pc)
   );

   reg register_file_reset = 0;

   wire [4:0] rs1;
   wire [4:0] rs2;
   wire [4:0] rd;
   wire [31:0] rs1_value;
   wire [31:0] rs2_value;
   wire [31:0] rd_value;
   register_file register_file_0(
      .clock(clock),
      .reset(register_file_reset),
      .register_file_write_enable(register_file_write_enable),
      .rs1(rs1),
      .rs2(rs2),
      .rd(rd),
      .rd_value(rd_value),
      .rs1_value(rs1_value),
      .rs2_value(rs2_value)
   );

   // PROCESSOR LOGIC
   wire [31:0] instruction;
   fetch fetch_0 (
      .clock(clock), 
      .enable(enable),
      .pc(pc),
      .pc_enable(pc_enable),
      .pc_value(pc_value),
      .instruction(instruction)
   );

   wire       alu_branch_enable;
   wire       alu_unconditional_jalr_enable;
   wire       alu_unconditional_jal_enable;
   wire       alu_upper_immediate_lui_enable;
   wire       alu_upper_immediate_auipc_enable;
   wire       alu_register_immediate_enable;
   wire       alu_register_register_enable;
   wire       load_enable;
   wire       store_enable;
   wire       fence_enable;

   wire [6:0] opcode;
   wire [2:0] funct3;
   wire [6:0] funct7;
   decode decode_0(
      .clock(clock),
      .opcode(opcode),
      .instruction(instruction),
      .alu_branch_enable(alu_branch_enable),
      .alu_unconditional_jalr_enable(alu_unconditional_jalr_enable),
      .alu_unconditional_jal_enable(alu_unconditional_jal_enable),
      .alu_upper_immediate_lui_enable(alu_upper_immediate_lui_enable),
      .alu_upper_immediate_auipc_enable(alu_upper_immediate_auipc_enable),
      .alu_register_immediate_enable(alu_register_immediate_enable),
      .alu_register_register_enable(alu_register_register_enable),
      .load_enable(load_enable),
      .store_enable(store_enable),
      .fence_enable(fence_enable),
      .control_instruction(control_instruction)
   );

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

   execute execute_0(
      .clock(clock),
      .instruction(pc_instruction),
   // feed from decode
      .alu_branch_enable(alu_branch_enable),
      .alu_unconditional_jalr_enable(alu_unconditional_jalr_enable),
      .alu_unconditional_jal_enable(alu_unconditional_jal_enable),
      .alu_upper_immediate_lui_enable(alu_upper_immediate_lui_enable),
      .alu_upper_immediate_auipc_enable(alu_upper_immediate_auipc_enable),
      .alu_register_immediate_enable(alu_register_immediate_enable),
      .alu_register_register_enable(alu_register_register_enable),
   // interactions with pc
      .pc(pc),
      .next_pc_valid(next_pc_valid),
      .next_pc(next_pc),
   //interactions with registers
      .register_file_write_enable(register_file_write_enable),
      .rs1_value(rs1_value),
      .rs2_value(rs2_value),
      .rd_value(rd_value)
   );
   
load load_0(
      .clock(clock),
      .load_enable(load_enable),
      .funct3(funct3),
      .rs1_value(rs1_value),
      .immediate12(immediate12),
      .rd_value(rd_value),
      .memory_read_address(memory_read_address),
      .memory_read_value(memory_read_value)
);

store store_0(
      .clock(clock),
      .store_enable(store_enable),
      .funct3(funct3),
      .rs1_value(rs1_value),
      .immediate12_store(immediate12_store),
      .rs2_value(rs2_value),
      .memory_read_address(memory_read_address),
      .memory_read_value(memory_read_value),
      .memory_write_address(memory_write_address),
      .memory_write_value(memory_write_value)
);

endmodule

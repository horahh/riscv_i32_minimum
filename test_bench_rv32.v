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

   // TODO: implement store and load memory operations
   reg read_enable_mem = 0;
   reg write_enable_mem = 0;
   assign read_enable = read_enable_mem;
   assign write_enable = write_enable_mem;
   // MEMORY AND REGISTERS
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
      .next_pc_valid(next_pc_valid),
      .next_pc(next_pc),
      .pc(pc)
   );

   reg register_file_write_enable =1;
   reg register_file_reset = 0;

   register_file register_file_0(
      .clock(clock),
      .reset(register_file_reset),
      .write_enable(register_file_write_enable),
      .rs1(rs1),
      .rs2(rs2),
      .rd(rd),
      .rd_value(rd_value),
      .rs1_value(rs1_value),
      .rs2_value(rs2_value)
   );

   // PROCESSOR LOGIC
   fetch fetch_0 (
      .clock(clock), 
      .enable(enable),
      .pc(pc),
      .pc_enable(pc_enable),
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
   assign opcode = pc_instruction[6:0];
   decode decode_0(
      .clock(clock),
      .opcode(opcode),
      .alu_branch_enable(alu_branch_enable),
      .alu_unconditional_jalr_enable(alu_unconditional_jalr_enable),
      .alu_unconditional_jal_enable(alu_unconditional_jal_enable),
      .alu_upper_immediate_lui_enable(alu_upper_immediate_lui_enable),
      .alu_upper_immediate_auipc_enable(alu_upper_immediate_auipc_enable),
      .alu_register_immediate_enable(alu_register_immediate_enable),
      .alu_register_register_enable(alu_register_register_enable),
      .load_enable(load_enable),
      .store_enable(store_enable),
      .fence_enable(fence_enable)
   );

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
      .write_enable(write_enable),
      .rs1(rs1),
      .rs2(rs2),
      .rd(rd),
      .rs1_value(rs1_value),
      .rs2_value(rs2_value),
      .rd_value(rd_value)
   );
   
load load_0(
      .clock(clock),
      .enable(load_enable),
      .funct3(funct3),
      .rs1(rs1),
      .immediate12(immediate12),
      .rd(rd),
      .memory_read_address(memory_read_address),
      .memory_read_value(memory_read_value)
);

store store_0(
      .clock(clock),
      .enable(store_enable),
      .funct3(funct3),
      .rs1(rs1),
      .immediate12_store(immediate12_store),
      .rs2(rs2),
      .memory_read_address(memory_read_address),
      .memory_read_value(memory_read_value),
      .memory_write_address(memory_write_address),
      .memory_write_value(memory_write_value)
);

endmodule

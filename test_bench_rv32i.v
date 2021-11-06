module test_bench_rv32i;

   wire        clock;
   wire        read_enable;
   wire [31:0] pc;
   wire [31:0] memory_read_value;
   wire        memory_write_enable;
   wire        memory_write_address;
   wire [31:0] memory_write_value;
   wire [31:0] pc_instruction;

   memory memory_1(
      .clock(clock),
      .read_enable(read_enable),
      .read_address(address_value),
      .read_value(memory_read_value),
      .write_enable(memory_write_enable),
      .write_address(memory_write_address),
      .write_value(memory_write_value);

   program_counter program_counter_1(
      .clock(clock),
      .instruction(memory_address),
      .pc(pc)
   );

   fetch fetch_1 (
      .clock(clock), 
      .enable(read_enable),
      .pc(pc),
      .pc_address_value(pc_instruction),
      .read_enable(read_enable)
      .memory_address(read_address)
      .memory_value(read_value)
      );


   assign instruction_opcode = pc_instruction[6:0];
   decode decode_1(
      .opcode(instruction_opcode),
      .branch_type(branch_type),
      .register_type_alu(register_type_alu),
      .integer_type_jmp(integer_type_jump),
      .jump_type(jump_type),
      .unconditional_type_load(unconditional_type_load),
      .unconditional_type_add(unconditional_type_add),
      .integer_type_alu((integer_type_alu),
      .register_type_alu(register_type_alu),
      .integer_type_load(integer_type_load),
      .store_type(store_type),
      .fence_type(fence_type)
   );

   execute execute1(
      .clock(clock),
      .instruction(pc_instruction),
      .branch_type(branch_type),
      .register_type_alu(register_type_alu),
      .integer_type_jmp(integer_type_jump),
      .jump_type(jump_type),
      .unconditional_type_load(unconditional_type_load),
      .unconditional_type_add(unconditional_type_add),
      .integer_type_alu((integer_type_alu),
      .register_type_alu(register_type_alu),
      .integer_type_load(integer_type_load),
      .store_type(store_type),
      .fence_type(fence_type)
      .write_back_enable(write_back_enable),
      .memory_address(pc),
      .memory_value(pc_address_value)
   );



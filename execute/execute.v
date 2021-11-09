module execute(
   input         clock,
   input  [31:0] instruction,
   input         branch_type,
   input         register_type_alu,
   input         integer_type_jump,
   input         jump_type,
   input         unconditional_type_load,
   input         unconditional_type_add, 
   input         integer_type_alu,
   input         integer_type_load,
   input         store_type,
   input         fence_type,
   output        write_back_enable,
   output [31:0] memory_address
);

// instantiate functional units
   alu_rv alu_execute_0(
      .clock(clock), 
      .enable(register_type_alu), 
      .instruction(instruction), 
      .rs1(register_data_1_select),
      .rs2(register_data_2_select),
      .rd(register_data_write)
   );

   assign rs1 = instruction[11:7];
   assign rs2 = instruction[19:15];
   assign rd  = instruction[24:20];

   register_file register_file_0(
      .clock(clock),
      .reset(reset),
      .write_enable(write_enable),
      .rs1(rs1),
      .rs2(rs2),
      .register_write_select(rd),
      .register_data_write(register_data_write),
      .register_data_1(register_data_1),
      .register_data_2(register_data_2)
   )

endmodule

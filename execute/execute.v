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

   wire [4:0] register_data_1_select;
   wire [4:0] register_data_2_select;
   wire [4:0] register_data_write_select;

   wire [31:0] register_data_1_value;
   wire [31:0] register_data_2_value;
   wire [31:0] register_data_write_value;

// instantiate functional units
   alu_rv alu_execute_0(
      .clock(clock), 
      .enable(register_type_alu), 
      .instruction(instruction), 
      .rs1_value(register_data_1_value),
      .rs2_value(register_data_2_value),
      .rs1(register_data_1_select),
      .rs2(register_data_2_select),
      .rd(register_data_write_select),
      .rd_result(register_data_write_value)
   );

   reg write_enable =1;
   reg reset = 0;

   register_file register_file_0(
      .clock(clock),
      .reset(reset),
      .write_enable(write_enable),
      .rs1(register_data_1_select),
      .rs2(register_data_2_select),
      .register_write_select(register_data_write_select),
      .register_data_write(register_data_write_value),
      .register_data_1(register_data_1_value),
      .register_data_2(register_data_2_value)
   );

endmodule

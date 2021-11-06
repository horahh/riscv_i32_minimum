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
   output [31:0] memory_address,
   output [31:0] memory_value     
);

// instantiate register file

// instantiate functional units
if ( register_type_alu ) begin
   alu_execute alu_execute_0(
      .clock(clock), 
      .enable(register_type_alu), 
      .instruction(instruction), 
      .rs1(register_data_1_select),
      .rs2(register_data_2_select),
      .rd(register_data_out_select)
   );
   
end

endmodule

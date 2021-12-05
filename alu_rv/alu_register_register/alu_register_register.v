module alu_register_register(
	input             clock,
	input             alu_register_register_enable,
   input      [2:0]  funct3, 
	input      [6:0]  funct7,
   input      [31:0] rs1_value,
   input      [31:0] rs2_value,
   output     [31:0] rd_value 
	);

   alu_select alu_select_0(
      .clock(clock), 
      .alu_register_register_enable(alu_register_register_enable), 
      .funct7(funct7), 
      .alu_base_enable(alu_base_enable), 
      .alu_extra_enable(alu_base_enable)
   );

   alu_base alu_base_0(
      .clock(clock), 
      .alu_base_enable(alu_base_enable), 
      .funct3(funct3), 
      .rs1_value(rs1_value), 
      .rs2_value(rs2_value), 
      .rd_value(rs2_value)
   );

   alu_extra alu_extra_0(
      .clock(clock), 
      .alu_extra_enable(alu_extra_enable), 
      .funct3(funct3), 
      .rs1_value(rs1_value),
      .rs2_value(rs2_value),
      .rd_value(rd_value)
   );

endmodule

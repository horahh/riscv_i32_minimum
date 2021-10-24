module alu(
	input             clock,
	input             enable,
// funct3 not used now, but can be used to modify operations, like having "add and shift"
   input      [2:0]  funct3, 
	input      [6:0]  funct7, // select operation type
   input      [31:0] operand_0,
   input      [31:0] operand_1,
   output     [31:0] destination
	);

   alu_select alu_select_0(clock, enable, funct7, alu_base_enable, alu_extra_enable);

   alu_base alu_base_0(clock, alu_base_enable, funct3, operand_0, operand_1, destination);
   alu_extra alu_extra_0(clock, alu_extra_enable, funct3, operand_0, operand_1, destination);

endmodule

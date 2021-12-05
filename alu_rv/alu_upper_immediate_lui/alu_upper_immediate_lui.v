/***********************************************************************
lui     rd imm20 6..2=0x0D 1..0=3
***********************************************************************/
`define HIGH_IMPEDANCE 32'bz
module alu_upper_immediate_lui(
   input             clock,
   input             alu_upper_immediate_lui_enable,
   input      [31:0] immediate20_utype,
   input      [31:0] rs1_value,
   output reg [31:0] rd_value,
   input      [31:0] pc
);

   always @(posedge clock & alu_upper_immediate_lui_enable)
   begin 
      rd_value <= immediate20_utype;
   end

	always @(posedge clock & !alu_upper_immediate_lui_enable) begin
		rd_value = `HIGH_IMPEDANCE;
	end
endmodule

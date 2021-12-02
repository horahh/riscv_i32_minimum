/***********************************************************************
lui     rd imm20 6..2=0x0D 1..0=3
***********************************************************************/
module alu_upper_immediate_lui(
   input             clk,
   input             alu_upper_immediate_lui_enable,
   input      [31:0] immediate20_utype,
   input      [31:0] rs1_value,
   output     [31:0] rd_value,
   input      [31:0] pc
);

   always @(posedge clock)
   begin 
      rd <= immediate20_utype;
   end

	always @(posedge clock & !enable) begin
		rd_value = `HIGH_IMPEDANCE;
	end
endmodule

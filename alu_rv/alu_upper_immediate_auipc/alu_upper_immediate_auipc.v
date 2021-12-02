/***********************************************************************
auipc   rd imm20 6..2=0x05 1..0=3
***********************************************************************/
module alu_upper_immediate_auipc(
   input             clk,
   input             enable,
   input      [31:0] immediate20_utype,
   input      [31:0] rs1_value,
   output     [31:0] rd_value,
   input      [31:0] pc
);

   always @(posedge clock)
   begin
      rd <= pc + immediate20_utype;
   end

	always @(posedge clock & !enable) begin
		rd_value = `HIGH_IMPEDANCE;
	end
endmodule

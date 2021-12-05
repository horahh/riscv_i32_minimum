/***********************************************************************
auipc   rd imm20 6..2=0x05 1..0=3
***********************************************************************/
module alu_upper_immediate_auipc(
   input             clock,
   input             alu_upper_immediate_auipc_enable,
   input      [31:0] immediate20_utype,
   input      [31:0] rs1_value,
   output reg [31:0] rd_value,
   input      [31:0] pc
);

   always @(posedge clock & alu_upper_immediate_auipc_enable)
   begin
      rd_value <= pc + immediate20_utype;
   end

	always @(posedge clock & !alu_upper_immediate_auipc_enable) begin
		rd_value = `HIGH_IMPEDANCE;
	end
endmodule

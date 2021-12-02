/***********************************************************************
lui     rd imm20 6..2=0x0D 1..0=3
auipc   rd imm20 6..2=0x05 1..0=3
***********************************************************************/
module alu_upper_immediate(
   input             clk,
   input             enable,
   input      [6:0]  opcode,
   input      [31:0] immediate20_utype,
   input      [31:0] rs1_value,
   output     [31:0] rd_value,
   input      [31:0] pc
);

parameter [6:0] LUI   = 7'h3B;
parameter [6:0] AUIPC = 7'h17;

always @(posedge clock)
begin
   case(opcode)
      LUI:     rd <= immediate20_utype;
      AUIPC:   rd <= pc + immediate20_utype;
      default: rd <= 0;
   endcase
end

	always @(posedge clock & !enable) begin
		rd_value = `HIGH_IMPEDANCE;
	end
endmodule


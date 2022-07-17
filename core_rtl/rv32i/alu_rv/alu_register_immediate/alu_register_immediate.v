`define HIGH_IMPEDANCE 32'bz
`define ZERO           32'b0
`define ONE            32'b1

module alu_register_immediate(
   input             clock,
   input             alu_register_immediate_enable,
   input      [2:0]  funct3,
   input      [31:0] rs1_value,
   input      [31:0] immediate12_itype,
   output reg [31:0] rd_value
);

parameter [2:0] ADDI   = 3'h0;
parameter [2:0] SLTI   = 3'h2;
parameter [2:0] SLTU   = 3'h3;
parameter [2:0] XORI   = 3'h4;
parameter [2:0] ORI    = 3'h6;
parameter [2:0] ANDI   = 3'h7;

always @(posedge clock & alu_register_immediate_enable) begin
   case(funct3)
      ADDI:    rd_value <= rs1_value + immediate12_itype;
      SLTI:    rd_value <= $signed(rs1_value) < $signed(immediate12_itype) ? `ONE : `ZERO;
      SLTU:    rd_value <= rs1_value < immediate12_itype ? `ONE : `ZERO;
      XORI:    rd_value <= rs1_value ^ immediate12_itype;
      ORI:     rd_value <= rs1_value | immediate12_itype;
      ANDI:    rd_value <= rs1_value & immediate12_itype;
      default: rd_value <= `ZERO;
   endcase
end

	always @(posedge clock & !alu_register_immediate_enable) begin
		rd_value <= `HIGH_IMPEDANCE;
	end

endmodule

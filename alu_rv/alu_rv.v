DEFINE ZERO 7'b0
module alu_rv(
   input clock,
   input register_type_alu,
   input immediate_type_alu,
   input [31:0] instruction,
   input [31:0] rs1_value,
   input [31:0] rs2_value,
   output [4:0] rs1,
   output [4:0] rs2,
   output [4:0] rd,
   output [31:0] rd_result
);

wire [2:0] funct3;
wire [6:0] funct7;
wire [4:0] rs1;
wire [4:0] rs2;
wire [4:0] rd;


parameter [2:0] ADDI   = 3'b0;
parameter [2:0] SLTI   = 3'b2;
parameter [2:0] SLTU   = 3'b3;
parameter [2:0] XORI   = 3'b4;
parameter [2:0] ORI    = 3'b6;
parameter [2:0] ANDI   = 3'b7;


// split instruction into fields
// source: https://github.com/jameslzhu/riscv-card/blob/master/riscv-card.pdf
// core instructions format for R type
assign funct3 = instruction[14:12];
// funct7 for register type selects alu_base or alu_extra 
// based on being 0x0 or 0x20.
// For Immediate type should always use alu base, 0x0 
reg [6:0] funct7_logic_select = register_type_alu ? instruction[31:25] : `ZERO;
assign funct7 = funct7_logic_select;
assign rs1    = instruction[19:15];
assign rs2    = instruction[24:20];
assign rd     = instruction[11:7];

// connect alu
wire [31:0] operand_2_value;
wire [11:0] immediate_value_original;
assign immediate_value_original = instruction[31:20];
reg  [31:0] immediate_operand_value ;
always @(posedge clk) begin
   case(funct3):
      ADDI:
      SLTI:
      XORI:
      ORI:
      ANDI:    immediate_operand_value <= $signed(immediate_value_original);
      SLTU:    immediate_operand_value <= $unsigned(immediate_value_original);
      default: immediate_operand_value <= 32'b0;
   end
end
reg alu_enable = register_type_alu | immediate_type_alu;
reg [31:0] operand_2_value = register_type_alu ? rs2: immediate_operand_value;
alu alu_0(
   .clock(clock),
   .enable(alu_enable), 
   .funct3(funct3),
   .funct7(funct7),
   .operand_0(rs1_value),
   .operand_1(operand_2_value),
   .destination(rd_result)
);
endmodule


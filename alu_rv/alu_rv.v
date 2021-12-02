`define ZERO 7'b0

module alu_rv(
   input         clock,
   input         register_type_alu,
   input         immediate_type_alu,
   input  [31:0] instruction,
   input  [31:0] rs1_value,
   input  [31:0] rs2_value,
   output [4:0]  rs1,
   output [4:0]  rs2,
   output [4:0]  rd,
   output [31:0] rd_result
   // PC interactions
   input  [31:0] pc,
   output        next_pc_valid,
   output [31:0] next_pc
);

wire [2:0] funct3;
wire [6:0] funct7;
wire [4:0] rs1;
wire [4:0] rs2;
wire [4:0] rd;

// split instruction into fields
// source: https://github.com/jameslzhu/riscv-card/blob/master/riscv-card.pdf
// core instructions format for R type
assign funct3 = instruction[14:12];
// funct7 for register type selects alu_base or alu_extra 
// based on being 0x0 or 0x20.
// For Immediate type should always use alu base, 0x0 
reg [6:0] funct7_logic_select ;
always @* begin
funct7_logic_select = register_type_alu ? instruction[31:25] : `ZERO;
end

assign funct7 = funct7_logic_select;
assign rs1    = instruction[19:15];
assign rs2    = instruction[24:20];
assign rd     = instruction[11:7];

// connect alu
wire [11:0] immediate_value_original;
assign immediate_value_original = instruction[31:20];
reg  [31:0] immediate_operand_value ;


reg alu_enable ;
always @* begin
   alu_enable = register_type_alu | immediate_type_alu;
end

reg [31:0] operand_2_value ;
always @* begin
operand_2_value = register_type_alu ? rs2: immediate_operand_value;
end

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


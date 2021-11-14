module alu_rv(
   input clock,
   input enable,
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

// split instruction into fields
// source: https://github.com/jameslzhu/riscv-card/blob/master/riscv-card.pdf
// core instructions format for R type
assign funct3 = instruction[14:12];
assign funct7 = instruction[31:25];
assign rs1    = instruction[19:15];
assign rs2    = instruction[24:20];
assign rd     = instruction[11:7];

// connect alu

alu alu_0(
   .clock(clock),
   .enable(enable), 
   .funct3(funct3),
   .funct7(funct7),
   .operand_0(rs1_value),
   .operand_1(rs2_value),
   .destination(rd_result)
);
endmodule


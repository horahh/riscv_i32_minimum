module decode_field(
   input             clock,
   input      [31:0] instruction,
   output     [2:0]  funct3,
   output     [6:0]  funct7,
   output     [6:0]  opcode,
   output     [4:0]  rs1,
   output     [4:0]  rs2,
   output     [4:0]  rd,
   output reg [31:0] immediate12_itype,
   output reg [31:0] immediate12_stype,
   output reg [31:0] immediate12_btype,
   output reg [31:0] immediate20_utype,
   output reg [31:0] immediate20_jtype
);

// Field Extraction 
assign opcode = instruction[6:0];
assign funct3 = instruction[14:12];
assign funct7 = instruction[31:25];
assign rs1 = instruction[19:15];
assign rs2 = instruction[24:20];
assign rd = instruction[11:7];
// Register Definitions for constants

reg zero    =  1'b0;
reg zero_12 = 12'b0;
reg zero_20 = 20'b0;

always @(posedge clock) begin
   immediate12_itype <= {{20{instruction[31]}},instruction[31:20]};
   immediate12_stype <= {{funct7},{rd}};
   immediate12_btype <= {{instruction[31]},{instruction[7]},{instruction[30:25]},{instruction[11:8]},{zero}};
   immediate20_utype <= {{instruction[31:12]},{zero_12}};
   immediate20_jtype <= {{instruction[31]},{instruction[19:12]},{instruction[20]},{instruction[30:21]},{zero}};
end

endmodule

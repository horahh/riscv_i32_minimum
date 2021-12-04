module load(
   input             clock,
   input             enable,
   input      [2:0]  funct3,
   input      [31:0] operand1,
   input      [31:0] immediate12,
   output reg [31:0] result,
   output     [31:0] memory_read_address,
   input      [31:0] memory_read_value,
);

parameter [2:0] LB  = 3'h0;
parameter [2:0] LH  = 3'h1;
parameter [2:0] LW  = 3'h2;
parameter [2:0] LBU = 3'h4;
parameter [2:0] LHU = 3'h5;

reg [31:0] byte_read ;
reg [31:0] half_read ;

wire [7:0]  byte_read = memory_read_value[7:0];
wire [15:0] half_read = memory_read_value[15:0];

// This code assume reads aligned to lsb side of a word
always @(posedge clock & enable) begin
   case(funct3)
      LB:      rd <= $signed(byte_read);
      LH:      rd <= $signed(half_read);
      LW:      rd <= memory_read_value;
      LBU:     rd <= $unsigned(byte_read);
      LH:      rd <= $unsigned(half_read);
      default: rd <= 0;
end

endmodule

//wire [1:0] byte_in_word_address = memory_read_address[1:0];
//
//parameter [1:0] FIRST_BYTE  = 2'h0;
//parameter [1:0] SECOND_BYTE = 2'h0;
//parameter [1:0] THIRD_BYTE  = 2'h0;
//parameter [1:0] FOURTH_BYTE = 2'h0;

//always @(posedge clock & enable) begin
//   case(byte_in_word_address)
//      FIRST_BYTE : byte_read = memory_read_value[7:0];
//      SECOND_BYTE: byte_read = memory_read_value[15:8];
//      THIRD_BYTE:  byte_read = memory_read_value[23:16];
//      FOURTH_BYTE: byte_read = memory_read_value[31:23];
//      default:     byte_read = 0;
//   endcase
//end
//
//wire half_in_word_address = memory_read_address[0];
//always @(posedge clock & enable) begin
//   case(half_in_word_address)
//end

module store(
   input             clock,
   input             enable,
   input      [2:0]  funct3,
   input      [31:0] operand1,
   input      [31:0] immediate12_store,
   output reg [31:0] operand2,
   output     [31:0] memory_read_address,
   input      [31:0] memory_read_value,
   output     [31:0] memory_write_address,
   output     [31:0] memory_write_value
);

parameter [2:0] SB = 3'h0;
parameter [2:0] SH = 3'h1;
parameter [2:0] SW = 3'h2;

reg [31:0] mem_write_value;

always @(posedge clock) begin
   case(funct3)
      SB:      memory_write_address <= {{memory_read_value[31:8]},{operand1[7:0]};
      SH:      memory_write_address <= {{memory_read_value[31:16]},{operand1[15:0]};
      SW:      memory_write_address <= operand1[15:0];
      default: memory_write_address <= 0;
end

endmodule

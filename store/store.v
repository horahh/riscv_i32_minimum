`define ZERO           32'b0

module store(
   input             clock,
   input             store_enable,
   input      [2:0]  funct3,
   input      [31:0] rs1_value,
   input      [31:0] rs2_value,
   input      [31:0] immediate12_store,
   output     [31:0] memory_read_address,
   input      [31:0] memory_read_value,
   output reg [31:0] memory_write_address,
   output reg [31:0] memory_write_value
);

parameter [2:0] SB = 3'h0;
parameter [2:0] SH = 3'h1;
parameter [2:0] SW = 3'h2;

reg [31:0] mem_write_value;

always @(posedge clock) begin
   case(funct3)
      SB:      memory_write_value <= {{memory_read_value[31:8]},{rs2[7:0]}};
      SH:      memory_write_value <= {{memory_read_value[31:16]},{rs2[15:0]}};
      SW:      memory_write_value <= rs2;
      default: memory_write_value <= `ZERO;
   endcase
end

wire [31:0] memory_read_address ;
assign memory_read_address = memory_write_value;

always @(posedge clock & store_enable ) begin
   memory_write_address <= rs1 + immediate12_store;
end

endmodule

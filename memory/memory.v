`define MEMORY_SIZE 1024
`define HIGH_IMPEDANCE 32'bz

module memory(
   input         clock,
   input         read_enable,
   input  [31:0] read_address,
   output [31:0] read_value,
   input         write_enable,
   input  [31:0] write_address,
   input  [31:0] write_value);

   reg [31:0] mem [`MEMORY_SIZE-1:0];

   always @(posedge clock) begin
      assign read_address = read_enable ? mem[read_address] : `HIGH_IMPEDANCE;
   end
   always @(posedge clock & write_enable) begin
      mem[write_address] = write_value;
   end

endmodule


   

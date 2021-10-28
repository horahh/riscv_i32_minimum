/* 1 KB memory module is enough for now! :) */
`define MEMORY_SIZE 1024
`define HIGH_IMPEDANCE 32'bz

module memory(
   input         clock,
   input         read_enable,
   input  [31:0] read_address,
   output reg [31:0] read_value,
   input         write_enable,
   input  [31:0] write_address,
   input  [31:0] write_value);

   reg [31:0] random_access_memory [`MEMORY_SIZE-1:0];

   always @(posedge clock) begin
      read_value = read_enable ? random_access_memory[read_address] : `HIGH_IMPEDANCE;
   end
   always @(posedge clock & write_enable) begin
      random_access_memory[write_address] = write_value;
   end


   initial
   begin
      $readmemh("asm_to_hex/code.hex",random_access_memory);
      forever @(posedge clock)
         $display("read_enable=%x, read_address=%x, read_value= %x", read_enable, read_address, read_value);
         $display("write_enable=%x, write_address=%x, write_value=%x", write_enable, write_address, write_value);
   end

endmodule


   

/* 1 KB memory module is enough for now! :) */
`define MEMORY_SIZE 1024
`define HIGH_IMPEDANCE 32'bz

module memory(
   input             clock,
   input             read_enable,
   input      [31:0] read_address,
   output reg [31:0] read_value,
   input             write_enable,
   input      [31:0] write_address,
   input      [31:0] write_value
);


   wire [31:0] read_word_address;
   assign      read_word_address = read_address >> 2;
   wire [31:0] write_word_address;
   assign      write_word_address = read_address >> 2;

////////////////////////////////////////////////////////////////////////////////
//      MAIN MEMORY
////////////////////////////////////////////////////////////////////////////////

   reg [31:0]  random_access_memory [0:`MEMORY_SIZE-1];

   always @(posedge clock) begin
      read_value <= read_enable ? random_access_memory[read_word_address] : `HIGH_IMPEDANCE;
   end
   always @(posedge clock & write_enable) begin
      random_access_memory[write_word_address] <= write_value;
   end

   initial
   begin
      $readmemh("asm_to_hex/code.hex",random_access_memory);
   end

endmodule

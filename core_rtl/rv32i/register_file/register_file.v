`define HIGH_IMPEDANCE 32'bz
`define ZERO 32'b0
`define ONE  32'b1

module register_file(
	input             clock,
	input             reset,
	input             register_file_write_enable,
	input      [4:0]  rs1,
	input      [4:0]  rs2,
	input      [4:0]  rd,
	input      [31:0] rd_value,
	output reg [31:0] rs1_value,
	output reg [31:0] rs2_value);

   // register zero here can be written to any value but when read the zero this
   // value is just ignored
	reg    [31:0] registers[0:31];

   // define a register stuck at zero apart from the others
   //reg    register_zero [0:31] = `ZERO;

	always@(posedge clock & register_file_write_enable) begin
      if (rd == 0)
         registers[rd] <= `ZERO;
      else
			registers[rd] <= rd_value;
	end

   always @(posedge clock) begin
      rs1_value <=  registers[rs1] ;
   end

   always @(posedge clock) begin
      rs2_value <= registers[rs2];
   end

endmodule

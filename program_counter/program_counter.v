module program_counter(
   input             clock,
   input      [31:0] instruction,
   output reg [31:0] pc=0);

   reg next_pc =0;

   // implementing logic for the easy case for now
   // TODO: implement logic for control logic
   // i.e. jumps, branches
   always @(posedge clock) begin
      next_pc <= pc + 4;
      pc      <= next_pc;
   end

endmodule

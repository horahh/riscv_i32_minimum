module program_counter(
   input             clock,
   input      [31:0] instruction,
   output     [31:0] pc);

   reg pc = 0;
   reg next_pc;

   // implementing logic for the easy case for now
   // TODO: implement logic for control logic
   // i.e. jumps, branches
   always @(negedge clock) begin
      next_pc = pc + 4;
   end

   always @(posedge clock) begin
      pc = next_pc;
   end

endmodule

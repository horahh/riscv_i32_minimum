module program_counter(
   input              clock,
   input              next_pc_valid,
   input       [31:0] next_pc,
   output  reg [31:0] pc=0);

   // implementing logic for the easy case for now
   // TODO: implement logic for control logic
   // i.e. jumps, branches
   always @(posedge clock) begin
      if (next_pc_enable) begin
         pc <= next_pc;
      end
      else begin
         pc <= pc + 4;
      end
   end

endmodule

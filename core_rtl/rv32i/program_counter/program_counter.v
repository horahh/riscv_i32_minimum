module program_counter(
   input              clock,
   input              control_instruction,
   input       [31:0] next_pc,
   output  reg [31:0] pc);
   always @(posedge clock) begin
      if (control_instruction) begin
         pc <= next_pc;
      end
      else begin
         pc <= pc + 4;
      end
   end

endmodule

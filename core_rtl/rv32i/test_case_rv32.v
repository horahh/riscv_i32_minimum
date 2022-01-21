`timescale 1s/100ms

module test_case_rv32(
   output reg clock,
   output reg enable
);

parameter CLOCK_HALF_PERIOD = 1;

initial 
begin
   $dumpfile("test_case_rv32.vcd");
   $dumpvars();
   /*
   $monitor("clock=%h, pc=%h, instruction=%h, rs1=%h, rs2=%h, rd=%h, rs1_value=%h, rs2_value=%h, rd_value=%h, alu_register_register=%b, opcode=%h, funct7=%h, funct3=%h \n",
      clock, 
      test_bench_rv32.pc, 
      test_bench_rv32.instruction,
      test_bench_rv32.register_file_0.rs1, 
      test_bench_rv32.register_file_0.rs2, 
      //test_bench_rv32.execute_0.register_file_0.register_data_write, 
      test_bench_rv32.register_file_0.rd, 
      //test_bench_rv32.execute_0.register_file_0.rs1,
      test_bench_rv32.execute_0.alu_rv_0.alu_register_register_0.alu_extra_0.rs1_value,
      test_bench_rv32.execute_0.alu_rv_0.alu_register_register_0.alu_extra_0.rs2_value,
      //test_bench_rv32.execute_0.register_file_0.rs2,
      test_bench_rv32.execute_0.alu_rv_0.alu_register_register_0.alu_extra_0.rd_value,
      test_bench_rv32.decode_0.alu_register_register_enable,
      test_bench_rv32.decode_0.opcode,
      test_bench_rv32.execute_0.alu_rv_0.funct7,
      test_bench_rv32.execute_0.alu_rv_0.funct3
   );
   */
   #100 
   $finish;
end

initial 
begin
   clock  = 0;
   enable = 1;
   forever begin
      #CLOCK_HALF_PERIOD clock = !clock;
   end
end

initial 
begin
   $readmemh("bin/default_register_init.hex",
      test_bench_rv32.register_file_0.registers
   );
end

initial 
begin
      $readmemh("bin/code.hex",test_bench_rv32.memory_0.random_access_memory);
end

endmodule

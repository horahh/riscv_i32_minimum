`timescale 1s/100ms

module test_case_rv32(
   output reg clock,
   output reg enable
);

parameter CLOCK_HALF_PERIOD = 1;

initial begin
   $dumpfile("test_case_rv32.vcd");
   $dumpvars();
   $monitor("clock=%h, pc=%h, pc_value=%h, memory_read_address=%h, memory_read_value=%h, read_enable=%h, rs1=%h, rs2=%h, rd=%h, rs1_select=%h, rs2_select=%h, rd_select=%h, register_type_alu=%b, opcode=%h, func7=%h, funct3=%h \n",
      clock, 
      test_bench_rv32.pc, 
      test_bench_rv32.pc_instruction,
      test_bench_rv32.memory_read_address,
      test_bench_rv32.memory_read_value,
      test_bench_rv32.read_enable,
      test_bench_rv32.execute_0.register_file_0.register_data_1, 
      test_bench_rv32.execute_0.register_file_0.register_data_2, 
      //test_bench_rv32.execute_0.register_file_0.register_data_write, 
      test_bench_rv32.execute_0.alu_execute_0.alu_0.alu_base_0.register_data_out, 
      test_bench_rv32.execute_0.register_file_0.rs1,
      test_bench_rv32.execute_0.register_file_0.rs2,
      test_bench_rv32.execute_0.register_file_0.register_write_select,
      test_bench_rv32.decode_0.register_type_alu,
      test_bench_rv32.decode_0.opcode,
      test_bench_rv32.execute_0.alu_execute_0.funct7,
      test_bench_rv32.execute_0.alu_execute_0.funct3
   );
   #100 
   $finish;
end

initial begin
   clock  = 0;
   enable = 1;
   forever begin
      #CLOCK_HALF_PERIOD clock = !clock;
   end
end

initial begin
   $readmemh("default_register_init.hex",
      test_bench_rv32.execute_0.register_file_0.registers
   );
end

endmodule

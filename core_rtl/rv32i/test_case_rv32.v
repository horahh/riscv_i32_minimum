`timescale 1s/100ms

module test_case_rv32(
   output reg clock,
   output reg enable
);

parameter CLOCK_HALF_PERIOD = 1;
parameter CLOCK_PERIOD = 2;

reg [31:0]cycle_counter;

initial 
begin
   $dumpfile("dump_test_case_rv32.vcd");
   $dumpvars();
/*   $monitorh("counter=%4d,pc=%8d,instruction=%8d,x0=%8d,x1=%8d,x2=%8d,x3=%8d,x4=%8d,x5=%8d,x6=%8d,x7=%8d,x8=%8d,x9=%8d,x10=%8d,x11=%8d,x12=%8d,x13=%8d,x14=%8d,x15=%8d,x16=%8d,x17=%8d,x18=%8d,x18=%8d,x19=%8d,x20=%8d,x21=%8d,x22=%8d,x23=%8d,x24=%8d,x25=%8d,x26=%8d,x27=%8d,x28=%8d,x29=%8d,x30=%8d,x31=%8d", 
      test_bench_rv32.pc,
      test_bench_rv32.instruction,
      test_bench_rv32.register_file_0.registers[0],
      test_bench_rv32.register_file_0.registers[1],
      test_bench_rv32.register_file_0.registers[2],
      test_bench_rv32.register_file_0.registers[3],
      test_bench_rv32.register_file_0.registers[4],
      test_bench_rv32.register_file_0.registers[5],
      test_bench_rv32.register_file_0.registers[6],
      test_bench_rv32.register_file_0.registers[7],
      test_bench_rv32.register_file_0.registers[8],
      test_bench_rv32.register_file_0.registers[9],
      test_bench_rv32.register_file_0.registers[10],
      test_bench_rv32.register_file_0.registers[11],
      test_bench_rv32.register_file_0.registers[12],
      test_bench_rv32.register_file_0.registers[13],
      test_bench_rv32.register_file_0.registers[14],
      test_bench_rv32.register_file_0.registers[15],
      test_bench_rv32.register_file_0.registers[16],
      test_bench_rv32.register_file_0.registers[17],
      test_bench_rv32.register_file_0.registers[18],
      test_bench_rv32.register_file_0.registers[19],
      test_bench_rv32.register_file_0.registers[20],
      test_bench_rv32.register_file_0.registers[21],
      test_bench_rv32.register_file_0.registers[22],
      test_bench_rv32.register_file_0.registers[23],
      test_bench_rv32.register_file_0.registers[24],
      test_bench_rv32.register_file_0.registers[25],
      test_bench_rv32.register_file_0.registers[26],
      test_bench_rv32.register_file_0.registers[27],
      test_bench_rv32.register_file_0.registers[28],
      test_bench_rv32.register_file_0.registers[29],
      test_bench_rv32.register_file_0.registers[30],
      test_bench_rv32.register_file_0.registers[31]
   );
   */
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
   #100 
   $finish;
end


initial 
begin
   clock  = 0;
   enable = 1;
   cycle_counter = 0;
   forever begin
      #CLOCK_PERIOD cycle_counter += 1;
   end

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

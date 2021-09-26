all:
	iverilog -o alu_riscv32i.out test_bench_alu.v test_alu.v alu_base.v alu_extra.v alu_select.v alu.v 
	vvp -v -l alu.log alu_riscv32i.out  > alu_riscv32i.vcd
	#gtkwave alu_riscv32i.vcd &

alu:
	iverilog -o alu_riscv32i.out test_bench_alu.v test_alu.v alu_base.v alu_extra.v alu_select.v alu.v 
	vvp -v -l alu.log alu_riscv32i.out  > alu_riscv32i.vcd
	#gtkwave alu_riscv32i.vcd &

alu_base:
	iverilog -o alu_base_riscv32i.out test_bench_alu_base.v test_alu_base.v alu_base.v 
	vvp -v -l alu_base.log alu_base_riscv32i.out  > alu_base_riscv32i.vcd
	#gtkwave alu_base_riscv32i.vcd &

clean:
	rm -f *.out; rm -f *.vcd; rm -f *.lxt2; rm -f *.log

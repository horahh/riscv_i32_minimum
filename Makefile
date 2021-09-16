all:
	iverilog -o riscv32i.out test_bench_register_file.v register_file.v test_register_file.v 
	#alu_base.v alu_extra.v alu_select.v alu.v 
	vvp -v -l all.log riscv32i.out  > riscv32i.vcd
	gtkwave riscv32i.vcd &

alu:
	iverilog -o alu_riscv32i.out test_bench_alu.v test_alu.v alu_base.v alu_extra.v alu_select.v alu.v 
	vvp -v -l alu.log alu_riscv32i.out  > alu_riscv32i.vcd
	gtkwave alu_riscv32i.vcd &

alu_base:
	iverilog -o alu_base_riscv32i.out test_bench_alu_base.v test_alu_base.v alu_base.v 
	vvp -v -l alu_base.log alu_base_riscv32i.out  > alu_base_riscv32i.vcd
	gtkwave alu_base_riscv32i.vcd &

register_file:
	iverilog -o register_file_riscv32i.out test_bench_register_file.v register_file.v test_register_file.v 
	vvp -v -l register_file.log register_file_riscv32i.out  > test_register_file_riscv32i.vcd
	gtkwave test_register_file_riscv32i.vcd &

clean:
	rm -f *.out; rm -f *.vcd; rm -f *.ltx2; rm -f *.log

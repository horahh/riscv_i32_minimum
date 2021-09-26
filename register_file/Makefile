all:
	iverilog -o register_file_riscv32i.out test_bench_register_file.v register_file.v test_register_file.v 
	vvp -v -l register_file.log register_file_riscv32i.out  > test_register_file_riscv32i.vcd
	gtkwave test_register_file_riscv32i.vcd &

register_file:
	iverilog -o register_file_riscv32i.out test_bench_register_file.v register_file.v test_register_file.v 
	vvp -v -l register_file.log register_file_riscv32i.out  > test_register_file_riscv32i.vcd
	gtkwave test_register_file_riscv32i.vcd &

clean:
	rm -f *.out; rm -f *.vcd; rm -f *.lxt2; rm -f *.log

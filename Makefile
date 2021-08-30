all:
	iverilog -o riscv32i.out test_bench.v register_file.v test_register_file.v
	vvp riscv32i.out  > riscv32i.vcd
	gtkwave riscv32i.vcd &

clean:
	rm -f *.out; rm -f *.vcd; rm -f *.ltx2

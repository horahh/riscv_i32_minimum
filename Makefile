all:
	iverilog -o riscv32i.out test_bench.v register_file.v

clean:
	rm -f *.out

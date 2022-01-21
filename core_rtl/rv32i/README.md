# Make Targets
There are currently 4 supported targets for compilation:

* all: (DEFAULT) Refers to a compilation of verilog IP_BLOCK (see IP_BLOCK HELP)

* sim: Opens a gtkwave instance to explore the simulation signals graphically

* clean: Cleans up the whole directory tree of compilation objects.

** bin: Creates a translation from the asm to the hex file to be loaded into memory by the RTL simulation
Simulation expects a 4K word memory (4096 bytes)

** test: Test the compiler from ASM to HEX covertion for different instructions supported

** tags: Creates a tags file to easily browse python code.

# IP_BLOCK_HELP  
* IP_BLOCK refers to the ip desired to be compiled/simulated.

* By default refers to the whole system (current directory) 

* Each directory is supposed to have a self contained ip with
 test bench, a test and connections for all its inner ips.

* The directories are recursive so that each ip can have 
 another ip inside with the same requirements as test bench, 
 a test and connections for its inner ips.

* IP_BLOCK variable can be changed to the directory of the IP that is needed to 
be compiled/simulated provided that has all dependencies of the makefile which 
are: 

```
 test_bench_*.v 
 test_case_*.v 
 <ip_block_0>.v <ip_block_1>.v <ip_block_2>.v ... 
 <inner_ip_directory0> <inner_ip_directory1> <inner_ip_directory2> ...
```

* IP_BLOCK can be overwritten by the ip_block directory path i.e. alu, 
register_file, alu/alu_base, etc 

* This applies in order to compile/simmulate a specific block only

## EXAMPLES:

### COMPILE IP_BLOCK 
```
  Compile a specific Project IP 

 $ make IP_BLOCK=core_rtl/rv32i/alu/alu_base
	core_rtl/rv32i/alu/alu_base/alu_base.v
	alu_base
	iverilog -o core_rtl/rv32i/alu/alu_base/alu_base.out core_rtl/rv32i/alu/alu_base/test_bench_alu_base.v core_rtl/rv32i/alu/alu_base/test_case_alu_base.v core_rtl/rv32i/alu/alu_base/alu_base.v
	vvp -v -l core_rtl/rv32i/alu/alu_base/alu_base.log core_rtl/rv32i/alu/alu_base/alu_base.out > alu_base.vcd
	... Linking
	... Removing symbol tables
	... Compiletf functions
```

### CLEAN PROJECT SPECIFIC IP
```
  Clean specific Project IP

	$ make clean IP_BLOCK=core_rtl/rv32i/alu/alu_base
	rm -f core_rtl/rv32i/alu/alu_base/*.out; rm -f core_rtl/rv32i/alu/alu_base/*.vcd; rm -f core_rtl/rv32i/alu/alu_base/*.lxt2; rm -f core_rtl/rv32i/alu/alu_base/*.log
```

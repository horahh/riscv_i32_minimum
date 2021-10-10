################################################################################
##################### SOURCE FILES #############################################
################################################################################
# assign a multiline variable for help
# https://stackoverflow.com/questions/649246/is-it-possible-to-create-a-multi-line-string-variable-in-a-makefile 
define IP_BLOCK_HELP  
 IP_BLOCK refers to the ip desired to be compiled/simulated 
 By default refers to the whole system (current directory) 

 Each directory is supposed to have a self contained ip with
 test bench, a test and connections for all its inner ips.

 The directories are recursive so that each ip can have 
 another ip inside with the same requirements as test bench, 
 a test and connections for its inner ips.

 IP_BLOCK can be changed to the directory of the IP that is 
 wanted to be compiled/simulated provided that has all 
 dependencies of the makefile which are: 
 test_bench_*.v 
 test_case_*.v 
 <ip_block_0>.v <ip_block_1>.v <ip_block_2>.v ... 
 <inner_ip_directory0> <inner_ip_directory1> <inner_ip_directory2> ...

 IP_BLOCK can be overwritten by the ip_block directory path i.e. alu, 
 register_file, alu/alu_base, etc 

 This applies in order to compile/simmulate a specific block only "
endef

# Execute the project from the root as base
IP_BLOCK            = "."
# search for all verilog files 
# exclude the test files from the list
SYSTEM_SOURCE_FILES = $(shell find $(IP_BLOCK)/ -type f \( -name '*.v' ! -name '*test*' \))
TEST_BENCH_FILE     = $(wildcard $(IP_BLOCK)/test_bench_*.v)
TEST_CASE_FILE      = $(wildcard $(IP_BLOCK)/test_case_*.v)

################################################################################
#################### VERILOG COMPILER ##########################################
################################################################################
VERILOG_COMPILER    = iverilog
VERILOG_FLAGS       = -o
VERILOG_OUTPUT      = riscv32i.out

VCD_GENERATION      = vvp
VCD_FLAGS           = -v -l
VCD_OUTPUT          = riscv32i.vcd

### TODO: substitute for proper current ip from test_bench file name
CURRENT_IP_BLOCK    = riscv32i
VCD_LOG             = $(CURRENT_IP_BLOCK).log
VCD_WAVE            = $(TEST_CASE_FILE)cd

WAVE_GENERATION     = gtkwave

# Get the current dir path to pick the corresponding test files
MAKEFILE_PATH = $(abspath $(lastword $(MAKEFILE_LIST)))
CURRENT_DIR = $(notdir $(patsubst %/,%,$(dir $(MAKEFILE_PATH))))

################################################################################
#################### COMPILATION AND SIMULATION TARGETS ########################
################################################################################
all:
	@echo $(SYSTEM_SOURCE_FILES)
	$(VERILOG_COMPILER) $(VERILOG_FLAGS) $(VERILOG_OUTPUT) $(TEST_BENCH_FILE) $(TEST_CASE_FILE) $(SYSTEM_SOURCE_FILES)
	$(VCD_GENERATION) $(VCD_FLAGS) $(VCD_LOG) $(VERILOG_OUTPUT) > $(VCD_OUTPUT)

sim:
	$(WAVE_GENERATION) $(VCD_WAVE) &

help:
	$(info $(IP_BLOCK_HELP))

clean:
	rm -f *.out; rm -f *.vcd; rm -f *.lxt2; rm -f *.log

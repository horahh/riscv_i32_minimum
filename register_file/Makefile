################################################################################
##################### SOURCE FILES #############################################
################################################################################
# search for all verilog files 
# exclude the test files from the list
SYSTEM_SOURCE_FILES = $(shell find ./ -type f \( -name '*.v' ! -name '*test*' \))
TEST_BENCH_FILE     = $(wildcard test_bench_*.v)
TEST_CASE_FILE      = $(wildcard test_case_*.v)

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

# reference: 
# Get the current dir path to pick the corresponding test files
MAKEFILE_PATH = $(abspath $(lastword $(MAKEFILE_LIST)))
CURRENT_DIR = $(notdir $(patsubst %/,%,$(dir $(MAKEFILE_PATH))))

################################################################################
#################### COMPILATION AND SIMULATION TARGETS ########################
################################################################################
all:
	$(VERILOG_COMPILER) $(VERILOG_FLAGS) $(VERILOG_OUTPUT) $(TEST_BENCH_FILE) $(TEST_CASE_FILE) $(SYSTEM_SOURCE_FILES)
	$(VCD_GENERATION) $(VCD_FLAGS) $(VCD_LOG) $(VERILOG_OUTPUT) > $(VCD_OUTPUT)

sim:
	$(WAVE_GENERATION) $(VCD_WAVE) &

clean:
	rm -f *.out; rm -f *.vcd; rm -f *.lxt2; rm -f *.log

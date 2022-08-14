################################################################################
#################### VERILOG_FILES     ##########################################
################################################################################
# Execute the project from the root of the rv32i as base 
IP_BLOCK             = core_rtl/rv32i
# search for all verilog files 
# exclude the test files from the list
VERILOG_FILES  = $(shell find $(IP_BLOCK)/ -type f \( -name '*.v' ! -name '*test*' \))
TEST_BENCH_FILE      = $(wildcard $(IP_BLOCK)/test_bench_*.v)
TEST_CASE_FILE       = $(wildcard $(IP_BLOCK)/test_case_*.v)

# saved simulation file to keep interesting signals
SAVED_SIMULATION = debug_opcode_transition.sav

################################################################################
#################### IP_NAME          ##########################################
################################################################################
README               = README.md
RV32I_README         = $(IP_BLOCK)/$(README)


################################################################################
#################### IP_NAME          ##########################################
################################################################################
# Extracting the IP_NAME from the test bench file
# THE TEST_BENCH FILE is in the form of test_bench_<IP_NAME>.v
TEST_BENCH_FILE_BASE = $(basename $(notdir $(TEST_BENCH_FILE)))
IP_NAME              = $(subst test_bench_,,$(TEST_BENCH_FILE_BASE))
VCD_LOG              = $(IP_BLOCK)/$(IP_NAME).log

################################################################################
#################### VERILOG COMPILER ##########################################
################################################################################
VERILOG_COMPILER     = iverilog
VERILOG_FLAGS        = -o
VERILOG_OUTPUT       = $(IP_BLOCK)/$(IP_NAME).out
VERILOG_TARGET       = $(VERILOG_COMPILER) $(VERILOG_FLAGS) $(VERILOG_OUTPUT) $(TEST_BENCH_FILE) $(TEST_CASE_FILE) $(VERILOG_FILES)

VCD_GENERATION       = vvp
VCD_FLAGS            = -v -l
VCD_OUTPUT           = $(IP_BLOCK)/$(IP_NAME).vcd
TEST_CASE            = "test_case_"
#VCD_GTKWAVE          = $(IP_BLOCK)/$(TEST_CASE)$(IP_NAME).vcd
# simulation file gets dump in the root dir from the bench itself
VCD_GTKWAVE          = $(TEST_CASE)$(IP_NAME).vcd

WAVE_GENERATION_TOOL = gtkwave

# Get the current dir path to pick the corresponding test files
MAKEFILE_PATH = $(abspath $(lastword $(MAKEFILE_LIST)))
CURRENT_DIR = $(notdir $(patsubst %/,%,$(dir $(MAKEFILE_PATH))))

################################################################################
#################### OBJECT AND OUTPUT FILES ###################################
################################################################################
OUTPUT_FILES  = $(shell find $(IP_BLOCK)/ -type f \( -name '*.vcd' -o -name '*.out' -o -name '*.lxt2' -o -name '*.log' \))

################################################################################
#################### COMPILE ASM ###############################################
################################################################################
ASM_FILE     = asm/code.asm
BIN_FILE     = bin/code.hex
CONFIG_FILE  = compiler/configuration/rv32i_instructions.toml
ASM_ARG      = --asm $(ASM_FILE)
BIN_ARG      = --bin $(BIN_FILE)
CONFIG_ARG   = --toml $(CONFIG_FILE)
ASM_COMPILER = python compiler/compiler.py
ASM_TARGET   = $(ASM_COMPILER) $(ASM_ARG) $(BIN_ARG) $(CONFIG_ARG) 

################################################################################
#################### EMULATION TARGET #########################################
################################################################################
EMULATOR          = python emulator/emulator.py

################################################################################
#################### SIMULATION AND SIMULATION TARGETS  ########################
################################################################################

.PHONY: all sim bin rtl simulation test tags help clean

all:
	@echo "COMPILING IP: " $(IP_NAME)

	make bin
	make rtl 
	make simulation
	#make test

rtl:
	@echo "COMPILING VERILOG RTL..."
	$(VERILOG_TARGET)
	@echo "COMPILING VERILOG RTL... DONE"

simulation:
	@echo "GENERATING SIMULATION OUTPUT FILE..."
	$(VCD_GENERATION) $(VCD_FLAGS) $(VCD_LOG) $(VERILOG_OUTPUT) > $(VCD_OUTPUT)
	@echo "GENERATING SIMULATION OUTPUT FILE... DONE"

sim:
	$(WAVE_GENERATION_TOOL) $(VCD_GTKWAVE) $(SAVED_SIMULATION) &

bin:
	@echo "COMPILING ASM TO BIN..."
	$(ASM_TARGET)
	@echo "COMPILING ASM TO BIN... DONE"

emulation:
	@echo "START EMULATION..."
	$(EMULATOR)
	@echo "END EMULATION..."

test:
	pytest -vv

# Create tags to browse code symbols for compiler
tags:
	ctags -R */*.py

help:
	cat $(RV32I_README)

clean:
	@echo $(OUTPUT_FILES)
	rm -f $(OUTPUT_FILES)

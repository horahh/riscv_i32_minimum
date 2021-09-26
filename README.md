# riscv_i32_minimum
Didactic implementation of a riscv processor

## ALU

ALU is created modularly based on FUCT7 code from RISCV32I specification

Look for Alu folder for more info.

## REGISTER_FILE

Register File is implemented according with RISC32I specification, meaning 32 general purpose registers (0-31)

Exception is that Register0 is special as its return value will always be zero

See register file folder for more info.

# MEMORY
Module that holds the current memory model to fech from and write to.

# Program Counter (PC)

Module that holds the logic to appropriately increment (or change) the PC register

# FETCH DECODE EXECUTE WRITEBACK

WIP, currently implemented but not integrated nor tested 


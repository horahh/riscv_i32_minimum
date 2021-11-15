# CLEAN RISCV 
Didactic implementation of a riscv processor.

This project started as a way to understand the basics of RISC-V arquitecture implementation,
the goal is to create a functional processor meeting the minimum specification for RISCV (RISCV32I)
while implementing it in a very clean and didactical way trying to make it easy to understand.


## Apply clean code principles to HW design

While these principles were though thinking on SW, as an extra excersice is being done trying to extrapolate
and understand what would clean hardware design is, these are the principles taking into account:

* Modularity, no worries to split functionality into multiple modules.
* Simplicity, dont overdesign (for performance)
* Single Responsibility,having a module doing just one thing.
* Try to connect minimum quantity of signals or busses.
* Abstract the riscv specification from the microarquitecture direct implementation.
* Take advantage of the RISC simplicity to map to blocks (like a specific ALU based on FUNCT7 decodes)
   * But this point makes a direct implementation of the riscv but is not explicit.
   * Take advantage for later having a straighforward connection of modules.
* Have a connection layer from the RISCV arquitecture definition of the instruction inputs to the actual implementation

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

# FETCH 
Loads the next instruction data and pass it to the decode unit.
Will need to load memory as well for Load type operations (once implemented)

# DECODE 
Decodes the instruction into specific single bit enables to set the corresponding unit to execute.

# EXECUTE 
Instantiates the ALU and Register File units and pass to the the enable signals from decode.
Currently just having implemented Register and Immediate ALU operations.

# WRITEBACK
Implemented but not used. For Store type instruction to write into memory.

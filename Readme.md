# CLEAN RISCV 

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

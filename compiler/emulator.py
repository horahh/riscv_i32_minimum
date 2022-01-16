import argparse

import instruction

if __name__ == "__main__":
    main()


def get_args():
    parser = argparse.ArgumentParser(description="ASM to Binary RV32I Translator")
    parser.add_argument(
        "--asm",
        type=str,
        default="../asm/code.asm",
        help="Provide the asm to translate to binary",
    )
    parser.add_argument(
        "--bin",
        type=str,
        default="../bin/code.hex",
        help="Provide the bin file to dump the binary translation of the provided asm",
    )
    parser.add_argument(
        "--register_file",
        type=str,
        default="../default_register_init.hex",
        help="Provide the hex file to set the initial register file state",
    )
    args = parser.parse_args()
    return args


def main():
    args = get_args()
    instructions = [instruction.Instruction(asm) for asm in args.asm]
    systemEmulator = SystemEmulator(args.register_file, args.hex)
    emulator = Emulator(instructions, systemEmulator)


class Emulator:
    """
    Class Emulator is responsible of emulating ASM results.
    Holds a memory model and a register model that should
    match the HW model.
    """

    def __init__(self, instructions, systemEmulator):
        self.instructions = instructions
        self.systemEmulator = systemEmulator

    def run(self):
        for instruction in self.instructions:
            self.systemEmulator.execute(instruction)


class SystemEmulator:
    """
    Class to emulate system behaviour executing giving instructions and altering the system state for registers and memory.
    """

    def __init__(self, registers, memory):
        self.registers = registers
        self.memory = memory

    def execute(self, instruction):
        instruction_name = instruction.get_token(0)
        instructionMethod = getattr(self, instruction_name)

    def dump(self):
        """
        Method to dump state of the system at any point in order to verify against HW state.
        """
        pass

    def add(self, instruction):
        rs1 = instruction.get_token(2)
        rs2 = instruction.get_token(3)
        rd = instruction.get_token(1)
        registers[rd] = registers[rs1] + registers[rs2]


class Memory:
    """
    Class to emulate memory.
    Load memory verilog compatible hex file having 32 bit values
    """

    def __init__(self, memory_file):
        self.memory = []
        for line in file_read(register_init_file):
            self.memory.append(index)

    def __getitem__(self, index):
        """
        Adding flexibility to support instruction tokens directly for the code to be more succint.
        """
        if index[0] == "r":
            index = index[1:]
        index = int(index)
        return self.memory[index]

    def __iter__(self):
        for register in self.registers:
            yield register


class Registers(Memory):
    """
    Memory to map system registers and their values.
    Initialize registers with same values as RTL
    """

    def __init__(self, register_init_file):
        self.__super__.init(register_init_file)
        registers = self.memory
        if len(registers) != 32:
            raise ("Invalid register file len [{}], expected 32".format(len(registers)))


def file_read(file_name):
    with open(file_name, "r") as file_lines:
        for line in file_lines:
            yield line

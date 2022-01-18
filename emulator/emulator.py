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
        help="Provide the asm to translate to binary.",
    )
    parser.add_argument(
        "--memory",
        type=str,
        default="../bin/code.hex",
        help="Provide the hex file to load as initial memory into the emulation model.",
    )
    parser.add_argument(
        "--register",
        type=str,
        default="../default_register_init.hex",
        help="Provide the hex file to set the initial register file state.",
    )
    args = parser.parse_args()
    return args


def main():
    args = get_args()
    emulatorFactory = EmulatorFactory(args.register, args.memory, args.asm)
    emulator = emulatorFactory.create()
    emulator.run()
    # Need to compare results against a reference
    emulator.get_results()


class EmulatorFactory:
    def __init__(self, register_init_file, memory_init_file, asm_init_file):
        self.register_init_file = register_init_file
        self.memory_init_file = memory_init_file
        self.asm_init_file = asm_init_file

    def create_register_file(self):
        register_generator = file_read(self.register_init_file)
        register_file = Register(register_generator)
        return register_file

    def create_memory(self):
        memory_generator = file_read(self.memory_init_file)
        memory = Memory(memory_generator)
        return memory

    def create_systemEmulator(self, register_file, memory):
        systemEmulator = SystemEmulator(register_file, memory)
        return systemEmulator

    def create_instructions(self):
        asm_generator = file_read(self.asm_init_file)
        instructions = [instruction.Instruction(asm) for asm in asm_generator]
        return instructions

    def create(self):
        register_file = self.create_register_file()
        memory = self.create_memory()
        systemEmulator = create_systemEmulator(register_file, memory)
        instructions = self.create_instructions()
        emulator = Emulator(instructions, systemEmulator)
        return emulator


class Emulator:
    """
    Class Emulator is responsible of emulating ASM results.
    Holds a memory model and a register model that should
    match the HW model.
    """

    def __init__(self, instructions, systemEmulator):
        self.instructions = instructions
        self.systemEmulator = systemEmulator
        self.results = []

    def run(self):
        for instruction in self.instructions:
            self.systemEmulator.execute(instruction)
            results.append(self.systemEmulator.dump())

    def get_results(self):
        return results


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
        register_dump = [register for register in self.registers]
        return register_dump

    def add(self, instruction):
        rs1 = instruction.get_token(2)
        rs2 = instruction.get_token(3)
        rd = instruction.get_token(1)
        if rd == "r0":
            return
        registers[rd] = registers[rs1] + registers[rs2]


class Memory:
    """
    Class to emulate memory.
    Load memory verilog compatible hex file having 32 bit values
    """

    def __init__(self, memory_data):
        self.memory = []
        for line in memory_data:
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

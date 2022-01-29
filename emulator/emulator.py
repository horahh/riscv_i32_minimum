import argparse
import csv
import sys

sys.path.append("compiler")

import instruction


def get_args():
    parser = argparse.ArgumentParser(description="ASM to Binary RV32I Translator")
    parser.add_argument(
        "--asm",
        type=str,
        default="asm/code.asm",
        help="Provide the asm to translate to binary.",
    )
    parser.add_argument(
        "--memory",
        type=str,
        default="bin/code.hex",
        help="Provide the hex file to load as initial memory into the emulation model.",
    )
    parser.add_argument(
        "--register",
        type=str,
        default="bin/default_register_init.hex",
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
    r = emulator.get_results()
    # print(r)
    emulator.write_csv()


class EmulatorFactory:
    def __init__(self, register_init_file, memory_init_file, asm_init_file):
        self.register_init_file = register_init_file
        self.memory_init_file = memory_init_file
        self.asm_init_file = asm_init_file

    def create_register_file(self):
        register_generator = file_read(self.register_init_file)
        register_file = Registers(register_generator)
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
        systemEmulator = self.create_systemEmulator(register_file, memory)
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
            register_state = self.systemEmulator.dump()
            self.results.append(register_state)

    def get_results(self):
        return self.results

    def write_csv(self):
        emulation_output = "emulation_state.csv"
        with open(emulation_output, "w") as csvfile:
            fieldnames = [f"r{reg}" for reg in range(len(self.results[0]) + 1)]
            csv_writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
            csv_writer.writeheader()
            for result in self.results:
                csv_writer.writerow(result)


class SystemEmulator:
    """
    Class to emulate system behaviour executing giving instructions and altering the system state for registers and memory.
    """

    def __init__(self, registers, memory):
        self.registers = registers
        self.memory = memory

    def execute(self, instruction):
        instruction_name = instruction.get_token(0)
        instructionMethod = self.get_attribute(instruction_name)
        instructionMethod(instruction)

    def get_attribute(self, instruction_name):
        if not hasattr(self, instruction_name):
            return self.stub
        instructionMethod = getattr(self, instruction_name)
        return instructionMethod

    def dump(self):
        """
        Method to dump state of the system at any point in order to verify against HW state.
        """
        register_name = lambda index: f"r{index}"
        register_dump = {
            register_name(index): register
            for index, register in enumerate(self.registers)
        }
        return register_dump

    def stub(self, instruction):
        """
        Do nothing for the unknown instructions for now, just to avoid chrashing
        """
        pass

    def add(self, instruction):
        rs1 = instruction.get_token(2)
        rs2 = instruction.get_token(3)
        rd = instruction.get_token(1)
        if rd == "r0":
            return
        self.registers[rd] = self.registers[rs1] + self.registers[rs2]


class Memory:
    """
    Class to emulate memory.
    Load memory verilog compatible hex file having 32 bit values
    """

    def __init__(self, memory_data):
        self.memory = []
        for hex_word in memory_data:
            int_word = int(hex_word, 16)
            self.memory.append(int_word)
        # print(self.memory)

    def __getitem__(self, index):
        """
        Adding flexibility to support instruction tokens directly for the code to be more succint.
        """
        if index[0] == "r":
            index = index[1:]
        index = int(index)
        return self.memory[index]

    def __setitem__(self, index, value):
        if index[0] == "r":
            index = index[1:]
        index = int(index)
        self.memory[index] = value

    def __iter__(self):
        for element in self.memory:
            yield element


class Registers(Memory):
    """
    Memory to map system registers and their values.
    Initialize registers with same values as RTL
    """

    def __init__(self, register_init_file):
        super().__init__(register_init_file)
        registers = self.memory
        if len(registers) != 32:
            raise ("Invalid register file len [{}], expected 32".format(len(registers)))


def file_read(file_name):
    with open(file_name, "r") as file_lines:
        for line in file_lines:
            yield line.strip()


if __name__ == "__main__":
    main()

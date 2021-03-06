import argparse

import instruction_set
import instruction_descriptor
from instruction import Instruction


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
        "--toml",
        type=str,
        default="../compiler/configuration/rv32i_instructions.toml",
        help="Provide the toml file with the instruction types and field descriptions",
    )
    args = parser.parse_args()
    return args


def get_asm_instructions(source_name):
    with open(source_name, "r") as source_file:
        instructions = source_file.readlines()
    return instructions


def asm_to_hex(asm_instructions, isa):
    hex_instructions = []
    descriptor = instruction_descriptor.InstructionDescriptor(isa)
    for asm_instruction in asm_instructions:
        instruction = Instruction(asm_instruction, descriptor)
        hex_instruction = instruction.get_value_hex()
        hex_instructions.append(hex_instruction)
    return hex_instructions


def write_output(instructions, filename):
    with open(filename, "w") as filehandle:
        for instruction in instructions:
            filehandle.write(f"{instruction}\n")


def asm_to_binary(args):
    isa = instruction_set.InstructionSet(args.toml)
    asm_instructions = get_asm_instructions(args.asm)
    int_instructions = asm_to_hex(asm_instructions, isa)
    write_output(int_instructions, args.bin)


def main():
    args = get_args()
    asm_to_binary(args)


if __name__ == "__main__":
    main()

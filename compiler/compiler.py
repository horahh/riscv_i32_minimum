import argparse
import instruction_set
import instruction_descriptor
import instruction

def get_args():
    parser = argparse.ArgumentParser(description="ASM to Binary RV32I Translator")
    parser.add_argument("--asm",type=str, default="../asm/code.asm",help="Provide the asm to translate to binary")
    parser.add_argument("--bin",type=str, default="../bin/code.hex", help="Provide the bin file to dump the binary translation of the provided asm")
    parser.add_argument("--toml",type=str, default="rv32i_instructions.toml", help="Provide the toml file with the instruction types and field descriptions")
    args=parser.parse_args()
    return args

def get_asm_instructions(source_name):
    with open(source_name,'r') as source_file:
        instructions = source_file.readlines()
    return instructions

def asm_to_hex(asm_instructions,isa):
    hex_instructions = [] 
    descriptor = InstructionDescriptor(isa)
    for asm_instruction in asm_instructions:
        instruction = Instruction(asm_instruction,descriptor)
        hex_instruction = instruction.get_value_hex()
        hex_instructions.append(hex_instruction)
    return hex_instructions


def asm_to_binary( asm_file, bin_file, toml_file):
    isa = instruction_set.InstructionSet(toml_file)
    asm_instructions = get_asm_instructions(asm_file)
    int_instructions = asm_to_hex(asm_instructions, isa)

def main():
    args = get_args()
    asm_to_binary(args.asm, args.bin, args.toml)

if __name__ == "__main__":
    main()

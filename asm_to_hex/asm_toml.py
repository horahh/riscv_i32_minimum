import argparse
import toml
import asm_field_decode as afd

def get_instruction_decoder(instruction_descriptor):
    """
    Extract the type of instruction from the TOML description
    """
    instruction_type = {}
    #print(instruction_descriptor)
    for (itype,instructions_metadata) in instruction_descriptor["RV32I"].items():
        print(instructions_metadata)
        for (instruction_subtype, instruction_list) in instructions_metadata["INSTRUCTIONS"].items():
            print(instruction_subtype)
            for instruction in instruction_list:
                instruction_type[instruction] = itype;
    return instruction_type

def get_instruction_field_description(asm_toml):
    rv32i_intructions_description = asm_toml 

    with open(rv32i_intructions_description) as instructions_description_file:
        file_lines = instructions_description_file.readlines()
        toml_string = "\n".join(file_lines)
        instruction_field_description_toml = toml.loads(toml_string)
    return instruction_field_description_toml
#print(parsed_toml["RV32I"]["RTYPE"]["INSTRUCTION_FIELDS"])

def identify_type(token, instruction_fields):
    """
    Function to map the type of the instruction to to specific instruction token
    """
    instruction_type = get_instruction_decoder(instruction_fields)
    return instruction_type[token]

def instruction_field_update(instruction_type, tokens, instruction_description):
    #TODO need to create a copy instead of modify original
    for (field_name, field_meta) in instruction_description["RV32I"][instruction_type]["INSTRUCTION_FIELDS"].items():
        if field_name == "opcode":
            continue
        function_name = "get_" + field_name
        token_number = field_meta["token"]
        field_function = getattr(afd,function_name)
        field_value = field_function(tokens[token_number])
        field_meta["value"] = field_value

def instruction_decode(instruction_type, instruction_description):
    instruction = 0
    for (field_name, field_meta) in instruction_description["RV32I"][instruction_type]["INSTRUCTION_FIELDS"].items():
        field_value = field_meta["value"] & (2**field_meta["bits"]-1)
        instruction |= field_value << field_meta["offset"]
    return instruction

def parse_instruction(instruction,  instruction_description):
    tokens = afd.get_instruction_tokens(instruction)
    if not tokens:
        exit(1)
    #print(instruction)
    #print(tokens)
    #print(tokens[0])
    instruction_type = identify_type(tokens[0], instruction_description)
    instruction_field_update(instruction_type, tokens, instruction_description)
    return instruction_type

def get_asm_instructions(source_name):
    with open(source_name,'r') as source_file:
        instructions = source_file.readlines()
    return instructions

def asm_to_hex(asm_instructions, instructions_description):
    hex_instructions = []
    for instruction in asm_instructions:
        #print(f"Parsing: {instruction}")
        instruction_type = parse_instruction(instruction, instructions_description)
        hex_instruction_decode = instruction_decode(instruction_type, instructions_description)
        hex_instructions.append(hex_instruction_decode)
    return hex_instructions

def write_hex_file(destination_name, hex_instructions):
    with open(destination_name, 'w') as destination_file:
        for hex_instruction in hex_instructions:
            #print("writing {}".format(hex_instruction))
            destination_file.write(hex_instruction)
            destination_file.write("\n")

def asm_to_binary(source_file, destination_file, instructions_description):
    asm_instructions = get_asm_instructions(source_file)
    #print(asm_instructions)
    int_instructions = asm_to_hex(asm_instructions, instructions_description)
    hex_instructions = afd.int_to_32bit_hex_instructions(int_instructions)

    #print(hex_instructions)
    write_hex_file(destination_file, hex_instructions)

def get_args():
    parser = argparse.ArgumentParser(description="ASM to Binary RV32I Translator")
    parser.add_argument("--asm",type=str, default="code.asm",help="Provide the asm to translate to binary")
    parser.add_argument("--bin",type=str, default="code.hex", help="Provide the bin file to dump the binary translation of the provided asm")
    parser.add_argument("--toml",type=str, default="rv32i_instructions.toml", help="Provide the toml file with the instruction types and field descriptions")
    args=parser.parse_args()
    return args

def main():
    args = get_args()
    instructions_description = get_instruction_field_description(args.toml)
    asm_to_binary(args.asm, args.bin, instructions_description)

if __name__ == "__main__":
    main()

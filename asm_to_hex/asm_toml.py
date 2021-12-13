import argparse
import toml
import asm_field_decode 

def get_instruction_decoder(instruction_descriptor):
    """
    Extract the type of instruction from the TOML description
    """
    instruction_type = {}
    #print(instruction_descriptor)
    for (itype,instructions_metadata) in instruction_descriptor["RV32I"]["TYPE"].items():
        #print(instructions_metadata)
        for (instruction_subtype, instruction_list) in instructions_metadata["INSTRUCTIONS"].items():
            #print(instruction_subtype)
            for instruction in instruction_list:
                instruction_type[instruction] = {"type": itype, "subtype": instruction_subtype }
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
    instruction_decoder = get_instruction_decoder(instruction_fields)
    return instruction_decoder[token]

def get_token_number(token, subtype):
    if isinstance(token, dict):
        return token[subtype]
    return token

def instruction_field_override(instruction_type, tokens, instruction_description, generic_instruction_decode):
    """
    updates the field of the provided intruction to build the 32bit value
    """
    specific_instruction_decode = generic_instruction_decode
    fields = instruction_description["RV32I"]["FIELDS"]
    #TODO need to create a copy instead of modify original
    for field_name in instruction_description["RV32I"]["TYPE"][instruction_type["type"]]["INSTRUCTION_FIELDS"]["fields"]:
        if field_name == "opcode":
            continue
        function_name = "get_" + field_name
        print("field name: {}".format(field_name))
        token_number = get_token_number(fields[field_name]["token"],instruction_type["subtype"])
        field_function = getattr(asm_field_decode,function_name)
        field_value = field_function(tokens[token_number])
        print("field value: {}".format(hex(field_value)))
        subfields = fields[field_name]["subfields"]
        specific_instruction_decode = instruction_subfield_override(specific_instruction_decode, subfields, field_value)
    return specific_instruction_decode

def instruction_field_decode(instruction_type, instruction_description):
    instruction = 0
    fields = instruction_description["RV32I"]["FIELDS"]
    field_overrides = instruction_description["RV32I"]["TYPE"][instruction_type["type"]]["OVERRIDES"][instruction_type["subtype"]]
    print("instruction={}".format(instruction))
    print(instruction_type["type"])
    for field_name in instruction_description["RV32I"]["TYPE"][instruction_type["type"]]["INSTRUCTION_FIELDS"]["fields"]:
        if field_name not in field_overrides:
            continue
        field_value_override = field_overrides[field_name]
        subfields = fields[field_name]["subfields"]
        instruction = instruction_subfield_override(instruction,subfields, field_value_override)
    return instruction

def instruction_subfield_override(instruction, subfields, field_value_override):
    for field_meta in reversed(subfields):
        field_value  = field_value_override & (2**field_meta["bits"]-1)
        instruction |= field_value << field_meta["offset"]
        field_value_override = field_value_override >> field_meta["bits"]
    print("instruction subfield override={}".format(hex(instruction)))
    return instruction

def identify_instruction_type(instruction,  instructions_description, tokens):
    if not tokens:
        exit(1)
    #print(instruction)
    #print(tokens)
    #print(tokens[0])
    instruction_type = identify_type(tokens[0], instructions_description)
    #instruction_field_override(instruction_type, tokens, instruction_description)
    return instruction_type

def get_asm_instructions(source_name):
    with open(source_name,'r') as source_file:
        instructions = source_file.readlines()
    return instructions

def asm_to_hex(asm_instructions, instructions_description):
    hex_instructions = [] 
    for instruction in asm_instructions:
        #print(f"Parsing: {instruction}")
        specific_instruction_decode = instruction_decode(instruction, instructions_description)
        hex_instructions.append(specific_instruction_decode)
    return hex_instructions

def instruction_decode(instruction,instructions_description):
    tokens = asm_field_decode.get_instruction_tokens(instruction)
    instruction_type = identify_instruction_type(instruction, instructions_description, tokens)
    type_instruction_decode = instruction_field_decode(instruction_type, instructions_description)
    print(hex(type_instruction_decode))
    specific_instruction_decode = instruction_field_override(instruction_type, tokens, instructions_description, type_instruction_decode)
    print(hex(specific_instruction_decode))
    return specific_instruction_decode

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
    hex_instructions = asm_field_decode.int_to_32bit_hex_instructions(int_instructions)

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

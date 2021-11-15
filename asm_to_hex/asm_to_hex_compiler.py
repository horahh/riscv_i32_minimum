import argparse
import re

RTYPE = "rtype"
ITYPE = "itype"
rtype_instructions_alu_base  = [ "add","sll","slt","sltu","xor","srl","or","and" ]
rtype_instructions_alu_extra = [ "sub", "sra" ]
itype_instructions_alu       = [ "addi", "slti", "sltiu", "xori", "ori", "andi" ]

def get_instruction_decoder():
    """
    Construct a map to decode each instruction type.
    """
    instruction_type = {}
    for instruction in rtype_instructions_alu_base:
        instruction_type[instruction] = RTYPE 
    for instruction in rtype_instructions_alu_extra:
        instruction_type[instruction] = RTYPE 
    for instruction in itype_instructions_alu:
        instruction_type[instruction] = ITYPE
    return instruction_type

def asm_to_binary(source_name, destination_name):
    hex_instructions = []
    with open(source_name,'r') as source_file:
        instructions = source_file.readlines()
    for instruction in instructions:
        #print(f"Parsing: {instruction}")
        hex_instruction_decode = parse_instruction(instruction)
        hex_instructions.append(hex_instruction_decode)
    with open(destination_name, 'w') as destination_file:
        for hex_instruction in hex_instructions:
            #print("writing {}".format(hex_instruction))
            destination_file.write(hex_instruction)
            destination_file.write("\n")

def get_instruction_tokens(instruction):
    instruction = instruction.strip()
    tokens = re.split(r"\s+|\s?,\s?",instruction)
    #print(tokens)
    return tokens

def identify_type(token):
    """
    Function to map the type of the instruction to to specific instruction token
    """
    instruction_type = get_instruction_decoder()
    return instruction_type[token]

def get_funct7(token):
    if token in rtype_instructions_alu_base:
        return 0 
    if token in rtype_instructions_alu_extra:
        return 32 
    print("ERROR unexpected token: {} ".format( token))
    exit(1)

def get_funct3(token):
    funct3_token = { 
            "add" : 0,
            "sub" : 0,
            "sll" : 1,
            "slt" : 2,
            "sltu": 3,
            "xor" : 4,
            "srl" : 5,
            "sra" : 5,
            "or"  : 6,
            "and" : 7
            }
    return funct3_token[token]

def get_funct3i(token):
    funct3i_token = {
            "addi"  : 0,
            "slti"  : 2,
            "sltiu" : 3,
            "xori"  : 4,
            "ori"   : 6,
            "andi"  : 7
            }
    return funct3i_token[token]

def get_register(token):
    result = re.match(r"^r(\d+)$", token)
    if result:
        register = int(result.group(1))
        if register < 0 or register > 31:
            print("invalid token, expecting register {}".format(token))
            exit(1)
        return register 
    print("invalid token, expecting register {}".format(token))
    exit(1)

def get_immediate(token):
    result = re.match(r"^([\-\+]?\d+)$", token)
    if result:
        immediate = int(result.group(1))
        # 2^11 = 2048 max value
        # 2^11+1 = 2049 min value
        min_immediate_value = -2049
        max_immediate_value = 2048
        if immediate < min_immediate_value or immediate > max_immediate_value:
            print("invalid token, expecting immediate {}".format(token))
            exit(1)
        if immediate < 0:
            immediate_field_bits = 12
            immediate =  (2 ** immediate_field_bits) + immediate
            immediate = immediate & ((2 ** immediate_field_bits) - 1)  
            #print("immediate = {}\n".format(immediate))
        return immediate 
    print("invalid token, expecting immediate value: {}".format(token))
    exit(1)

def decode_rtype(tokens):
    """
    Function to return the hex value for each instruction based on:

    https://github.com/riscv/riscv-opcodes/blob/master/opcodes-rv32i

    add     rd rs1 rs2 31..25=0  14..12=0 6..2=0x0C 1..0=3
    sub     rd rs1 rs2 31..25=32 14..12=0 6..2=0x0C 1..0=3
    sll     rd rs1 rs2 31..25=0  14..12=1 6..2=0x0C 1..0=3
    slt     rd rs1 rs2 31..25=0  14..12=2 6..2=0x0C 1..0=3
    sltu    rd rs1 rs2 31..25=0  14..12=3 6..2=0x0C 1..0=3
    xor     rd rs1 rs2 31..25=0  14..12=4 6..2=0x0C 1..0=3
    srl     rd rs1 rs2 31..25=0  14..12=5 6..2=0x0C 1..0=3
    sra     rd rs1 rs2 31..25=32 14..12=5 6..2=0x0C 1..0=3
    or      rd rs1 rs2 31..25=0  14..12=6 6..2=0x0C 1..0=3
    and     rd rs1 rs2 31..25=0  14..12=7 6..2=0x0C 1..0=3

    """
    opcode_offset = 0
    rd_offset = 7
    funct3_offset = 12
    rs1_offset = 15
    rs2_offset = 20
    funct7_offset = 25
    opcode = 0x3 + (0xC << 2)
    funct7 = get_funct7(tokens[0])
    funct3 = get_funct3(tokens[0])
    rs1 = get_register(tokens[3])
    rs2 = get_register(tokens[2])
    rd = get_register(tokens[1])
    binary_instruction = (opcode << opcode_offset) + (rd << rd_offset) + (funct3 <<funct3_offset) + (rs1 << rs1_offset) + (rs2 << rs2_offset) + (funct7 << funct7_offset)
    #print(f"{funct7}")
    #print(f"{funct3}")
    #print(f"{rs1}")
    #print(f"{rs2}")
    #print(f"{rd}")
    hex_value_32_bit = hex(binary_instruction)[2:].zfill(8)
    #print("{}".format(hex_value_32_bit))
    return hex_value_32_bit

def decode_itype(tokens):
    """
    Function to return the hex value for each instruction based on:

    https://github.com/riscv/riscv-opcodes/blob/master/opcodes-rv32i

    addi    rd rs1 imm12           14..12=0 6..2=0x04 1..0=3
    slti    rd rs1 imm12           14..12=2 6..2=0x04 1..0=3
    sltiu   rd rs1 imm12           14..12=3 6..2=0x04 1..0=3
    xori    rd rs1 imm12           14..12=4 6..2=0x04 1..0=3
    ori     rd rs1 imm12           14..12=6 6..2=0x04 1..0=3
    andi    rd rs1 imm12           14..12=7 6..2=0x04 1..0=3
    """
    opcode_offset = 0
    rd_offset = 7
    funct3_offset = 12
    rs1_offset = 15
    immediate_offset = 20
    opcode = 0x3 + (0x4 << 2)
    funct7 = 0
    funct3 = get_funct3i(tokens[0])
    rs1 = get_register(tokens[2])
    immediate = get_immediate(tokens[3])
    rd = get_register(tokens[1])
    binary_instruction = (opcode << opcode_offset) + (rd << rd_offset) + (funct3 <<funct3_offset) + (rs1 << rs1_offset) + (immediate << immediate_offset) 
    hex_value_32_bit = hex(binary_instruction)[2:].zfill(8)
    return hex_value_32_bit

def parse_instruction(instruction):
    tokens = get_instruction_tokens(instruction)
    if not tokens:
        exit(1)
    #print(instruction)
    #print(tokens)
    #print(tokens[0])
    instruction_type = identify_type(tokens[0])
    if instruction_type == RTYPE:
        return decode_rtype(tokens)
    if instruction_type == ITYPE:
        return decode_itype(tokens)
    else:
        print("type not supported")
        exit(1)

def main():
    parser = argparse.ArgumentParser(description="ASM to Binary RV32I Translator")
    parser.add_argument("--asm",type=str, default="code.asm",help="Provide the asm to translate to binary")
    parser.add_argument("--bin",type=str, default="code.hex", help="Provide the bin file to dump the binary translation of the provided asm")
    args=parser.parse_args()
    asm_to_binary(args.asm, args.bin)

if __name__ == "__main__":
    main()

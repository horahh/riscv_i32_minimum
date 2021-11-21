import re

rtype_instructions_alu_base  = [ "add","sll","slt","sltu","xor","srl","or","and" ]
rtype_instructions_alu_extra = [ "sub", "sra" ]
itype_instructions_alu       = [ "addi", "slti", "sltiu", "xori", "ori", "andi" ]
jtype_direct_instructions    = [ "jal" ]
jtype_indirect_instructions  = [ "jalr" ] 

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
    if token in funct3_token.keys():
        return funct3_token[token]
    funct3i_token = {
            "addi"  : 0,
            "slti"  : 2,
            "sltiu" : 3,
            "xori"  : 4,
            "ori"   : 6,
            "andi"  : 7
            }
    if token in funct3i_token.keys():
        return funct3i_token[token]
    print("ERROR: token not supported")
    exit(1)

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

def get_rs1(token):
    return get_register(token)
def get_rs2(token):
    return get_register(token)
def get_rd(token):
    return get_register(token)

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

def get_instruction_tokens(instruction):
    instruction = instruction.strip()
    tokens = re.split(r"\s+|\s?,\s?",instruction)
    #print(tokens)
    return tokens

def int_to_32bit_hex_instruction(binary_instruction):
    hex_value_32_bit = hex(binary_instruction)[2:].zfill(8)
    return hex_value_32_bit

def int_to_32bit_hex_instructions(int_instructions):
    hex_instructions = []
    for int_instruction in int_instructions:
        hex_instruction = int_to_32bit_hex_instruction(int_instruction)
        hex_instructions.append(hex_instruction)
    return hex_instructions

def get_immediate_j(token):
    immediate = get_immediate_j_value(token)
    immediate_1 = immediate >> 1 & ( 2**9-1) 
    immediate_2 = immediate >> 11 & 1
    immediate_3 = immediate >> 8 & (2**8-1)
    immediate_4 = immediate >> 20 & 1
    immediate_1_offset =  1 - 1
    immediate_2_offset = 11 - 1
    immediate_3_offset = 12 - 1 
    immediate_4_offset = 20 - 1
    immediate_rv = (immediate_1 << immediate_1_offset ) + (immediate_2 << immediate_2_offset) + (immediate_3 << immediate_3_offset) + (immediate_4 << immediate_4_offset)
    return immediate_rv

def get_immediate_j_value(token):
    result = re.match(r"^([\-\+]?\d+)$", token)
    if result:
        immediate = int(result.group(1))
        min_immediate_value = -2**18-1
        max_immediate_value =  2**18 
        if immediate < min_immediate_value or immediate > max_immediate_value:
            print("invalid token, expecting immediate {}".format(token))
            exit(1)
        if immediate < 0:
            immediate_field_bits = 19 
            immediate =  (2 ** immediate_field_bits) + immediate
            immediate = immediate & ((2 ** immediate_field_bits) - 1)  
            #print("immediate = {}\n".format(immediate))
        return immediate 
    print("invalid token, expecting immediate value: {}".format(token))
    exit(1)

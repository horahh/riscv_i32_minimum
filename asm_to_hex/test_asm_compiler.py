import asm_to_hex_compiler as asm

def test_reg_sum():
    instruction = "add r10, r6, r5"
    hex_instruction_decode = asm.parse_instruction(instruction)
    assert(hex_instruction_decode == "00628533")

def test_reg_sub():
    instruction = "sub r3,r1,r0"
    hex_instruction_decode = asm.parse_instruction(instruction)
    assert(hex_instruction_decode == "401001b3")

def test_immediate_sum_negative():
    instruction = "addi r15, r1, -50"
    hex_instruction_decode = asm.parse_instruction(instruction)
    assert(hex_instruction_decode == "fce08793")

def test_immediate_sum_positive():
    instruction = "addi r15, r1, 50"
    hex_instruction_decode = asm.parse_instruction(instruction)
    assert(hex_instruction_decode == "03208793")


import asm_toml as asm
import asm_field_decode as afd

instructions_description = asm.get_instruction_field_description("asm_to_hex/rv32i_instructions.toml")

def test_reg_sum():
    instruction = "add r10, r6, r5"
    int_instruction_field_decode = asm.instruction_decode(instruction, instructions_description)
    hex_instruction_field_decode = afd.int_to_32bit_hex_instruction(int_instruction_field_decode)
    assert(hex_instruction_field_decode == "00628533")

def test_reg_sub():
    instruction = "sub r3,r1,r0"
    int_instruction_field_decode = asm.instruction_decode(instruction, instructions_description)
    hex_instruction_field_decode = afd.int_to_32bit_hex_instruction(int_instruction_field_decode)
    assert(hex_instruction_field_decode == "401001b3")

def test_immediate_sum_negative():
    instruction = "addi r15, r1, -50"
    int_instruction_field_decode = asm.instruction_decode(instruction, instructions_description)
    hex_instruction_field_decode = afd.int_to_32bit_hex_instruction(int_instruction_field_decode)
    assert(hex_instruction_field_decode == "fce08793")

def test_immediate_sum_positive():
    instruction = "addi r15, r1, 50"
    int_instruction_field_decode = asm.instruction_decode(instruction, instructions_description)
    hex_instruction_field_decode = afd.int_to_32bit_hex_instruction(int_instruction_field_decode)
    assert(hex_instruction_field_decode == "03208793")

def test_immediate_load():
    instruction = "lw r14, 8(r2)"
    int_instruction_field_decode = asm.instruction_decode(instruction, instructions_description)
    hex_instruction_field_decode = afd.int_to_32bit_hex_instruction(int_instruction_field_decode)
    assert(hex_instruction_field_decode == "00812703")

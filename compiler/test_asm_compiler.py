import instruction_set
import instruction_descriptor
import instruction
import compiler

isa = instruction_set.InstructionSet("compiler/configuration/rv32i_instructions.toml")


def test_reg_sum():
    asm_instructions = ["add r10, r6, r5"]
    hex_instructions_expected = ["00628533"]
    hex_instructions = compiler.asm_to_hex(asm_instructions, isa)
    assert hex_instructions == hex_instructions_expected


def test_reg_sub():
    asm_instructions = ["sub r3,r1,r0"]
    hex_instructions_expected = ["401001b3"]
    hex_instructions = compiler.asm_to_hex(asm_instructions, isa)
    assert hex_instructions == hex_instructions_expected


def test_immediate_sum_negative():
    asm_instructions = ["addi r15, r1, -50"]
    hex_instructions_expected = ["fce08793"]
    hex_instructions = compiler.asm_to_hex(asm_instructions, isa)
    assert hex_instructions == hex_instructions_expected


def test_immediate_sum_positive():
    asm_instructions = ["addi r15, r1, 50"]
    hex_instructions_expected = ["03208793"]
    hex_instructions = compiler.asm_to_hex(asm_instructions, isa)
    assert hex_instructions == hex_instructions_expected


def test_immediate_load():
    asm_instructions = ["lw r14, 8(r2)"]
    hex_instructions_expected = ["00812703"]
    hex_instructions = compiler.asm_to_hex(asm_instructions, isa)
    assert hex_instructions == hex_instructions_expected

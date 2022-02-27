import instruction_set
import instruction_descriptor
import instruction
import compiler
from functools import reduce

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


def test_store():
    asm_instructions = ["sw r15, 8(r2)"]
    bin_instruction_fields = {
        "opcode": "0100011",
        "offset4:0": "01000",
        "funct3": "010",
        "rs1": "00010",
        "rs2": "01111",
        "offset5:12": "0000000",
    }
    bin_instruction_fields = dict(reversed(list(bin_instruction_fields.items())))
    bin_instruction = reduce(lambda x, y: x + y, bin_instruction_fields.values())
    bin_instruction_hex = "%08x" % int(bin_instruction, 2)

    hex_instructions_expected = [bin_instruction_hex]
    hex_instructions = compiler.asm_to_hex(asm_instructions, isa)
    assert hex_instructions == hex_instructions_expected

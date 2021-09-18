# opcodes-rv32i

credits: https://github.com/riscv/riscv-opcodes/blob/master/opcodes-rv32i

format of a line in this file:
<instruction name> <args> <opcode>

<opcode> is given by specifying one or more range/value pairs:
hi..lo=value or bit=value or arg=value (e.g. 6..2=0x45 10=1 rd=0)

<args> is one of rd, rs1, rs2, rs3, imm20, imm12, imm12lo, imm12hi,
shamtw, shamt, rm

## BRANCH_TYPE [6:0] => 0x63
beq     bimm12hi rs1 rs2 bimm12lo 14..12=0 6..2=0x18 1..0=3
bne     bimm12hi rs1 rs2 bimm12lo 14..12=1 6..2=0x18 1..0=3
blt     bimm12hi rs1 rs2 bimm12lo 14..12=4 6..2=0x18 1..0=3
bge     bimm12hi rs1 rs2 bimm12lo 14..12=5 6..2=0x18 1..0=3
bltu    bimm12hi rs1 rs2 bimm12lo 14..12=6 6..2=0x18 1..0=3
bgeu    bimm12hi rs1 rs2 bimm12lo 14..12=7 6..2=0x18 1..0=3

## INTEGER_TYPE_JUMP 0x67
jalr    rd rs1 imm12              14..12=0 6..2=0x19 1..0=3
jalr    rd rs1 imm12              14..12=0 6..2=0x19 1..0=3

## JUMP_TYPE 0x6f
jal     rd jimm20                          6..2=0x1b 1..0=3

## UNCONDITIONAL_TYPE_LOAD 0x37
lui     rd imm20 6..2=0x0D 1..0=3
## UNCONDITIONAL_TYPE_ADD 0x17
auipc   rd imm20 6..2=0x05 1..0=3

## INTEGER_TYPE_ALU 0x0C
addi    rd rs1 imm12           14..12=0 6..2=0x04 1..0=3
slti    rd rs1 imm12           14..12=2 6..2=0x04 1..0=3
sltiu   rd rs1 imm12           14..12=3 6..2=0x04 1..0=3
xori    rd rs1 imm12           14..12=4 6..2=0x04 1..0=3
ori     rd rs1 imm12           14..12=6 6..2=0x04 1..0=3
andi    rd rs1 imm12           14..12=7 6..2=0x04 1..0=3

## REGISTER_TYPE_ALU 0x33
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

## INTEGER_TYPE_LOAD 0x03
lb      rd rs1       imm12 14..12=0 6..2=0x00 1..0=3
lh      rd rs1       imm12 14..12=1 6..2=0x00 1..0=3
lw      rd rs1       imm12 14..12=2 6..2=0x00 1..0=3
lbu     rd rs1       imm12 14..12=4 6..2=0x00 1..0=3
lhu     rd rs1       imm12 14..12=5 6..2=0x00 1..0=3
## STORE_TYPE Ox23
sb     imm12hi rs1 rs2 imm12lo 14..12=0 6..2=0x08 1..0=3
sh     imm12hi rs1 rs2 imm12lo 14..12=1 6..2=0x08 1..0=3
sw     imm12hi rs1 rs2 imm12lo 14..12=2 6..2=0x08 1..0=3

## FENCE_TYPE ?? 0x0F
fence       fm            pred succ     rs1 14..12=0 rd 6..2=0x03 1..0=3
fence.i     imm12                       rs1 14..12=1 rd 6..2=0x03 1..0=3

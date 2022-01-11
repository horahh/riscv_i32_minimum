import re
import instruction_descriptor


class Instruction:
    def __init__(self, instruction_string, descriptor):
        self.instruction_set_descriptor = descriptor
        self.instruction_string = instruction_string
        self.tokens = self.__decode_tokens()
        self.value = 0

    def __decode_tokens(self):
        instruction = self.instruction_string.strip()
        tokens = re.split(r"\s+|\s*,\s*|\s*\(\s*|\s*\)", instruction)
        # print(tokens)
        return tokens

    def __getitem__(self, index):
        return self.get_token(index)

    def get_token(self, index):
        return self.tokens[index]

    def __decode_instruction(self):
        return self.instruction_set_descriptor.get_value(self)

    def get_value_hex(self):
        self.value = self.__decode_instruction()
        return hex(self.value)[2:].zfill(8)

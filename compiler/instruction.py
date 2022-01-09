import re
import instruction_descriptor

class Instruction():
    def __init__(self,instruction_string, descriptor):
        instruction_set_descriptor = descriptor
        self.tokens = self.__decode_tokens(instruction_string)

    def __decode_tokens(self,instruction):
        instruction = instruction.strip()
        tokens = re.split(r"\s+|\s*,\s*|\s*\(\s*|\s*\)",instruction)
        self.value = 0
        #print(tokens)
        return tokens

    def get_token(self,index):
        return self.tokens[index] 
    def set_value(self,value):
        self.value = value
    def __decode_instruction(self):
        instruction_set_descriptor.set_fields(self)

    def get_value(self):
        if value == 0:
            value = self.__decode_instruction(self)
            self.value = value
        return self.value
    def get_value_hex(self):
        return hex(self.value)[2:].zfill(8)


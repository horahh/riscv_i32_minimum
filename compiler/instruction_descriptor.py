import instruction_set
import type_decoder

class InstructionDescriptor(): 
    def __init__(self,instruction_set_obj):
        self.__instruction_set = instruction_set_obj
        typeDecoder = type_decoder.TypeDecoder(self.__instruction_set)

    def __get_fields_by_type(self,field_type):
        return __instruction_set["RV32I"]["TYPE"][specific_type]["INSTRUCTION_FIELDS"]
    def set_fields(self,instruction):
        field_type = typeDecoder.get_type()
        fields = self.__get_fields_by_type(field_type)
        for field in fields:
            self.set_field(field, instruction)

    def set_field(self,field_name, instruction):
        field_descriptor = self.__get_instruction_descriptor(instruction)
        field_value = self.__get_field_value(field_descriptor, instruction)
    def __get_field_descriptor(self,field_name):
        field_descriptor = __instruction_set["RV32I"]["FIELDS"][field_name]

    def __get_field_value(self,field_descriptor,instruction):
        token_index = self.__get_token_index(field_descriptor)
        token_value = instruction.get_token(token_index)
        field_value = self.__token_to_field_decode(token_value,field_descriptor["subfields"])

    def __get_token(self,field_descriptor,subtype):
        if isinstance(field_descriptor, dict):
            return field_descriptor["token_index"][subtype]
        return field_descriptor["token_index"]

    def __token_to_field_decode(self,set_value, subfields):
        instruction = 0
        mask32 = 0xffffffff
        for field_meta in reversed(subfields):
            field_mask    = (2**field_meta["bits"]-1)
            field_offset  = field_meta["offset"]
            field_size    = field_meta["bits"]
            field_decode  = set_value & field_mask
            instruction  &= mask32 & ~(field_mask << field_offset)
            instruction  |= field_decode << field_offset 
            set_value = set_value >> field_size

        #print("instruction subfield override={}".format(hex(instruction)))
        return instruction



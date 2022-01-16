import instruction_set
import type_decoder


class InstructionDescriptor:
    """
    Class to translate the ASM instruction object into binary.
    Holds the ISA definition from the InstructioSet object.
    Responsible of translation from instruction tokens to the bitfields
    into the final binary representation
    """

    def __init__(self, instruction_set_obj):
        self.__instruction_set = instruction_set_obj
        self.typeDecoder = type_decoder.TypeDecoder(self.__instruction_set)
        self.fields = {}

    def set_fields(self, instruction):
        instruction_token = instruction.get_token(0)
        print(f"Token: {instruction_token}")
        field_type = self.typeDecoder.get_type(instruction.get_token(0))
        print(f"field: {field_type}")
        fields = self.__instruction_set.get_fields(field_type["type"])
        print(f"fields: {fields}")
        for field in fields:
            self.set_field(field, instruction, field_type["subtype"])
        self.set_overrides(instruction_token, field_type["type"], field_type["subtype"])

    def set_field(self, field_name, instruction, subtype):
        print(f"field name: {field_name}")
        field_value = self.__get_field_value(field_name, instruction, subtype)
        self.fields[field_name] = field_value
        print(self.fields)

    def set_overrides(self, instruction_token, instruction_type, subtype):
        for field, override_value in self.__instruction_set.get_field_overrides(
            instruction_type, subtype, instruction_token
        ):
            field_size = self.__instruction_set.get_field_size(field)
            field_offset = self.__instruction_set.get_field_offset(field)
            field_value_offset = self.__field_shift(
                override_value, field_size, field_offset
            )
            self.fields[field] = field_value_offset

    def __get_field_descriptor(self, field_name):
        return self.__instruction_set.get_field_descriptor(field_name)

    def __get_field_value(self, field_name, instruction, subtype):
        token_index = self.__instruction_set.get_token_index(field_name, subtype)
        if not token_index:
            return
        token_value = instruction.get_token(token_index)
        if token_value[0] == "r":
            token_value = token_value[1:]
        token_value = int(token_value)

        print(f"token value: {token_value}")
        field_value = self.__token_to_field_decode(token_value, field_name)
        print(f"field value: {field_value}")
        return field_value

    def __token_to_field_decode(self, field_value, field_name):
        instruction = 0
        mask32 = 0xFFFFFFFF
        for subfield_size, subfield_offset in self.__instruction_set.get_subfields(
            field_name
        ):
            subfield_value = self.__field_shift(
                field_value, subfield_size, subfield_offset
            )
            instruction |= subfield_value
        return instruction

    def __field_shift(self, field_value, field_size, field_offset):
        field_mask = 2 ** (field_size) - 1
        final_value = field_mask & field_value
        final_value = final_value << field_offset
        return final_value

    def get_value(self, instruction):
        self.fields = {}
        self.set_fields(instruction)
        instruction_int = 0

        for key, field in self.fields.items():
            if isinstance(field, dict):
                field_val = field[instruction.get_token(0)]
            else:
                field_val = field
            print(f"key {key}, value: {field_val}")
            field_hex = hex(field_val)
            print(f"key: \t{key} \tfield: \t{field_hex}")
            print(f"field value : {field_val}")
            instruction_int |= field_val
            instruction_hex = hex(instruction_int)
            print(f"instruction: \t{instruction_hex}")
        # print("instruction subfield override={}".format(hex(instruction)))
        return instruction_int

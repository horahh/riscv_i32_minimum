import instruction_set
import type_decoder


class InstructionDescriptor:
    def __init__(self, instruction_set_obj):
        self.__instruction_set = instruction_set_obj
        self.typeDecoder = type_decoder.TypeDecoder(self.__instruction_set)
        self.fields = {}

    def __get_fields_by_type(self, field_type):
        return self.__instruction_set["RV32I"]["TYPE"][field_type][
            "INSTRUCTION_FIELDS"
        ]["fields"]

    def set_fields(self, instruction):
        instruction_token = instruction.get_token(0)
        print(f"Token: {instruction_token}")
        v = instruction.get_token(3)
        print(f"value: {v}")
        field_type = self.typeDecoder.get_type(instruction.get_token(0))
        print(f"field: {field_type}")
        fields = self.__get_fields_by_type(field_type["type"])
        print(f"fields: {fields}")
        for field in fields:
            self.set_field(field, instruction, field_type["subtype"])
        self.set_overrides(instruction_token, field_type["type"], field_type["subtype"])

    def set_field(self, field_name, instruction, subtype):
        print(f"field name: {field_name}")
        field_descriptor = self.__get_field_descriptor(field_name)
        field_value = self.__get_field_value(field_descriptor, instruction, subtype)
        self.fields[field_name] = field_value
        print(self.fields)

    def set_overrides(self, instruction_token, instruction_type, subtype):
        overrides = self.__instruction_set["RV32I"]["TYPE"][instruction_type][
            "OVERRIDES"
        ][subtype]
        for field, override in overrides.items():
            override_value = 0
            if isinstance(override, dict):
                override_value = override[instruction_token]
            else:
                override_value = override

            field_descriptor = self.__instruction_set.get_field_descriptor(field)
            field_size = field_descriptor["subfields"][0]["bits"]
            field_offset = field_descriptor["subfields"][0]["offset"]
            field_value_offset = self.__field_shift(
                override_value, field_size, field_offset
            )
            self.fields[field] = field_value_offset

    def __get_field_descriptor(self, field_name):
        return self.__instruction_set["RV32I"]["FIELDS"][field_name]

    def __get_field_value(self, field_descriptor, instruction, subtype):
        token_index = self.__get_token_index(field_descriptor, subtype)
        if not token_index:
            return
        token_value = instruction.get_token(token_index)
        if token_value[0] == "r":
            token_value = token_value[1:]
        token_value = int(token_value)

        print(f"token value: {token_value}")
        field_value = self.__token_to_field_decode(
            token_value, field_descriptor["subfields"]
        )
        print(f"field value: {field_value}")
        return field_value

    def __get_token_index(self, field_descriptor, subtype):
        if isinstance(field_descriptor["token_index"], dict):
            return field_descriptor["token_index"][subtype]
        return field_descriptor["token_index"]

    def __token_to_field_decode(self, set_value, subfields):
        instruction = 0
        mask32 = 0xFFFFFFFF
        for field_meta in subfields:
            field_mask = 2 ** (field_meta["bits"]) - 1
            field_offset = field_meta["offset"]
            field_size = field_meta["bits"]
            field_decode = set_value & field_mask
            instruction &= mask32 & ~(field_mask << field_offset)
            instruction |= field_decode << field_offset
            set_value = set_value >> field_size
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

            field_hex = hex(field_val)
            print(f"key: \t{key} \tfield: \t{field_hex}")
            print(f"field value : {field_val}")
            instruction_int |= field_val
            instruction_hex = hex(instruction_int)
            print(f"instruction: \t{instruction_hex}")
        # print("instruction subfield override={}".format(hex(instruction)))
        return instruction_int

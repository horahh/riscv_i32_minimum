import toml


class InstructionSet:
    """
    Class to hold the description provided by the toml file.
    Responsible of providing information from instructions to other classes.
    The idea is is abstract the TOML description and provide necessary pieces of
    information by providing accessors to specific data by given tokens
    """

    def __init__(self, instruction_set_configuration_file):
        self.toml_configuration = self.__get_instruction_set_configuration(
            instruction_set_configuration_file
        )

    def __get_instruction_set_configuration(self, configuration_file):
        with open(configuration_file) as config:
            file_lines = config.readlines()
            toml_string = "\n".join(file_lines)
            toml_config = toml.loads(toml_string)
        return toml_config

    def get_configuration(self):
        return self.toml_configuration

    def __getitem__(self, index):
        return self.toml_configuration[index]

    def get_field_descriptor(self, field_name):
        return self.toml_configuration["RV32I"]["FIELDS"][field_name]

    def get_fields(self, field_type):
        return self.toml_configuration["RV32I"]["TYPE"][field_type][
            "INSTRUCTION_FIELDS"
        ]["fields"]

    def get_field_overrides(self, instruction_type, subtype, instruction_token):
        overrides = self.toml_configuration["RV32I"]["TYPE"][instruction_type][
            "OVERRIDES"
        ][subtype]
        for field, override in overrides.items():
            override_value = 0
            if isinstance(override, dict):
                override_value = override[instruction_token]
            else:
                override_value = override
            yield field, override_value

    def get_token_index(self, field_name, subtype):
        field_descriptor = self.get_field_descriptor(field_name)
        if isinstance(field_descriptor["token_index"], dict):
            return field_descriptor["token_index"][subtype]
        return field_descriptor["token_index"]

    def get_subfields(self, field_name):
        subfields = self.get_field_descriptor(field_name)["subfields"]
        for subfield in subfields:
            yield subfield["bits"], subfield["offset"]

    def get_field_size(self, field_name):
        return self.get_field_descriptor(field_name)["subfields"][0]["bits"]

    def get_field_offset(self, field_name):
        return self.get_field_descriptor(field_name)["subfields"][0]["offset"]

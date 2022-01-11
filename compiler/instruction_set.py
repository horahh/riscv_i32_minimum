import toml


class InstructionSet:
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

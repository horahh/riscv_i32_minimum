import toml

class InstructionSet()
    instruction_set_configuration = None
    __init__(self, instruction_set_configuration_file):
        if instruction_set_configuration != None:
            return
        toml_configuration = __get_instruction_set_configuration(self,instruction_set_configuration_file):

    def __get_instruction_set_configuration(self,configuration_file):
        with open(configuration_file) as config:
            file_lines = config.readlines()
            toml_string = "\n".join(file_lines)
            toml_config = toml.loads(toml_string)
        return toml_config 
    def get_configuration():
        return toml_configuration



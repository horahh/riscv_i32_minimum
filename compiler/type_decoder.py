import instruction_set

class TypeDecoder():
    def __init__(self,instruction_set_obj):
        self.__instruction_set = instruction_set_obj
        self.__instruction_type = self.__get_instruction_decoder()
        
    def __get_instruction_decoder(self):
        """
        Extract the type of instruction from the TOML description
        """
        instruction_type = {}
        #print(instruction_descriptor)
        for (itype,instructions_metadata) in self.__instruction_set["RV32I"]["TYPE"].items():
            #print(instructions_metadata)
            for (instruction_subtype, instruction_list) in instructions_metadata["INSTRUCTIONS"].items():
                #print(instruction_subtype)
                for instruction in instruction_list:
                    instruction_type[instruction] = {"type": itype, "subtype": instruction_subtype }
        return instruction_type

    def get_type(self,token):
        """
        Function to map the type of the instruction to to specific instruction token
        """
        return self.__instruction_type[token]

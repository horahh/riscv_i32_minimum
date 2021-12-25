import instruction_set

class TypeDecoder():
    __instruction_set = None

    def __init__(self,instruction_set_obj):
        if __instruction_set == None: 
            __instruction_set = instruction_set_obj
            self.__instruction_type = __get_instruction_decoder(self)
        
    def __get_instruction_decoder(self):
        """
        Extract the type of instruction from the TOML description
        """
        instruction_type = {}
        #print(instruction_descriptor)
        for (itype,instructions_metadata) in __instruction_set["RV32I"]["TYPE"].items():
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

import csv


def get_rtl_log():
    end_info = "VCD info"

    with open("core_rtl/rv32i/rv32.log", "r") as rtl_log:
        pair = False
        ignore = True
        for line in rtl_log:
            line = line.strip()
            if end_info in line:
                ignore = False
                continue
            if ignore:
                continue
            if pair:
                pair = False
                continue
            pair = True
            yield line


def get_rtl_log_registers():
    for line in get_rtl_log():
        if "counter=" not in line:
            continue
        yield line


def get_emulation_log():
    with open("emulation_state.csv", "r") as emulation_log:
        emulation_reader = csv.DictReader(emulation_log)
        first = True
        yield emulation_reader
        for line_num, row in enumerate(emulation_reader):
            print(f"line {line_num}")
            print(row)
            yield row
            # TODO: Actual RTL simulation have single cycle delay from input to result
            # emulate this by repeating the first value
            if first:
                yield row
                yield row
                yield row
                first = False


def map_log_to_register(line):
    tokens = line.split(",")
    register_values = {}
    for token in tokens:
        (register, value) = token.split("=")
        register_values[register] = value
    # print(register_values)
    return register_values


def test_basic():
    # taking the RTL as reference as the RTL simulation is shorter
    for (rtl_log_line, emulation_registers) in zip(
        get_rtl_log_registers(), get_emulation_log()
    ):
        register_values = map_log_to_register(rtl_log_line)
        # seeing the emulation not having validity for the first cycles
        # this is to only test stable rtl simulation cycles
        if register_values["pc"] < "00000010":
            continue
        # pick emulation as has less elements
        for register in emulation_registers:
            assert emulation_registers[register] == register_values[register]

module test_bench_memory;

wire clock;
wire read_enable;
wire [31:0] read_address;
wire [31:0] read_value;
wire write_enable;
wire [31:0] write_address;
wire [31:0] write_value;

memory memory_rv(clock, read_enable, read_address, read_value,write_enable, write_address,write_value);
test_case_memory test_case_memory_rv(clock, read_enable, read_address, read_value,write_enable, write_address,write_value);

endmodule

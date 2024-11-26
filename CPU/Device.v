module Device (clk, reset, digit_select_sign, digit_select_hunth, segment_select, digit_select_unit, digit_select_tenth);
    input wire clk;                 // Clock signal
    input wire reset;               // Reset signal

    output [7:0] segment_select;
    output digit_select_sign, digit_select_hunth, digit_select_unit, digit_select_tenth;

    wire [31:0] Instruction;        // 32-bit instruction fetched from instruction memory
    wire [31:0] read_data;          // Data read from memory
    wire mem_load;                  // Memory load control signal
    wire mem_store;                 // Memory store control signal
    wire [31:0] alu_result;         // Addr to be written to memory
    wire [31:0] data_address;       // Address for data memory access
    wire [31:0] read_value2;        // Data to be written to memory
    wire [31:0] ins_address;        // Instruction memory address
    wire en_fetch_pulse;            // Enable fetch pulse for instruction memory
    wire en_exe_pulse;

    reg [31:0] cnt;
    reg clk_div;


    always@(posedge clk)
    begin
        if(reset)
        begin
            cnt<=0;
            clk_div<=0;
        end
        else if(cnt == 32'd2000_0000) begin
                clk_div <= ~clk_div;
                cnt <= 0;
            end
        else
            cnt <= cnt + 1;
    end

    // Instantiate CPU
    CPU cpu_inst (
        .clk(clk_div),
        .reset(reset),
        .Instruction(Instruction),
        .read_data(read_data),
        .mem_load(mem_load),
        .mem_store(mem_store),
        .ins_address(ins_address), 
        .read_value2(read_value2),
        .alu_result(alu_result),
        .en_fetch_pulse(en_fetch_pulse),
        .en_exe_pulse(en_exe_pulse)
    );

    // Instantiate Data Memory
    Data_Memory data_mem_instance (
        .clk(clk_div),
        .reset(reset),
        .data_address(alu_result),
        .write_data(read_value2),
        .mem_store(mem_store),
        .mem_load(mem_load),
        .en_exe_pulse(en_exe_pulse),
        .read_data(read_data)
    );

    // Instantiate Instruction Memory
    Instruction_Memory ins_mem_instance (
        .ins_address(ins_address),
        .en_fetch_pulse(en_fetch_pulse),
        .Instruction(Instruction)
    );
    IO_Ports ins_IO_Ports (
        .clk(clk), 
        .reset(reset), 
        .cpu_result(alu_result), 
        .digit_select_unit(digit_select_unit), 
        .digit_select_tenth(digit_select_tenth), 
        .digit_select_sign(digit_select_sign), 
        .digit_select_hunth(digit_select_hunth),
        .segment_select(segment_select)
    );

    ila_1 u_ila_1 (
	.clk(clk_div),              // input wire clk

	.probe0(read_data),         // input wire [31:0]  probe0  
	.probe1(data_address),      // input wire [31:0]  probe1 
	.probe2(read_value2),       // input wire [31:0]  probe2
    .probe3(reset)
);

endmodule

module CPU (clk, reset, Instruction, read_data, mem_load, mem_store, ins_address, read_value2, alu_result, en_fetch_pulse, en_exe_pulse);

    input clk, reset;                           // Clock signal
    input wire [31:0] Instruction;              // 32-bit instruction input
    input wire [31:0] read_data;                // Data read from memory

    output wire mem_load;                       // Signal for memory load
    output wire mem_store;                      // Signal for memory store
    output wire [31:0] ins_address;             // address to ins memory
    output wire [31:0] read_value2;             // Data to Data memory
    output wire [31:0] alu_result;              // Addr to Data memory
    output wire en_fetch_pulse;
    output wire en_exe_pulse;                   // Enable execution pulse

// Internal signals to connect between Datapath and Control_Unit
    wire [4:0] opcode;                          // 4-bit opcode from the instruction
    wire [3:0] Rd, Rs, Rt;                      // Destination and source register IDs
    wire [31:0] imm_ext;                        // Extended immediate value
    wire [4:0] alu_control;                     // ALU control signal
    wire regwrite;                              // Register write enable signal
    wire in2_muxcontrol;                        // Control signal for ALU input multiplexer
    wire wv_muxcontrol;                         // Control signal for write value multiplexer
    wire [1:0] flag;                            // ALU flags output

    // Instance of Control Unit
    Control_Unit Control_Unit_inst (
        .clk(clk),
        .reset(reset),
        .Instruction(Instruction),
        .opcode(opcode),
        .Rd(Rd),
        .Rs(Rs),
        .Rt(Rt),
        .imm_ext(imm_ext),
        .flag(flag),
        .in2_muxcontrol(in2_muxcontrol),
        .wv_muxcontrol(wv_muxcontrol),
        .alu_control(alu_control),
        .regwrite(regwrite),
        .mem_load(mem_load),
        .mem_store(mem_store),
        .en_fetch_pulse(en_fetch_pulse), 
        .en_exe_pulse(en_exe_pulse)
    );

    // Instance of Datapath
    Datapath Datapath_inst (
        .clk(clk),
        .reset(reset),
        .opcode(opcode),
        .imm_ext(imm_ext),
        .en_exe_pulse(en_exe_pulse),
        .in2_muxcontrol(in2_muxcontrol),
        .wv_muxcontrol(wv_muxcontrol),
        .Rd(Rd),
        .Rs(Rs),
        .Rt(Rt),
        .read_data(read_data),
        .regwrite(regwrite),
        .ins_address(ins_address), 
        .flag(flag),  
        .read_value2(read_value2),
        .alu_result(alu_result)
    );

ila_0 u_ila (
    .clk(clk), // ILA clock input must be connected to the system clock

    // Probes to monitor signals
    .probe0(Instruction),           // 32-bit instruction
    .probe1(read_data),             // 32-bit data read from memory
    .probe2(mem_load),              // Memory load signal
    .probe3(mem_store),             // Memory store signal
    .probe4(ins_address),           // Instruction memory address
    .probe5(read_value2),           // Data to be written to data memory
    .probe6(alu_result),            // ALU result or address for memory
    .probe7(en_fetch_pulse),        // Enable fetch pulse signal
    .probe8(en_exe_pulse),          // Enable execute pulse signal
    .probe9(opcode),                // Opcode from instruction (5-bit)
    .probe10(Rd),                   // Destination register (4-bit)
    .probe11(Rs),                   // Source register Rs (4-bit)
    .probe12(Rt),                   // Source register Rt (4-bit)
    .probe13(imm_ext),              // Immediate value extended (32-bit)
    .probe14(alu_control),          // ALU control signal (5-bit)
    .probe15(regwrite),             // Register write enable signal
    .probe16(in2_muxcontrol),       // Control signal for ALU input MUX
    .probe17(wv_muxcontrol),        // Control signal for write value MUX
    .probe18(flag),                 // ALU flags (2-bit)
    .probe19(reset),
    .probe20(alu_result)
);
endmodule

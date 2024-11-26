`timescale 1ns / 1ps

module CPU_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [31:0] Instruction;

    // Outputs
    wire [31:0] read_data;
    wire mem_load;
    wire mem_store;
    wire [31:0] ins_address;
    wire [31:0] read_value2;
    wire en_fetch_pulse;
    wire en_exe_pulse;

    // Internal signals between Control Unit and Datapath
    wire [4:0] opcode;
    wire [3:0] Rd, Rs, Rt;
    wire [31:0] imm_ext;
    wire [4:0] alu_control;
    wire regwrite;
    wire en_pc_pulse;
    wire in2_muxcontrol;
    wire wv_muxcontrol;
    wire [1:0] flag;

    //wire [31:0] alu_result;
    //wire [31:0] write_value;

    // Instantiate the CPU
    CPU u_CPU (
        .clk(clk),
        .reset(reset),
        .Instruction(Instruction),
        .read_data(read_data),
        .mem_load(mem_load),
        .mem_store(mem_store),
        .ins_address(ins_address),
        .read_value2(read_value2),
        .en_fetch_pulse(en_fetch_pulse),
        .en_exe_pulse(en_exe_pulse)
    );

    // Clock generation
    always #5 clk = ~clk;  // 100MHz clock (10ns period)

    // Monitor signals for debug
    initial begin
        $monitor("Time = %0d ns, Instruction = %h, read_data = %h, mem_load = %b, mem_store = %b, ins_address = %h, read_value2 = %h en_fetch_pulse = %b, en_exe_pulse = %b, opcode = %h, Rd = %h, Rs = %h, Rt = %h imm_ext = %h, alu_result = %h, alu_control = %h, regwrite = %b, en_pc_pulse = %b, in2_muxcontrol = %b, wv_muxcontrol = %b, flag = %b", 
                 $time, 
                 u_CPU.Instruction, 
                 u_CPU.read_data, 
                 u_CPU.mem_load, 
                 u_CPU.mem_store, 
                 u_CPU.ins_address, 
                 u_CPU.read_value2, 
                 u_CPU.en_fetch_pulse, 
                 u_CPU.en_exe_pulse, 
                 u_CPU.opcode, 
                 u_CPU.Rd, 
                 u_CPU.Rs, 
                 u_CPU.Rt, 
                 u_CPU.imm_ext,
                 u_CPU.alu_result, 
                 //u_CPU.write_value,
                 u_CPU.alu_control, 
                 u_CPU.regwrite, 
                 u_CPU.en_pc_pulse, 
                 u_CPU.in2_muxcontrol, 
                 u_CPU.wv_muxcontrol, 
                 u_CPU.flag
                );
    end

    // Testbench procedure
    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 0;
        Instruction = 32'h00000000;  // Start with a no-op instruction

        // Apply reset
        reset = 1;
        #10;  // Wait for 10ns
        reset = 0;
        #5;

        // Test case 1: Load instruction into CPU
        Instruction = 32'h78800003;  // Example instruction (custom instruction encoding)
        #40;  // Wait for 40ns

        // Test case 2: Store instruction
        Instruction = 32'h79000004;  // Another instruction example
        #40;  // Wait for 40ns

        // Test case 3: Jump instruction
        Instruction = 32'h11890000;  // Jump or branch instruction
        #40;  // Wait for 40ns

        // Test case 4: Arithmetic instruction
        Instruction = 32'h2A100001;  // Arithmetic operation
        #40;  // Wait for 40ns

        // Test case 5: Load from memory
        Instruction = 32'h52990000;  // Memory load operation
        #40;  // Wait for 40ns

        // Test case 6
        Instruction = 32'hC0000002; 
        #40;  // Wait for 40ns

        // Test case 6
        Instruction = 32'h641A0000; 
        #40;  // Wait for 40ns
        

        // Finish simulation
        $stop;
    end

endmodule

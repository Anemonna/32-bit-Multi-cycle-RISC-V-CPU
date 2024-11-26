`timescale 1ns / 1ps

module Datapath_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [4:0] opcode;
    reg [31:0] imm_ext;
    reg en_exe_pulse;
    reg en_pc_pulse;
    reg in2_muxcontrol;
    reg wv_muxcontrol;
    reg [3:0] Rd;
    reg [3:0] Rs;
    reg [3:0] Rt;
    reg [31:0] read_data;
    reg regwrite;

    // Outputs
    wire [31:0] ins_address;
    wire [1:0] flag;
    wire [31:0] read_value2;
    wire [31:0] alu_result;

    // Instantiate the Datapath module
    Datapath uut (
        .clk(clk),
        .reset(reset),
        .opcode(opcode),
        .imm_ext(imm_ext),
        .en_exe_pulse(en_exe_pulse),
        .en_pc_pulse(en_pc_pulse),
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

    // Clock generation (100MHz clock => 10ns period)
    always #5 clk = ~clk;

    // Testbench procedure
    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 0;
        opcode = 0;
        imm_ext = 0;
        en_exe_pulse = 0;
        en_pc_pulse = 0;
        in2_muxcontrol = 0;
        wv_muxcontrol = 0;
        Rd = 0;
        Rs = 0;
        Rt = 0;
        read_data = 0;
        regwrite = 0;

        // Apply reset
        reset = 1;
        #20;  // Wait 20ns for reset to propagate
        reset = 0;

        // Apply test vector 1
        opcode = 5'b01111;   // Sample opcode
        imm_ext = 32'h00000011;
        en_exe_pulse = 1;
        en_pc_pulse = 1;
        in2_muxcontrol = 0;  // Select immediate extension for ALU input 2
        wv_muxcontrol = 0;   // Select ALU result for write back
        Rd = 4'b0001;        // Write to register 1
        Rs = 4'b0000;        // Read from register 2
        Rt = 4'b0000;        // Read from register 3
        read_data = 32'h12345678;
        regwrite = 1;

        // Wait for a few cycles
        #50;

        // Apply test vector 2
        opcode = 5'b00010;   // Sample opcode
        imm_ext = 32'h00000000;
        en_exe_pulse = 1;    // Disable execution pulse
        en_pc_pulse = 0;
        in2_muxcontrol = 1;  // Select register 2 for ALU input 2
        wv_muxcontrol = 1;   // Select read data for write back
        Rd = 4'b0010;        // Write to register 4
        Rs = 4'b0001;        // Read from register 5
        Rt = 4'b0001;        // Read from register 6
        read_data = 32'h87654321;
        regwrite = 1;

        // Wait for a few cycles
        #50;

        // More test vectors can be applied here for additional scenarios...

        // Finish the simulation
        $finish;
    end

endmodule

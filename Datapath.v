`timescale 1ns / 1ps

module Datapath (clk, reset, opcode, imm_ext, en_exe_pulse, in2_muxcontrol, wv_muxcontrol, Rd, Rs, Rt, read_data, regwrite, ins_address, flag, read_value2, alu_result);

    input clk, reset;
    input wire [4:0] opcode;                // get opcode from CU
    input wire [31:0] imm_ext;              // get imm_ext from CU
    input wire en_exe_pulse;                // from CU
    input wire in2_muxcontrol;              // choose alu_reg2(1) or imm_ext(0) from CU
    input wire wv_muxcontrol;               // choose read_data(1)(data memory) or alu_result(0) (from CU)
    input wire [3:0] Rd;                    // target reg from CU
    input wire [3:0] Rs, Rt;                // source reg from CU
    input wire [31:0] read_data;            // [EXTERNAL] from Data memory => CPU => Datapath => MUX_Mem
    input wire regwrite;                    // from CU => Register file

    output wire [31:0] ins_address;         // [EXTERNAL] from PC => Datapath => CPU => Ins_Memory
    output wire [1:0] flag;                 // detect conditions (from ALU => CU)  
    output wire [31:0] alu_result;          // from ALU => MUX_Mem or ALU => Datapath => CPU => Data_Memory (addr)
    output wire [31:0] read_value2;         // [EXTERNAL] from register file => Datapath => CPU => Data_Memory (data)

    // Define internal wire signals
    wire [31:0] alu_in2;                    // Second input (from MUX_Alu => ALU)
    wire [31:0] read_value1;                // First input (from Register file => ALU)
    wire [31:0] write_value;                // from MUX_Mem => Register file (not use)

    reg [31:0] alu_result_reg;
    reg [1:0] flag_reg;

    // Instantiate PC
    PC PC_inst(
        .clk(clk), 
        .reset(reset), 
        .opcode(opcode), 
        .imm_ext(imm_ext),
        .flag(flag_reg), 
        .en_exe_pulse(en_exe_pulse),
        .ins_address(ins_address)
    );

    // Instantiate MUX_Alu
    MUX_Alu MUX_Alu_inst (
        .in2_muxcontrol(in2_muxcontrol),
        .alu_reg2(read_value2),
        .imm_ext(imm_ext),
        .alu_in2(alu_in2)
    );

    // Instantiate ALU
    ALU ALU_inst (
        .reset(reset),
        .alu_control(opcode),
        .alu_in1(read_value1),
        .alu_in2(alu_in2),
        .en_exe_pulse(en_exe_pulse),
        .alu_result(alu_result),
        .flag(flag),
        .alu_result_reg(alu_result_reg),
        .flag_reg(flag_reg)
    );

    // Instantiate MUX_Mem
    MUX_Mem MUX_Mem_inst (
        .wv_muxcontrol(wv_muxcontrol),
        .read_data(read_data),
        .alu_result(alu_result),
        .write_value(write_value)
    );

    // Instantiate Register_File
    Register_File Register_File_inst (
        .reset(reset),
        .Rs(Rs),
        .Rt(Rt),
        .Rd(Rd),
        .write_value(write_value),
        .regwrite(regwrite),
        .read_value1(read_value1),
        .read_value2(read_value2)
    );

    always @(posedge clk) begin
        alu_result_reg <= alu_result;
        flag_reg <= flag;
    end

endmodule

`timescale 1ns / 1ps

module PC_IF (
    input clk,
    input reset,
    input [4:0] opcode,
    input [31:0] imm_ext,
    input [1:0] flag,
    input jump,
    output [31:0] Instruction,
    output [31:0] pc
);
    wire [31:0] address;  // PC模块的输出，作为指令模块的输入

    // 实例化 Instruction_Fetch 模块
    Instruction_Fetch IF (
        .clk(clk),
        .reset(reset),
        .address(address),
        .Instruction(Instruction),
        .pc(pc)
    );

    // 实例化 PC 模块
    PC PC_Module (
        .clk(clk),
        .reset(reset),
        .opcode(opcode),
        .pc(pc),
        .imm_ext(imm_ext),
        .flag(flag),
        .jump(jump),
        .address(address)
    );

endmodule


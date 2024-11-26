`timescale 1ns / 1ps

module JB_tb;

    reg clk, reset;                  // 复位信号
    reg [4:0] opcode;                // 操作码
    reg [31:0] pc_current;           // 当前PC值
    reg [31:0] imm_ext;              // 扩展后的立即数
    reg [1:0] flag;                  // 标志位
    wire [31:0] branch_target;       // 分支目标地址输出
    wire jump;                       // 跳转信号输出

    // Instantiate the JB module
    JB u_JB (
        .clk(clk),
        .reset(reset),
        .opcode(opcode),
        .pc_current(pc_current),
        .imm_ext(imm_ext),
        .flag(flag),
        .branch_target(branch_target),
        .jump(jump)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        opcode = 5'b0;
        pc_current = 32'd100;   // 假设当前PC值为100
        imm_ext = 32'd4;        // 假设立即数扩展为4
        flag = 2'b00;           // 初始标志位

        // Apply reset
        #5 reset = 0;          // 激活复位

        #10

        opcode = 5'b11000;      // JMP 指令
        #20;
        $display("JMP: pc_current = %d, imm_ext = %d, branch_target = %d, jump = %b", pc_current, imm_ext, branch_target, jump);

        opcode = 5'b11001;      // BEQ 指令
        flag = 2'b01;           // 设置标志位为01
        #10;
        $display("BEQ: pc_current = %d, imm_ext = %d, branch_target = %d, jump = %b", pc_current, imm_ext, branch_target, jump);

        opcode = 5'b11010;      // BL 指令
        flag = 2'b10;           // 设置标志位为10
        #10;
        $display("BL: pc_current = %d, imm_ext = %d, branch_target = %d, jump = %b", pc_current, imm_ext, branch_target, jump);

        opcode = 5'b11011;      // BG 指令
        flag = 2'b11;           // 设置标志位为11
        #10;
        $display("BG: pc_current = %d, imm_ext = %d, branch_target = %d, jump = %b", pc_current, imm_ext, branch_target, jump);

        opcode = 5'b11001;      // BEQ 指令
        flag = 2'b00;           // 设置标志位为00 (flag != 01)
        #10;
        $display("BEQ (condition false): pc_current = %d, imm_ext = %d, branch_target = %d, jump = %b", pc_current, imm_ext, branch_target, jump);

        // End simulation
        #10 $finish;
    end

endmodule

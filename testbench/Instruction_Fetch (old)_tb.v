`timescale 1ns / 1ps

module Instruction_Fetch_tb;

    // 输入信号
    reg clk;
    reg reset;
    reg [31:0] branch_target;
    reg jump;

    // 输出信号
    wire [31:0] Instruction;

    // 实例化被测模块
    Instruction_Fetch u_Instruction_Fetch (
        .clk(clk),
        .reset(reset),
        .branch_target(branch_target),
        .jump(jump),
        .Instruction(Instruction),
        .pc(pc)
    );

    // 时钟信号生成，每5ns翻转一次，周期为10ns
    always #5 clk = ~clk;

    // 初始化测试
    initial begin
        // 初始化信号
        clk = 0;
        reset = 1;
        branch_target = 32'd0;
        jump = 0;

        // 在第10ns时取消复位，开始正常取指令
        #25 reset = 0;

        // 查看每条指令的值（从PC=0开始）
        #20;
        $display("Instruction at PC=0: %h", Instruction);  // 应该是Memory[0]的值
        #20;
        $display("Instruction at PC=4: %h", Instruction);  // 应该是Memory[4]的值
        #20;
        $display("Instruction at PC=8: %h", Instruction);  // 应该是Memory[8]的值

        // 测试跳转指令，将PC跳转到某个分支目标地址
        #20;
        jump = 1;
        branch_target = 32'd16; // 跳转到PC=16
        #20;
        jump = 0;  // 跳转之后，继续正常取指令
        $display("Instruction at PC=16 after jump: %h", Instruction);  // 应该是Memory[16]的值

        // 查看跳转后下一条指令
        #20;
        $display("Instruction at PC=20: %h", Instruction);  // 应该是Memory[20]的值

        // 再继续取几条指令
        #20;
        $display("Instruction at PC=24: %h", Instruction);  // 应该是Memory[24]的值
        #20;
        $display("Instruction at PC=28: %h", Instruction);  // 应该是Memory[28]的值

        // 停止仿真
        #50;
        $finish;
    end

endmodule

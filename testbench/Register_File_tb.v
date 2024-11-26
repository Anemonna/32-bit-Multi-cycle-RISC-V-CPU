`timescale 1ns / 1ps

module Register_File_tb;

    reg clk, reset;                      // 时钟和复位信号
    reg [3:0] Rs, Rt, Rd;                // 寄存器选择信号
    reg [31:0] write_value;              // 写入寄存器的值
    reg regwrite;                        // 写使能信号
    wire [31:0] read_value1, read_value2;  // 读取的两个寄存器值

    // 实例化被测试的寄存器文件
    Register_File u_Register_File (
        .clk(clk),
        .reset(reset),
        .Rs(Rs),
        .Rt(Rt),
        .Rd(Rd),
        .write_value(write_value),
        .regwrite(regwrite),
        .read_value1(read_value1),
        .read_value2(read_value2)
    );

    // 产生时钟信号
    always #5 clk = ~clk;

    initial begin
        // 初始化信号
        clk = 0;
        reset = 1;
        Rs = 4'b0000;
        Rt = 4'b0001;
        Rd = 4'b0000;
        write_value = 32'h00000000;
        regwrite = 0;

        // 复位寄存器文件
        #10 reset = 0;
        #15

        // 写入寄存器测试
        Rd = 4'b0010; write_value = 32'hAAAA_BBBB; regwrite = 1;
        #10
        Rd = 4'b0011; write_value = 32'hCCCC_DDDD; regwrite = 1;

        // 读寄存器测试
        #10 regwrite = 0; Rs = 4'b0010; Rt = 4'b0011;
        #10 $display("Read from Rs (R2): %h, Rt (R3): %h", read_value1, read_value2);

        // 写入和读取更多寄存器
        #10 Rd = 4'b0100; write_value = 32'h1234_5678; regwrite = 1;
        #10 Rd = 4'b0101; write_value = 32'h9876_5432; regwrite = 1;
        #10 regwrite = 0; Rs = 4'b0100; Rt = 4'b0101;
        #10 $display("Read from Rs (R4): %h, Rt (R5): %h", read_value1, read_value2);

        // 尝试写入寄存器 0 (应该无效)
        #10 Rd = 4'b0000; write_value = 32'hDEAD_BEEF; regwrite = 1;
        #10 Rs = 4'b0000; Rt = 4'b0010; regwrite = 0;
        #10 $display("Read from Rs (R0, should be 0): %h, Rt (R2): %h", read_value1, read_value2);

        // 结束仿真
        #20 $finish;
    end
endmodule

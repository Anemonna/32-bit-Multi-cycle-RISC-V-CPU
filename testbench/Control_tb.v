`timescale 1ns / 1ps

module Control_tb;

    reg [4:0] opcode;                // 操作码输入
    reg [1:0] flag;                  // 条件码输入
    wire [4:0] alu_control;          // ALU控制信号输出
    wire regwrite;                   // 寄存器写使能输出
    wire mem_store;                  // 存储使能输出
    wire mem_load;                   // 加载使能输出
    wire jump;                       // 跳转信号输出

    // 实例化Control模块
    Control u_Control (
        .opcode(opcode),
        .flag(flag),
        .alu_control(alu_control),
        .regwrite(regwrite),
        .mem_store(mem_store),
        .mem_load(mem_load),
        .jump(jump)
    );

    initial begin
        // 初始化
        opcode = 5'b00000;  // ADD
        flag = 2'b00;       // 无条件
        #10;

        // 测试 ADD 指令
        opcode = 5'b00000;  // ADD
        #10;
        $display("Opcode: %b, ALU Control: %b, RegWrite: %b, Mem Store: %b, Mem Load: %b, Jump: %b", 
                 opcode, alu_control, regwrite, mem_store, mem_load, jump);

        // 测试 SUB 指令 
        opcode = 5'b00010;  // SUB
        #10;
        $display("Opcode: %b, ALU Control: %b, RegWrite: %b, Mem Store: %b, Mem Load: %b, Jump: %b", 
                 opcode, alu_control, regwrite, mem_store, mem_load, jump);

        // 测试 LOAD 指令
        opcode = 5'b10110;  // LOAD
        flag = 2'b00;       // 无条件
        #10;
        $display("Opcode: %b, ALU Control: %b, RegWrite: %b, Mem Store: %b, Mem Load: %b, Jump: %b", 
                 opcode, alu_control, regwrite, mem_store, mem_load, jump);

        // 测试 STORE 指令
        opcode = 5'b10111;  // STORE
        #10;
        $display("Opcode: %b, ALU Control: %b, RegWrite: %b, Mem Store: %b, Mem Load: %b, Jump: %b", 
                 opcode, alu_control, regwrite, mem_store, mem_load, jump);

        // 测试跳转指令
        opcode = 5'b11000;  // JMP
        #10;
        $display("Opcode: %b, ALU Control: %b, RegWrite: %b, Mem Store: %b, Mem Load: %b, Jump: %b", 
                 opcode, alu_control, regwrite, mem_store, mem_load, jump);

        // 测试条件跳转指令
        opcode = 5'b11001;  // BEQ
        flag = 2'b01;       // 条件满足
        #10;
        $display("Opcode: %b, ALU Control: %b, RegWrite: %b, Mem Store: %b, Mem Load: %b, Jump: %b", 
                 opcode, alu_control, regwrite, mem_store, mem_load, jump);

        // 测试无效操作码
        opcode = 5'b11111;  // Invalid opcode
        #10;
        $display("Opcode: %b, ALU Control: %b, RegWrite: %b, Mem Store: %b, Mem Load: %b, Jump: %b", 
                 opcode, alu_control, regwrite, mem_store, mem_load, jump);

        // 结束仿真
        $finish;
    end

endmodule

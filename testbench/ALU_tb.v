`timescale 1ns / 1ps

module ALU_tb;

    reg clk;
    reg reset;
    reg [4:0] alu_control;
    reg [31:0] alu_in1;
    reg [31:0] alu_in2;
    wire [31:0] alu_result;
    wire [1:0] flag;
    
    ALU u_ALU (                 // Instantiate the ALU module
        .clk(clk),
        .reset(reset),
        .alu_control(alu_control),
        .alu_in1(alu_in1),
        .alu_in2(alu_in2),
        .alu_result(alu_result),
        .flag(flag)
    );

    
    always #5 clk = ~clk;       // Clock generation

    initial begin
                                // Initialize Inputs
        clk = 0;
        reset = 1;              // Start with reset active
        alu_control = 5'b00000;
        alu_in1 = 32'b0;
        alu_in2 = 32'b0;
        
        #5 reset = 0;           // Apply reset

        // Test ADD Operation
        alu_control = 5'b00010; // ADD operation
        alu_in1 = 32'd15;
        alu_in2 = 32'd10;
        #20;
        $display("ADD: alu_in1 = %d, alu_in2 = %d, alu_result = %d, flag = %b", alu_in1, alu_in2, alu_result, flag);

        // Test SUB Operation
        alu_control = 5'b00100; // SUB operation
        alu_in1 = 32'd20;
        alu_in2 = 32'd5;
        #20;
        $display("SUB: alu_in1 = %d, alu_in2 = %d, alu_result = %d, flag = %b", alu_in1, alu_in2, alu_result, flag);

        // Test MUL Operation
        alu_control = 5'b00110; // MUL operation
        alu_in1 = 32'd7;
        alu_in2 = 32'd6;
        #20;
        $display("MUL: alu_in1 = %d, alu_in2 = %d, alu_result = %d, flag = %b", alu_in1, alu_in2, alu_result, flag);

        // Test AND Operation
        alu_control = 5'b01010; // AND operation
        alu_in1 = 32'hFF00FF00;
        alu_in2 = 32'h00FF00FF;
        #20;
        $display("AND: alu_in1 = %h, alu_in2 = %h, alu_result = %h, flag = %b", alu_in1, alu_in2, alu_result, flag);

        // Test OR Operation
        alu_control = 5'b01011; // OR operation
        alu_in1 = 32'hF0F0F0F0;
        alu_in2 = 32'h0F0F0F0F;
        #20;
        $display("OR: alu_in1 = %h, alu_in2 = %h, alu_result = %h, flag = %b", alu_in1, alu_in2, alu_result, flag);

        // Test MOD Operation
        alu_control = 5'b01000; // MOD operation
        alu_in1 = 32'd25;
        alu_in2 = 32'd4;
        #20;
        $display("MOD: alu_in1 = %d, alu_in2 = %d, alu_result = %d, flag = %b", alu_in1, alu_in2, alu_result, flag);

        // Test LSTF Operation
        alu_control = 5'b11100; // LSTF operation
        alu_in1 = 32'd25;
        alu_in2 = 32'd2;
        #20;
        $display("LSTF: alu_in1 = %d, alu_in2 = %d, alu_result = %d, flag = %b", alu_in1, alu_in2, alu_result, flag);

        // Test RSTF Operation
        alu_control = 5'b11101; // RSTF operation
        alu_in1 = 32'd24;
        alu_in2 = 32'd2;
        #20;
        $display("RSTF: alu_in1 = %d, alu_in2 = %d, alu_result = %d, flag = %b", alu_in1, alu_in2, alu_result, flag);

        // End simulation
        $finish;
    end

endmodule

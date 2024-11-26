`timescale 1ns / 1ps

module MOV_tb;

    reg clk;
    reg reset;
    reg [4:0] alu_control;
    reg [31:0] alu_in;
    reg [1:0] flag;

    wire [31:0] alu_result;

    MOV u_MOV (
        .clk(clk),
        .reset(reset),
        .alu_control(alu_control),
        .alu_in(alu_in),
        .flag(flag),
        .alu_result(alu_result)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        alu_control = 5'b00000;
        alu_in = 32'b0;
        flag = 2'b00;

        #5 reset = 0;

        alu_control = 5'b01110; // Test MOV Operation
        alu_in = 32'd42;
        flag = 2'b00; 
        #10;
        $display("MOV: alu_in = %d, alu_result = %d", alu_in, alu_result);

        alu_control = 5'b10000; // MOVEQ operation (flag == 01)
        alu_in = 32'd55;
        flag = 2'b01;
        #10;
        $display("MOVEQ: flag = %b, alu_in = %d, alu_result = %d", flag, alu_in, alu_result);

        alu_in = 32'd88;        // Test MOVEQ Operation (flag != 01)
        flag = 2'b00;
        #10;
        $display("MOVEQ (flag != 01): flag = %b, alu_in = %d, alu_result = %d", flag, alu_in, alu_result);

        alu_control = 5'b10010; // MOVL operation (flag == 10)
        alu_in = 32'd99;
        flag = 2'b10;
        #10;
        $display("MOVL: flag = %b, alu_in = %d, alu_result = %d", flag, alu_in, alu_result);

        alu_control = 5'b10100; // MOVG operation (flag == 11)
        alu_in = 32'd77;
        flag = 2'b11;
        #10;
        $display("MOVG: flag = %b, alu_in = %d, alu_result = %d", flag, alu_in, alu_result);

        alu_control = 5'b01111; // MOVI operation
        alu_in = 32'd123;
        flag = 2'b00;
        #10;
        $display("MOVI: alu_in = %d, alu_result = %d", alu_in, alu_result);

        alu_control = 5'b10001; // MOVIEQ operation (flag == 01)
        alu_in = 32'd555;
        flag = 2'b01;
        #10;
        $display("MOVIEQ: flag = %b, alu_in = %d, alu_result = %d", flag, alu_in, alu_result);

        alu_control = 5'b10011; // MOVIL operation (flag == 10)
        alu_in = 32'd444;
        flag = 2'b10;
        #10;
        $display("MOVIL: flag = %b, alu_in = %d, alu_result = %d", flag, alu_in, alu_result);

        alu_control = 5'b10101; // MOVIG operation (flag == 11)
        alu_in = 32'd777;
        flag = 2'b11;
        #10; 
        $display("MOVIG: flag = %b, alu_in = %d, alu_result = %d", flag, alu_in, alu_result);

        $finish;
    end

endmodule

/*
ALU Control lines | Function
-----------------------------
        5'b00010    ADD
        5'b00011    ADDI
        5'b00100    SUB 
        5'b00101    SUBI
        5'b00110    MUL 
        5'b00111    MULI
        5'b01000    MOD 
        5'b01001    MODI
        
        5'b01010    AND
        5'b01011    OR
        5'b01100    XOR
        5'b01101    NOT
        5'b11010    LSFT
        5'b11100    RSFT

        5'b01110    MOV
        5'b10000    MOVEQ
        5'b10010    MOVL
        5'b10100    MOVG
        5'b01111    MOVI
        5'b10001    MOVIEQ
        5'b10011    MOVIL
        5'b10101    MOVIG

        5'b10110    LAD
        5'b10111    STR
-----------------------------
*/

`timescale 1ns / 1ps

module ALU(reset, alu_control, alu_in1, alu_in2, en_exe_pulse, alu_result, flag, alu_result_reg, flag_reg);

    input reset;
    input wire [4:0] alu_control;
    input wire [31:0] alu_in1, alu_in2;
    input wire en_exe_pulse;

    input wire [31:0] alu_result_reg;
    input wire [1:0] flag_reg;
    output reg [31:0] alu_result;
    output reg [1:0] flag;             // compare alu_result and 0

    parameter ADD = 5'b00010;           // add
    parameter ADDI = 5'b00011;
    parameter SUB = 5'b00100;           // substract
    parameter SUBI = 5'b00101;
    parameter MUL = 5'b00110;           // multiple
    parameter MULI = 5'b00111;
    parameter MOD = 5'b01000;           // mod
    parameter MODI = 5'b01001;
    
    parameter AND = 5'b01010;           // logic and
    parameter OR = 5'b01011;            // logic or
    parameter XOR = 5'b01100;           // logic xor
    parameter NOT = 5'b01101;           // logic not

    parameter LSFT = 5'b11100;          // logic shift left
    parameter RSFT = 5'b11101;          // logic shift right

    parameter LAD = 5'b10110;           // load
    parameter STR = 5'b10111;           // store

    parameter MOV = 5'b01110;           // MOV
    parameter MOVEQ = 5'b10000;         // MOVEQ
    parameter MOVL = 5'b10010;          // MOVL
    parameter MOVG = 5'b10100;          // MOVG
    parameter MOVI = 5'b01111;          // MOVI
    parameter MOVIEQ = 5'b10001;        // MOVIEQ
    parameter MOVIL = 5'b10011;         // MOVIL
    parameter MOVIG = 5'b10101;         // MOVIG

    always @(*) begin
        if (en_exe_pulse) begin
            case (alu_control)
                ADD, ADDI: begin
                    alu_result = alu_in1 + alu_in2;
                    //flag = 2'b00;
                end

                SUB, SUBI: begin
                    alu_result = alu_in1 - alu_in2;

                    if (reset) begin
                        flag = 2'b00;
                    end
                    else begin
                        if (alu_in1 > alu_in2) begin            //alu_in1 > alu_in2
                            flag = 2'b11;
                        end
                        else if (alu_in1 == alu_in2) begin      //alu_in1 = alu_in2
                            flag = 2'b01;
                        end
                        else begin                              //alu_in1 < alu_in2
                            flag = 2'b10;
                        end
                    end
                end

                MUL, MULI: begin
                    alu_result = alu_in1 * alu_in2;
                    //flag = 2'b00;
                end

                MOD, MODI: begin
                    alu_result = alu_in1 % alu_in2;
                    //flag = 2'b00;
                end

                AND: begin
                    alu_result = alu_in1 & alu_in2;
                    //flag = 2'b00;
                end

                OR: begin
                    alu_result = alu_in1 | alu_in2;
                    //flag = 2'b00;
                end

                XOR: begin
                    alu_result = alu_in1 ^ alu_in2;
                    //flag = 2'b00;
                end

                NOT: begin
                    alu_result = ~alu_in1;
                    //flag = 2'b00;
                end

                LSFT: begin
                    alu_result = alu_in1 << alu_in2;
                    //flag = 2'b00;
                end

                RSFT: begin
                    alu_result = alu_in1 >> alu_in2;
                    //flag = 2'b00;
                end

                LAD: begin
                    alu_result = alu_in1 + alu_in2;
                    //flag = 2'b00;
                end

                STR: begin
                    alu_result = alu_in1 + alu_in2;
                    //flag = 2'b00;
                end

                MOV, MOVI: begin
                    alu_result = alu_in2;
                    //flag = 2'b00;
                end

                MOVEQ, MOVIEQ: begin
                    if(flag_reg == 2'b01) alu_result = alu_in2;
                    else alu_result = alu_result_reg;
                end

                MOVL, MOVIL: begin
                    if(flag_reg == 2'b10) alu_result = alu_in2;
                    else alu_result = alu_result_reg;
                end

                MOVG, MOVIG: begin
                    if(flag_reg == 2'b11) alu_result = alu_in2;
                    else alu_result = alu_result_reg;
                end

                LAD, STR: begin
                    alu_result = alu_in1 + (alu_in2 << 2);     // calculate address
                end
            endcase
        end
        else begin
            alu_result = alu_result_reg;
            flag = flag_reg;
        end
    end 

endmodule
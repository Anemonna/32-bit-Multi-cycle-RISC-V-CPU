`timescale 1ns / 1ps

/*
jump： 
            0: no jump
            1：jump
*/

module PC (clk, reset, opcode, imm_ext, flag, en_exe_pulse, ins_address);
    input clk, reset;
    input wire [4:0] opcode;
    input wire [31:0] imm_ext;
    input wire [1:0] flag;                                      // label for whether to jump
    input wire en_exe_pulse;                                    // exe pulse
    output reg [31:0] ins_address;                              // branch target
    
    parameter JMP = 5'b11000;
    parameter BEQ = 5'b11001;
    parameter BL = 5'b11010;
    parameter BG = 5'b11011;

    always @(posedge clk) begin
        if (reset) begin
            ins_address <= 32'b0;                               // initalise
        end
        else begin
            if(en_exe_pulse) begin
                case (opcode)
                JMP: begin
                    ins_address <= imm_ext;   
                end

                BEQ: begin
                    if (flag == 2'b01) begin
                        ins_address <= imm_ext;  
                    end
                    else begin
                        ins_address <= ins_address + 32'd4;     // Otherwise PC is increase 4
                    end
                end

                BL: begin
                    if (flag == 2'b10) begin
                        ins_address <= imm_ext;  
                    end
                    else begin
                        ins_address <= ins_address + 32'd4;     // Otherwise PC is increase 4
                    end
                end

                BG: begin
                    if (flag == 2'b11) begin
                        ins_address <= imm_ext;  
                    end
                    else begin
                        ins_address <= ins_address + 32'd4;     // Otherwise PC is increase 4
                    end
                end
                default: begin
                    ins_address <= ins_address + 32'd4;         // keep steady
                end
                endcase
            end
        end    
    end
endmodule

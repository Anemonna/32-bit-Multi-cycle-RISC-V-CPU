`timescale 1ns / 1ps

// in2_muxcontrol = 1: alu_reg2;
// in2_muxcontrol = 0: imm_ext;

module MUX_Alu (in2_muxcontrol, alu_reg2, imm_ext, alu_in2);
    input wire in2_muxcontrol;
    input wire [31:0] alu_reg2, imm_ext;
    output wire [31:0] alu_in2;
    
    assign alu_in2 = (in2_muxcontrol) ? alu_reg2 : imm_ext;     // judge reg or imm
   
endmodule
`timescale 1ns / 1ps

// wv_muxcontrol = 1: read_data;
// wv_muxcontrol = 0: alu_result;

module MUX_Mem (wv_muxcontrol, read_data, alu_result, write_value);
    input wire wv_muxcontrol;
    input wire [31:0] read_data, alu_result;
    output wire [31:0] write_value;
    
    assign write_value = (wv_muxcontrol) ? read_data : alu_result;     // judge read data or alu_result
   
endmodule
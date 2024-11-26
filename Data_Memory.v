`timescale 1ns / 1ps

module Data_Memory(clk, reset, data_address, write_data, mem_store, mem_load, en_exe_pulse, read_data);

    input clk, reset;

    input wire [31:0] data_address;
    input wire [31:0] write_data;
    input wire mem_store, mem_load;
    input wire en_exe_pulse;
    output reg [31:0] read_data;

    reg [7:0] data_memory [0:31];  // 256 * 7-bit memory

    // Write & store operation
    always @(*) begin
        if (reset) begin
            data_memory[data_address[7:0]] = 8'b0;
            data_memory[data_address[7:0]+1] = 8'b0;
            data_memory[data_address[7:0]+2] = 8'b0;
            data_memory[data_address[7:0]+3] = 8'b0;
        end
        else if (en_exe_pulse && mem_store) begin
            data_memory[data_address[7:0]] = write_data[7:0];          // Store byte 0
            data_memory[data_address[7:0]+1] = write_data[15:8];       // Store byte 1
            data_memory[data_address[7:0]+2] = write_data[23:16];      // Store byte 2
            data_memory[data_address[7:0]+3] = write_data[31:24];      // Store byte 3
        end
    end

    // Read & load operation
    always @(*) begin
        if (en_exe_pulse && mem_load) begin
            read_data = {data_memory[data_address[7:0]+3], data_memory[data_address[7:0]+2], data_memory[data_address[7:0]+1], data_memory[data_address[7:0]]};
        end
    end

    ila_2 u_ila_2 (
	.clk(clk), // input wire clk

    .probe0(data_memory[0]), // input wire [7:0] probe0
    .probe1(data_memory[1]), // input wire [7:0] probe1
    .probe2(data_memory[2]), // input wire [7:0] probe2
    .probe3(data_memory[3]), // input wire [7:0] probe3
    .probe4(data_memory[4]), // input wire [7:0] probe4
    .probe5(data_memory[5]), // input wire [7:0] probe5
    .probe6(data_memory[6]), // input wire [7:0] probe6
    .probe7(data_memory[7]), // input wire [7:0] probe7
    .probe8(data_memory[8]), // input wire [7:0] probe8
    .probe9(data_memory[9]), // input wire [7:0] probe9
    .probe10(data_memory[10]), // input wire [7:0] probe10
    .probe11(data_memory[11]), // input wire [7:0] probe11
    .probe12(data_memory[12]), // input wire [7:0] probe12
    .probe13(data_memory[13]), // input wire [7:0] probe13
    .probe14(data_memory[14]), // input wire [7:0] probe14
    .probe15(data_memory[15]), // input wire [7:0] probe15
    .probe16(data_memory[16]), // input wire [7:0] probe16
    .probe17(data_memory[17]), // input wire [7:0] probe17
    .probe18(data_memory[18]), // input wire [7:0] probe18
    .probe19(data_memory[19]), // input wire [7:0] probe19
    .probe20(data_memory[20]), // input wire [7:0] probe20
    .probe21(data_memory[21]), // input wire [7:0] probe21
    .probe22(data_memory[22]), // input wire [7:0] probe22
    .probe23(data_memory[23]), // input wire [7:0] probe23
    .probe24(data_memory[24]), // input wire [7:0] probe24
    .probe25(data_memory[25]), // input wire [7:0] probe25
    .probe26(data_memory[26]), // input wire [7:0] probe26
    .probe27(data_memory[27]), // input wire [7:0] probe27
    .probe28(data_memory[28]), // input wire [7:0] probe28
    .probe29(data_memory[29]), // input wire [7:0] probe29
    .probe30(data_memory[30]), // input wire [7:0] probe30
    .probe31(data_memory[31]), // input wire [7:0] probe31
    .probe32(reset)            // input wire probe32
);

    initial begin
        data_memory[3]  <= 8'h00;
        data_memory[2]  <= 8'h00;
        data_memory[1]  <= 8'h00;
        data_memory[0]  <= 8'h00;

        data_memory[7]  <= 8'h00;
        data_memory[6]  <= 8'h00;
        data_memory[5]  <= 8'h00;
        data_memory[4]  <= 8'h00;

        data_memory[11]  <= 8'h00;
        data_memory[10]  <= 8'h00;
        data_memory[9]  <= 8'h00;
        data_memory[8]  <= 8'h00;

        data_memory[15]  <= 8'h00;
        data_memory[14]  <= 8'h00;
        data_memory[13]  <= 8'h00;
        data_memory[12]  <= 8'h00;

        data_memory[19]  <= 8'h00;
        data_memory[18]  <= 8'h00;
        data_memory[17]  <= 8'h00;
        data_memory[16]  <= 8'h00;

        data_memory[23]  <= 8'h00;
        data_memory[22]  <= 8'h00;
        data_memory[21]  <= 8'h00;
        data_memory[20]  <= 8'h00;

        data_memory[27]  <= 8'h00;
        data_memory[26]  <= 8'h00;
        data_memory[25]  <= 8'h00;
        data_memory[24]  <= 8'h00;

        data_memory[31]  <= 8'h00;
        data_memory[30]  <= 8'h00;
        data_memory[29]  <= 8'h00;
        data_memory[28]  <= 8'h00;
    end

endmodule
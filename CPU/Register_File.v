`timescale 1ns / 1ps

module Register_File (reset, Rs, Rt, Rd, write_value, regwrite, read_value1, read_value2);
    input reset;
    input wire [3:0] Rs, Rt;                                    // read in signal
    input wire [3:0] Rd;                                        // write out signal
    input wire [31:0] write_value;
    input wire regwrite;
    output reg [31:0] read_value1, read_value2;

    reg [31:0] Register [0:15];                                 // Defines 15 32-bit registers
    integer i;

    always @(*) begin
        if (reset) begin
            for (i = 0; i < 16; i = i + 1) begin
                Register[i] = 32'b0;                           // reset all regs
            end
        end else if (regwrite && Rd != 4'b0000) begin
            Register[Rd] = write_value;                        // Write data when (regwrite ==1 & Rd != 0).
        end
    end

    always @(*) begin
        read_value1 = Register[Rs];                             // Read value from Rs
        read_value2 = Register[Rt];                             // Read value from Rt
    end

endmodule

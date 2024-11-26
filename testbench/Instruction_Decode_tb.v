`timescale 1ns / 1ps

module Instruction_Decode_tb;

    // Inputs
    reg [31:0] instruction;

    // Outputs
    wire [4:0] opcode, alu_control;
    wire [3:0] Rd, Rs, Rt;
    wire [14:0] imm;
    wire [31:0] imm_ext;

    // Instantiate the Unit Under Test (UUT)
    Instruction_Decode u_Instruction_Decode (
        .instruction(instruction),
        .opcode(opcode),
        .alu_control(alu_control),
        .Rd(Rd),
        .Rs(Rs),
        .Rt(Rt),
        .imm(imm),
        .imm_ext(imm_ext)
    );

    initial begin
        // Initialize Inputs
        instruction = 32'b0;

        #10;

        // Test case 1: Example instruction 0x00940333
        instruction = 32'b00000000010010000111000000110011; // opcode: 00000, Rd: 0000, Rs: 0001, Rt: 0010, imm: 00000000000000
        #10;
        $display("Test Case 1:");
        $display("Instruction: %b, Opcode: %b, Rd: %b, Rs: %b, Rt: %b, imm: %b, imm_ext: %b", 
                 instruction, opcode, Rd, Rs, Rt, imm, imm_ext);

        // Test case 2: Example instruction 0x413903b3
        instruction = 32'b01000001001110010000001110110011; // opcode: 00001, Rd: 0011, Rs: 0010, Rt: 0011, imm: 00000000000000
        #10;
        $display("Test Case 2:");
        $display("Instruction: %b, Opcode: %b, Rd: %b, Rs: %b, Rt: %b, imm: %b, imm_ext: %b", 
                 instruction, opcode, Rd, Rs, Rt, imm, imm_ext);

        // Test case 3: Example instruction 0x035a02b3
        instruction = 32'b00000011010110100000001010110011; // opcode: 00000, Rd: 0010, Rs: 0101, Rt: 0010, imm: 00000000000000
        #10;
        $display("Test Case 3:");
        $display("Instruction: %b, Opcode: %b, Rd: %b, Rs: %b, Rt: %b, imm: %b, imm_ext: %b", 
                 instruction, opcode, Rd, Rs, Rt, imm, imm_ext);

        #10;
        $finish;
    end
endmodule

module Control_Unit_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [1:0] flag;
    reg [31:0] Instruction;

    // Outputs
    wire [4:0] opcode;
    wire [3:0] Rd, Rs, Rt;
    wire [31:0] imm_ext;
    wire in2_muxcontrol;
    wire wv_muxcontrol;
    wire [4:0] alu_control;
    wire regwrite;
    wire mem_load;
    wire mem_store;
    wire jump;
    wire en_fetch_pulse;
    wire en_exe_pulse;
    wire en_pc_pulse;

    // Instantiate the Control Unit
    Control_Unit u_Control_Unit (
        .clk(clk),
        .reset(reset),
        .flag(flag),
        .Instruction(Instruction),
        .opcode(opcode),
        .Rd(Rd),
        .Rs(Rs),
        .Rt(Rt),
        .imm_ext(imm_ext),
        .in2_muxcontrol(in2_muxcontrol),
        .wv_muxcontrol(wv_muxcontrol),
        .alu_control(alu_control),
        .regwrite(regwrite),
        .mem_load(mem_load),
        .mem_store(mem_store),
        .jump(jump),
        .en_fetch_pulse(en_fetch_pulse),
        .en_exe_pulse(en_exe_pulse),
        .en_pc_pulse(en_pc_pulse)
    );

    // Clock Generation
    always #5 clk = ~clk;  // 100MHz clock (10ns period)

    // Testbench procedure
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 0;
        flag = 0;
        Instruction = 0;

        // Reset the control unit
        reset = 1;
        #10;   // Wait for 10ns
        reset = 0;
        #5;

        // Test instructions with correct 32-bit width
        Instruction = 32'h78800003;  // Sample instruction 1
        #40;

        Instruction = 32'h79000004;  // Sample instruction 2
        #40;

        Instruction = 32'h11890000;  // Sample instruction 3
        #40;

        Instruction = 32'h2A100001;  // Sample instruction 4
        #40;

        Instruction = 32'hC0000002;  // Sample instruction 5
        #40;

        Instruction = 32'h52990000;  // Sample instruction 5
        #40;

        // Finish simulation
        $stop;
    end
endmodule

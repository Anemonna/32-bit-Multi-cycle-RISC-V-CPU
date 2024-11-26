`timescale 1ns / 1ps

module Device_tb;

    // Inputs
    reg clk;
    reg reset;

    // Outputs
    wire [31:0] Instruction;
    wire [31:0] read_data;
    wire mem_load;
    wire mem_store;
    wire [31:0] data_address;
    wire [31:0] read_value2;
    wire [31:0] alu_result;
    wire [31:0] ins_address;
    wire en_fetch_pulse;
    wire en_exe_pulse;

    // Instantiate the Device
    Device u_Device (
        .clk(clk),
        .reset(reset),
        .ram()
    );

    // Clock generation (100 MHz clock = 10 ns period)
    always #5 clk = ~clk;

    // Monitor for output signals
    initial begin
        $monitor("Time = %0d ns, Instruction = %h, read_data = %h, mem_load = %b, mem_store = %b, data_address = %h, read_value2 = %h, alu_result = %h, ins_address = %h, en_fetch_pulse = %b, en_exe_pulse = %b", 
                 $time, 
                 u_Device.Instruction, 
                 u_Device.read_data, 
                 u_Device.mem_load, 
                 u_Device.mem_store, 
                 u_Device.data_address, 
                 u_Device.read_value2,
                 u_Device.alu_result,
                 u_Device.ins_address, 
                 u_Device.en_fetch_pulse, 
                 u_Device.en_exe_pulse            
        );
    end

    // Testbench procedure
    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 0;

        // Apply some reset again
        reset = 1;
        #10;
        reset = 0;
        //#5;

        // Run simulation for a while
        #800;

        // Finish simulation
        $stop;
    end

endmodule

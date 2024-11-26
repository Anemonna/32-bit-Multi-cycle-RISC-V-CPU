`timescale 1ns / 1ps

module RW_Memory_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [31:0] address;
    reg [31:0] write_data;
    reg mem_store;
    reg mem_load;

    // Outputs
    wire [31:0] read_data;

    // Instantiate the RW_Memory module
    RW_Memory u_RW_Memory (
        .clk(clk),
        .reset(reset),
        .address(address),
        .write_data(write_data),
        .mem_store(mem_store),
        .mem_load(mem_load),
        .read_data(read_data)
    );

    // Clock generation
    always #5 clk = ~clk;  // 10ns clock period

    initial begin
        // Initialize inputs
        clk = 0;
        reset = 0;
        address = 0;
        write_data = 0;
        mem_store = 0;
        mem_load = 0;

        // Reset the memory
        reset = 1;
        #10;
        reset = 0;
        #10;

        // Test Case 1: Write and then read from memory
        // Write 32'hDEADBEEF to address 0x04
        address = 32'h04;
        write_data = 32'hDEADBEEF;
        mem_store = 1;  // Enable store
        #10;
        mem_store = 0;  // Disable store
        #10;

        // Read from address 0x04
        mem_load = 1;  // Enable load
        address = 32'h04;
        #10;
        mem_load = 0;  // Disable load
        #10;

        // Check the read value in the simulation waveform or display
        $display("Read data from address 0x04: %h", read_data); // Should be 32'hDEADBEEF

        // Test Case 2: Write and then read from another address
        // Write 32'h12345678 to address 0x08
        address = 32'h08;
        write_data = 32'h12345678;
        mem_store = 1;  // Enable store
        #10;
        mem_store = 0;  // Disable store
        #10;

        // Read from address 0x08
        mem_load = 1;  // Enable load
        address = 32'h08;
        #10;
        mem_load = 0;  // Disable load
        #10;

        // Check the read value in the simulation waveform or display
        $display("Read data from address 0x08: %h", read_data); // Should be 32'h12345678

        // End simulation
        $finish;
    end

endmodule

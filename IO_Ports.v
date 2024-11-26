module IO_Ports(clk, reset, cpu_result, digit_select_sign, digit_select_hunth, digit_select_tenth, digit_select_unit, segment_select);

    input clk, reset;
    input [31:0] cpu_result;

    output reg digit_select_sign, digit_select_hunth, digit_select_tenth, digit_select_unit;
    output reg [7:0] segment_select;

    reg [31:0] cnt;
    reg clk_div2;
    reg [1:0] Current_state, Next_state;
    reg [31:0] cpu_result_reg;              // store cpu result
    reg [7:0] sign, hunth, tenth, unit;                  //binary coded decimals
    reg [7:0] HEX_sign, HEX_hunth, HEX_tenth, HEX_unit;

    parameter state_unit = 2'b00;           // drive unit segment
    parameter state_tenth = 2'b01;          // drive tenth segment
    parameter state_hunth = 2'b10;          // drive hunth segment
    parameter state_sign = 2'b11;           // drive sign segment

    initial begin
        Current_state = state_unit;
        Next_state = state_tenth;
    end

    //------------------------------frequency divider in output module
    always@ (posedge clk) begin
        if(reset) begin
            cnt <= 0;
            clk_div2 <= 0;
        end
        else if(cnt == 32'd20_0000) begin               //divide 100MHz to 500Hz
                clk_div2 <= ~clk_div2;
                cnt <= 0;
            end
        else begin
                cnt <= cnt + 1;
            end
    end

    //-------------------------------state loop
    always @ (posedge clk_div2) 
        begin
            Current_state <= Next_state;
        end

    //------------------------------state calculation and output result
    always @ (*) begin
        case (Current_state)
            state_unit: begin
                Next_state = state_tenth;
                digit_select_unit = 1;
                digit_select_tenth = 0;
                digit_select_hunth = 0;
                digit_select_sign = 0;
                segment_select = HEX_unit;
            end
            state_tenth: begin
                Next_state = state_hunth;
                digit_select_unit = 0;
                digit_select_tenth = 1;
                digit_select_hunth = 0;
                digit_select_sign = 0;
                segment_select = HEX_tenth;
            end
            state_hunth: begin
                Next_state = state_sign;
                digit_select_unit = 0;
                digit_select_tenth = 0;
                digit_select_hunth = 1;
                digit_select_sign = 0;
                segment_select = HEX_hunth;
            end
            state_sign: begin
                Next_state = state_unit;
                digit_select_unit = 0;
                digit_select_tenth = 0;
                digit_select_hunth = 0;
                digit_select_sign = 1;
                segment_select = HEX_sign;
            end
            default: begin
                Next_state = Current_state;
                digit_select_unit = 0;
                digit_select_tenth = 0;
                digit_select_hunth = 0;
                digit_select_sign = 0;
                segment_select = 8'b0;
            end
        endcase
    end

    //-------------------------------------------obtain result
    always @ (cpu_result) begin
        if (!cpu_result[31]) begin
            cpu_result_reg = cpu_result;
            sign = 8'b00000000;
            hunth = cpu_result_reg / 100;
            tenth = (cpu_result_reg - (hunth * 100)) / 10;
            unit = cpu_result_reg - (hunth * 100) - (tenth * 10);
        end
        else begin
            cpu_result_reg = ~cpu_result + 1;
            sign = 8'b00000010;
            hunth = cpu_result_reg / 100;
            tenth = (cpu_result_reg - (hunth * 100)) / 10;
            unit = cpu_result_reg - (hunth * 100) - (tenth * 10);
        end
        
        HEX_unit = BCD(unit);
        HEX_tenth = BCD(tenth);
        HEX_hunth = BCD(hunth);
        HEX_sign = sign;
    end

    //-----------------------------------------function to convert BCD to seven-segment display
    function [7:0] BCD (input [7:0] x); 
        case (x)
            0: BCD = 8'b11111100;
            1: BCD = 8'b01100000;
            2: BCD = 8'b11011010;
            3: BCD = 8'b11110010;
            4: BCD = 8'b01100110;
            5: BCD = 8'b10110110;
            6: BCD = 8'b10111110;
            7: BCD = 8'b11100000;
            8: BCD = 8'b11111110;
            9: BCD = 8'b11110110;
            default: BCD = 8'b00000000;
        endcase
    endfunction

endmodule
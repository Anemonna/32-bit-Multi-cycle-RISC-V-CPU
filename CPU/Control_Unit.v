`timescale 1ns / 1ps

module Control_Unit(clk, reset, Instruction, opcode, Rd, Rs, Rt, imm_ext, flag, in2_muxcontrol, wv_muxcontrol, alu_control, regwrite, mem_load, mem_store, en_fetch_pulse, en_exe_pulse);

//------------------------------------------------------------------------------ basic lines
    input clk, reset;
    input [1:0] flag;                   // 2-bit flag for condition operations
    input [31:0] Instruction;           // get Instruction

//------------------------------------------------------------------------------ decode para
    output reg [4:0] opcode;
    output reg [3:0] Rd, Rs, Rt;
    output reg [31:0] imm_ext;

//------------------------------------------------------------------------------ control word
    output reg in2_muxcontrol;          // op with reg (1) or imm (0)
    output reg wv_muxcontrol;           // op with read_data (1) or alu_result (0)
    output reg [4:0] alu_control;       // ALU control signal
    output reg regwrite;                // Control signal to enable register write
    output reg mem_store;               // Control signal to enable memory store
    output reg mem_load;                // Control signal to enable memory load

//------------------------------------------------------------------------------ pulse variables
    output reg en_fetch_pulse;
    reg en_fetch, en_fetch_reg;

    output reg en_exe_pulse;
    reg en_exe, en_exe_reg;

//------------------------------------------------------------------------------ state
    reg [4:0] Current_state, Next_state;// 2 states

    parameter Initial = 5'b00000;
    parameter Fetch = 5'b00001;
    parameter Decode = 5'b11110;
    parameter Write_back = 5'b11111;

    parameter ADD = 5'b00010;           // add
    parameter ADDI = 5'b00011;
    parameter SUB = 5'b00100;           // substract
    parameter SUBI = 5'b00101;
    parameter MUL = 5'b00110;           // multiple
    parameter MULI = 5'b00111;
    parameter MOD = 5'b01000;           // mod
    parameter MODI = 5'b01001;
    
    parameter AND = 5'b01010;           // logic and
    parameter OR = 5'b01011;            // logic or
    parameter XOR = 5'b01100;           // logic xor
    parameter NOT = 5'b01101;           // logic not

    parameter MOV = 5'b01110;           // MOV
    parameter MOVI = 5'b01111;          // MOVI
    parameter MOVEQ = 5'b10000;         // MOVEQ
    parameter MOVIEQ = 5'b10001;        // MOVIEQ
    parameter MOVL = 5'b10010;          // MOVL
    parameter MOVIL = 5'b10011;         // MOVIL
    parameter MOVG = 5'b10100;          // MOVG
    parameter MOVIG = 5'b10101;         // MOVIG

    parameter LAD = 5'b10110;           // load
    parameter STR = 5'b10111;           // store

    parameter JMP = 5'b11000;           // JMP
    parameter BEQ = 5'b11001;           // BEQ
    parameter BL = 5'b11010;            // BL
    parameter BG = 5'b11011;            // BG

    parameter LSFT = 5'b11100;          // logic shift left
    parameter RSFT = 5'b11101;          // logic shift right

//------------------------------------------------------------------------------ state changes with clk
    always @ (posedge clk) begin
	    if(reset)
		    Current_state <= Initial;
	    else 
		    Current_state <= Next_state;
    end

//------------------------------------------------------------------------------ state define
    always @ (*) begin
        case (Current_state)
//------------------------------------------------------------------------------ inital, fetch, decode, write back
		    Initial: begin
			    Next_state = Fetch;
		    end
		    Fetch: begin
			    Next_state = Decode;
		    end
		    Decode: begin
                case (opcode)
                    ADD:    Next_state = ADD;
                    ADDI:   Next_state = ADDI;
                    SUB:    Next_state = SUB;
                    SUBI:   Next_state = SUBI;
                    MUL:    Next_state = MUL;
                    MULI:   Next_state = MULI;
                    MOD:    Next_state = MOD;
                    MODI:   Next_state = MODI;
                    AND:    Next_state = AND;
                    OR:     Next_state = OR;
                    XOR:    Next_state = XOR;
                    NOT:    Next_state = NOT;
                    MOV:    Next_state = MOV;
                    MOVI:   Next_state = MOVI;
                    MOVEQ:  Next_state = MOVEQ;
                    MOVIEQ: Next_state = MOVIEQ;
                    MOVL:   Next_state = MOVL;
                    MOVIL:  Next_state = MOVIL;
                    MOVG:   Next_state = MOVG;
                    MOVIG:  Next_state = MOVIG;
                    LAD:    Next_state = LAD;
                    STR:    Next_state = STR;
                    JMP:    Next_state = JMP;
                    BEQ:    Next_state = BEQ;
                    BL:     Next_state = BL;
                    BG:     Next_state = BG;
                    LSFT:   Next_state = LSFT;
                    RSFT:   Next_state = RSFT;
                    default: Next_state = Current_state;
                endcase
			    Next_state = opcode;
		    end
            Write_back: begin
			    Next_state = Fetch;
		    end
//------------------------------------------------------------------------------ arithmetic op
            ADD: begin
                Next_state = Write_back;
            end
            ADDI: begin
                Next_state = Write_back;
            end
            SUB: begin
                Next_state = Write_back;
            end
            SUBI: begin
                Next_state = Write_back;
            end
            MUL: begin
                Next_state = Write_back;
            end
            MULI: begin
                Next_state = Write_back;
            end
            MOD: begin
                Next_state = Write_back;
            end
            MODI: begin
                Next_state = Write_back;
            end
//------------------------------------------------------------------------------ logic op
            AND: begin
                Next_state = Write_back;
            end
            OR: begin
                Next_state = Write_back;
            end
            XOR: begin
                Next_state = Write_back;
            end
            NOT: begin
                Next_state = Write_back;
            end
            LSFT: begin
                Next_state = Write_back;
            end
            RSFT: begin
                Next_state = Write_back;
            end
//------------------------------------------------------------------------------ MOV.etc op
            MOV: begin
                Next_state = Write_back;
            end
            MOVEQ: begin
                Next_state = Write_back;
            end
            MOVL: begin
                Next_state = Write_back;
            end
            MOVG: begin
                Next_state = Write_back;
            end
            MOVI: begin
                Next_state = Write_back;
            end
            MOVIEQ: begin
                Next_state = Write_back;
            end
            MOVIL: begin
                Next_state = Write_back;
            end
            MOVIG: begin
                Next_state = Write_back;
            end
//------------------------------------------------------------------------------ JB op
            JMP: begin
                Next_state = Fetch;
            end
            BEQ: begin
                Next_state = Fetch;
            end
            BL: begin
                Next_state = Fetch;
            end
            BG: begin
                Next_state = Fetch;
            end
//------------------------------------------------------------------------------ LAD, STR op
            LAD: begin
                Next_state = Fetch;                     // load is executed in Write_back
            end
            STR: begin
                Next_state = Fetch;                     // store is executed in exe
            end
            default: begin
                Next_state = Current_state;
            end
        endcase
    end

//------------------------------------------------------------------------------ generate pulse signal
    initial begin
        en_fetch_reg = 1'b0;
        en_exe_reg = 1'b0;
    end

    always @ (posedge clk) begin
        if(reset) begin
            en_fetch_reg <= 1'b0;
            en_exe_reg <= 1'b0;
        end
        else begin
            en_fetch_reg <= en_fetch;
            en_exe_reg <= en_exe;
        end
    end

    always @ (en_fetch or en_fetch_reg) begin
        en_fetch_pulse = en_fetch & (~en_fetch_reg);
    end

    always @ (en_exe or en_exe_reg) begin
        en_exe_pulse = en_exe & (~en_exe_reg);
    end

//------------------------------------------------------------------------------ control lines
    always @ (reset or Next_state) begin
	    if(reset) begin                                 // initalise
            en_fetch = 1'b0;                           // Disable fetch
            en_exe = 1'b0;                             // Disable execuate
            
		    alu_control = 5'b00000;                    // No ALU operation
            regwrite = 1'b0;                           // Disable register_file writing
            in2_muxcontrol = 1'b0;                     // Choose imm
            wv_muxcontrol = 1'b0;                      // Choose alu_result
            mem_store = 1'b0;                          // Disable memory store
            mem_load = 1'b0;                           // Disable memory load
	    end
	    else begin
            case (Current_state)
//------------------------------------------------------------------------------ inital, fetch, decode, write back
                Initial: begin
                    en_fetch = 1'b0;                   // Disable fetch
                    en_exe = 1'b0;                     // Disable execuate

                    alu_control = 5'b00000;            // No ALU operation
                    regwrite = 1'b0;                   // Disable register_file writing
                    in2_muxcontrol = 1'b0;             // Choose imm
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_store = 1'b0;                  // Disable memory store
                    mem_load = 1'b0;                   // Disable memory load
                end
                Fetch: begin
                    en_fetch = 1'b1;                   // Enable fetch
                    en_exe = 1'b0;

                    alu_control = Fetch;               // Choose Fetch state
                    regwrite = 1'b0;
                    in2_muxcontrol = 1'b0;             // Choose imm
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_store = 1'b0;
                    mem_load = 1'b0;
                end
                Decode: begin
                    opcode = Instruction[31:27];        // get operation code
                    Rd = Instruction[26:23];            // get target reg
                    Rs = Instruction[22:19];            // get source reg 1
                    Rt = Instruction[18:15];            // get source reg 2
                    imm_ext = {{17{Instruction[14]}}, Instruction[14:0]};     // signed #imm expansion

                    en_fetch = 1'b0;
                    en_exe = 1'b0;

                    alu_control = Decode;              // Choose Decode state
                    regwrite = 1'b0;
                    in2_muxcontrol = 1'b0;             // Choose imm
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_store = 1'b0;
                    mem_load = 1'b0;

                end
                Write_back: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b0;

                    alu_control = Write_back;          // Choose Write_back state
                    regwrite = 1'b1;
                    in2_muxcontrol = 1'b0;             // Choose imm
                    // wv_muxcontrol = 1'b0;           // Depend on exe (ALU is alu_result(0), LAD is read_data(1))
                    mem_store = 1'b0;
                    mem_load = 1'b0;
                end
//------------------------------------------------------------------------------ arithmetic op
                ADD: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                     // Enable execuate

                    alu_control = ADD;                 // ALU performs ADD
                    regwrite = 1'b0;                   // Write result to register
                    in2_muxcontrol = 1'b1;             // Choose reg
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
                ADDI: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                     // Enable execuate

                    alu_control = ADDI;                // ALU performs ADDI
                    regwrite = 1'b0;                   // Write result to register
                    in2_muxcontrol = 1'b0;             // Choose imm
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
                SUB: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                     // Enable execuate

                    alu_control = SUB;                 // ALU performs SUB
                    regwrite = 1'b0;                   // Write result to register
                    in2_muxcontrol = 1'b1;             // Choose reg
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
                SUBI: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                     // Enable execuate

                    alu_control = SUBI;                // ALU performs SUBI
                    regwrite = 1'b0;                   // Write result to register
                    in2_muxcontrol = 1'b0;             // Choose imm
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
                MUL: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                     // Enable execuate

                    alu_control = MUL;                 // ALU performs MUL
                    regwrite = 1'b0;                   // Write result to register
                    in2_muxcontrol = 1'b1;             // Choose reg
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
                MULI: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                     // Enable execuate

                    alu_control = MULI;                // ALU performs MULI
                    regwrite = 1'b0;                   // Write result to register
                    in2_muxcontrol = 1'b0;             // Choose imm
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
                MOD: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                     // Enable execuate

                    alu_control = MOD;                 // ALU performs MOD
                    regwrite = 1'b0;                   // Write result to register
                    in2_muxcontrol = 1'b1;             // Choose reg
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
                MODI: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                     // Enable execuate

                    alu_control = MODI;                // ALU performs MODI
                    regwrite = 1'b0;                   // Write result to register
                    in2_muxcontrol = 1'b0;             // Choose imm
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
//------------------------------------------------------------------------------ logic op
                AND: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                     // Enable execuate

                    alu_control = AND;                 // ALU performs AND
                    regwrite = 1'b0;                   // Write result to register
                    in2_muxcontrol = 1'b1;             // Choose reg
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
                OR: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                     // Enable execuate

                    alu_control = OR;                  // ALU performs OR
                    regwrite = 1'b0;                   // Write result to register
                    in2_muxcontrol = 1'b1;             // Choose reg
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
                XOR: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                     // Enable execuate

                    alu_control = XOR;                 // ALU performs XOR
                    regwrite = 1'b0;                   // Write result to register
                    in2_muxcontrol = 1'b1;             // Choose reg
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
                NOT: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                     // Enable execuate

                    alu_control = NOT;                 // ALU performs NOT
                    regwrite = 1'b0;                   // Write result to register
                    in2_muxcontrol = 1'b0;             // Choose imm
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
                LSFT: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                     // Enable execuate

                    alu_control = LSFT;                // ALU performs LSFT
                    regwrite = 1'b0;                   // Write result to register
                    in2_muxcontrol = 1'b0;             // Choose imm
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
                RSFT: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                     // Enable execuate

                    alu_control = RSFT;                // ALU performs RSFT
                    regwrite = 1'b0;                   // Write result to register
                    in2_muxcontrol = 1'b0;             // Choose imm
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
//------------------------------------------------------------------------------ MOV.etc op
                MOV: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                     // Enable execuate

                    alu_control = MOV;                 // ALU performs MOV
                    regwrite = 1'b0;                   // Write result to register
                    in2_muxcontrol = 1'b1;             // Choose reg
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
                MOVI: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                     // Enable execuate

                    alu_control = MOVI;                // ALU performs MOVI
                    regwrite = 1'b0;                   // Write result to register
                    in2_muxcontrol = 1'b0;             // Choose imm
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
                MOVEQ: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                      // Enable execuate

                    alu_control = MOVEQ;               // ALU performs MOVEQ
                    regwrite = 1'b0;                   // Write result to register if condition met
                    in2_muxcontrol = 1'b1;             // Choose reg
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
                MOVL: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                      // Enable execuate

                    alu_control = MOVL;                // ALU performs MOVL
                    regwrite = 1'b0;                   // Write result to register if condition met
                    in2_muxcontrol = 1'b1;             // Choose reg
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
                MOVG: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                      // Enable execuate

                    alu_control = MOVG;                // ALU performs MOVG
                    regwrite = 1'b0;                   // Write result to register if condition met
                    in2_muxcontrol = 1'b1;             // Choose reg
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
                MOVIEQ: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                      // Enable execuate

                    alu_control = MOVIEQ;              // ALU performs MOVIEQ
                    regwrite = 1'b0;                   // Write result to register if condition met
                    in2_muxcontrol = 1'b0;             // Choose imm
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
                MOVIL: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                      // Enable execuate

                    alu_control = MOVIL;               // ALU performs MOVIL
                    regwrite = 1'b0;                   // Write result to register if condition met
                    in2_muxcontrol = 1'b0;             // Choose imm
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
                MOVIG: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                      // Enable execuate
                    
                    alu_control = MOVIG;               // ALU performs MOVIG
                    regwrite = 1'b0;                   // Write result to register if condition met
                    in2_muxcontrol = 1'b0;             // Choose imm
                    wv_muxcontrol = 1'b0;              // Choose alu_result
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
//------------------------------------------------------------------------------ LAD, STR op
                LAD: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                     // Enable execuate

                    alu_control = LAD;                 // Ins performs LOAD
                    regwrite = 1'b1;
                    in2_muxcontrol = 1'b0;             // Choose imm (calculate address)
                    wv_muxcontrol = 1'b1;              // Choose read_data
                    mem_load = 1'b1;                   // Enable load
                    mem_store = 1'b0;
                end
                STR: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                     // Enable execuate

                    alu_control = STR;                 // Ins performs store
                    regwrite = 1'b0;
                    in2_muxcontrol = 1'b0;             // Choose imm (calculate address)
                    wv_muxcontrol = 1'b0;              // Disable this
                    mem_load = 1'b0;
                    mem_store = 1'b1;                  // Enable store
                end
//------------------------------------------------------------------------------ JB op
                JMP: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                     // Enable execuate

                    alu_control = JMP;                 // Ins performs JMP
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                    regwrite = 1'b0;
                    in2_muxcontrol = 1'b0;
                    wv_muxcontrol = 1'b0;
                end
                BEQ: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                     // Enable execuate

                    alu_control = BEQ;                 // Ins performs BEQ
                    regwrite = 1'b0;
                    in2_muxcontrol = 1'b0;
                    wv_muxcontrol = 1'b0;
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
                BL: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                     // Enable execuate

                    alu_control = BL;                  // Ins performs BL
                    regwrite = 1'b0;
                    in2_muxcontrol = 1'b0;
                    wv_muxcontrol = 1'b0;
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
                BG: begin
                    en_fetch = 1'b0;
                    en_exe = 1'b1;                     // Enable execuate

                    alu_control = BG;                  // Ins performs BG
                    regwrite = 1'b0;
                    in2_muxcontrol = 1'b0;
                    wv_muxcontrol = 1'b0;
                    mem_load = 1'b0;
                    mem_store = 1'b0;
                end
                default: begin                          // Do nothing for unsupported opcodes
                    en_fetch = 1'b0;                   // Disable all & re-fetch --> initialise
                    en_exe = 1'b0;                     // stop execution
                    
                    alu_control = 5'b00000;
                    regwrite = 1'b0;
                    in2_muxcontrol = 1'b0;
                    wv_muxcontrol = 1'b0;
                    mem_store = 1'b0;
                    mem_load = 1'b0;
                end       
            endcase
        end
    end

endmodule

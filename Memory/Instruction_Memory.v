`timescale 1ns / 1ps

module Instruction_Memory (ins_address, en_fetch_pulse, Instruction);

    input wire [31:0] ins_address;
    input wire en_fetch_pulse;
    output reg [31:0] Instruction;

    reg [7:0] instruction_memory [0:363];  // Instruction Memory: 256 bytes for storing instructions

    // Read instructions from main memory
    always @(*) begin
        if (en_fetch_pulse) begin
            Instruction = {instruction_memory[ins_address + 3], instruction_memory[ins_address + 2], instruction_memory[ins_address + 1], instruction_memory[ins_address]};
        end
    end

    // initialise memory
    initial begin
        instruction_memory[3]  <= 8'h78;
        instruction_memory[2]  <= 8'h80;
        instruction_memory[1]  <= 8'h00;
        instruction_memory[0]  <= 8'h03;

        instruction_memory[7]  <= 8'h19;
        instruction_memory[6]  <= 8'h08;
        instruction_memory[5]  <= 8'h00;
        instruction_memory[4]  <= 8'h0f;

        instruction_memory[11]  <= 8'h11;
        instruction_memory[10]  <= 8'h89;
        instruction_memory[9]  <= 8'h00;
        instruction_memory[8]  <= 8'h00;

        instruction_memory[15]  <= 8'h2a;
        instruction_memory[14]  <= 8'h10;
        instruction_memory[13]  <= 8'h00;
        instruction_memory[12]  <= 8'h02;

        instruction_memory[19]  <= 8'h22;
        instruction_memory[18]  <= 8'h9a;
        instruction_memory[17]  <= 8'h00;
        instruction_memory[16]  <= 8'h00;

        instruction_memory[23]  <= 8'h3b;
        instruction_memory[22]  <= 8'h20;
        instruction_memory[21]  <= 8'h00;
        instruction_memory[20]  <= 8'h04;

        instruction_memory[27]  <= 8'h33;
        instruction_memory[26]  <= 8'h9a;
        instruction_memory[25]  <= 8'h00;
        instruction_memory[24]  <= 8'h00;

        instruction_memory[31]  <= 8'h54;
        instruction_memory[30]  <= 8'h1a;
        instruction_memory[29]  <= 8'h80;
        instruction_memory[28]  <= 8'h00;

        instruction_memory[35]  <= 8'h5c;
        instruction_memory[34]  <= 8'h91;
        instruction_memory[33]  <= 8'h80;
        instruction_memory[32]  <= 8'h00;

        instruction_memory[39]  <= 8'h65;
        instruction_memory[38]  <= 8'h11;
        instruction_memory[37]  <= 8'h80;
        instruction_memory[36]  <= 8'h00;

        instruction_memory[43]  <= 8'h6d;
        instruction_memory[42]  <= 8'h90;
        instruction_memory[41]  <= 8'h00;
        instruction_memory[40]  <= 8'h00;

        instruction_memory[47]  <= 8'he6;
        instruction_memory[46]  <= 8'h30;
        instruction_memory[45]  <= 8'h00;
        instruction_memory[44]  <= 8'h03;

        instruction_memory[51]  <= 8'hee;
        instruction_memory[50]  <= 8'he0;
        instruction_memory[49]  <= 8'h00;
        instruction_memory[48]  <= 8'h01;

        instruction_memory[55]  <= 8'hc0;
        instruction_memory[54]  <= 8'h00;
        instruction_memory[53]  <= 8'h00;
        instruction_memory[52]  <= 8'h3c;

        instruction_memory[59]  <= 8'h76;
        instruction_memory[58]  <= 8'h80;
        instruction_memory[57]  <= 8'h80;
        instruction_memory[56]  <= 8'h00;

        instruction_memory[63]  <= 8'h76;
        instruction_memory[62]  <= 8'h81;
        instruction_memory[61]  <= 8'h00;
        instruction_memory[60]  <= 8'h00;

        instruction_memory[67]  <= 8'h2f;
        instruction_memory[66]  <= 8'h28;
        instruction_memory[65]  <= 8'h00;
        instruction_memory[64]  <= 8'h07;

        instruction_memory[71]  <= 8'hd0;
        instruction_memory[70]  <= 8'h00;
        instruction_memory[69]  <= 8'h00;
        instruction_memory[68]  <= 8'h4c;

        instruction_memory[75]  <= 8'h76;
        instruction_memory[74]  <= 8'h81;
        instruction_memory[73]  <= 8'h80;
        instruction_memory[72]  <= 8'h00;

        instruction_memory[79]  <= 8'h76;
        instruction_memory[78]  <= 8'h82;
        instruction_memory[77]  <= 8'h00;
        instruction_memory[76]  <= 8'h00;

        instruction_memory[83]  <= 8'h2f;
        instruction_memory[82]  <= 8'h08;
        instruction_memory[81]  <= 8'h00;
        instruction_memory[80]  <= 8'h00;

        instruction_memory[87]  <= 8'hd0;
        instruction_memory[86]  <= 8'h00;
        instruction_memory[85]  <= 8'h00;
        instruction_memory[84]  <= 8'h5c;

        instruction_memory[91]  <= 8'h76;
        instruction_memory[90]  <= 8'h82;
        instruction_memory[89]  <= 8'h80;
        instruction_memory[88]  <= 8'h00;

        instruction_memory[95]  <= 8'h76;
        instruction_memory[94]  <= 8'h83;
        instruction_memory[93]  <= 8'h00;
        instruction_memory[92]  <= 8'h00;

        instruction_memory[99]  <= 8'h2f;
        instruction_memory[98]  <= 8'h08;
        instruction_memory[97]  <= 8'h00;
        instruction_memory[96]  <= 8'h03;

        instruction_memory[103]  <= 8'hd0;
        instruction_memory[102]  <= 8'h00;
        instruction_memory[101]  <= 8'h00;
        instruction_memory[100]  <= 8'h6c;

        instruction_memory[107]  <= 8'h76;
        instruction_memory[106]  <= 8'h83;
        instruction_memory[105]  <= 8'h80;
        instruction_memory[104]  <= 8'h00;

        instruction_memory[111]  <= 8'h76;
        instruction_memory[110]  <= 8'h84;
        instruction_memory[109]  <= 8'h80;
        instruction_memory[108]  <= 8'h00;

        instruction_memory[115]  <= 8'h2f;
        instruction_memory[114]  <= 8'h28;
        instruction_memory[113]  <= 8'h00;
        instruction_memory[112]  <= 8'h07;

        instruction_memory[119]  <= 8'hd8;
        instruction_memory[118]  <= 8'h00;
        instruction_memory[117]  <= 8'h00;
        instruction_memory[116]  <= 8'h7c;

        instruction_memory[123]  <= 8'h76;
        instruction_memory[122]  <= 8'h81;
        instruction_memory[121]  <= 8'h80;
        instruction_memory[120]  <= 8'h00;

        instruction_memory[127]  <= 8'h76;
        instruction_memory[126]  <= 8'h82;
        instruction_memory[125]  <= 8'h00;
        instruction_memory[124]  <= 8'h00;

        instruction_memory[131]  <= 8'h2f;
        instruction_memory[130]  <= 8'h08;
        instruction_memory[129]  <= 8'h00;
        instruction_memory[128]  <= 8'h00;

        instruction_memory[135]  <= 8'hd8;
        instruction_memory[134]  <= 8'h00;
        instruction_memory[133]  <= 8'h00;
        instruction_memory[132]  <= 8'h8c;

        instruction_memory[139]  <= 8'h76;
        instruction_memory[138]  <= 8'h82;
        instruction_memory[137]  <= 8'h80;
        instruction_memory[136]  <= 8'h00;

        instruction_memory[143]  <= 8'h76;
        instruction_memory[142]  <= 8'h83;
        instruction_memory[141]  <= 8'h00;
        instruction_memory[140]  <= 8'h00;

        instruction_memory[147]  <= 8'h2f;
        instruction_memory[146]  <= 8'h08;
        instruction_memory[145]  <= 8'h00;
        instruction_memory[144]  <= 8'h03;

        instruction_memory[151]  <= 8'hd8;
        instruction_memory[150]  <= 8'h00;
        instruction_memory[149]  <= 8'h00;
        instruction_memory[148]  <= 8'h9c;

        instruction_memory[155]  <= 8'h76;
        instruction_memory[154]  <= 8'h83;
        instruction_memory[153]  <= 8'h80;
        instruction_memory[152]  <= 8'h00;

        instruction_memory[159]  <= 8'h76;
        instruction_memory[158]  <= 8'h84;
        instruction_memory[157]  <= 8'h80;
        instruction_memory[156]  <= 8'h00;

        instruction_memory[163]  <= 8'h2f;
        instruction_memory[162]  <= 8'h28;
        instruction_memory[161]  <= 8'h00;
        instruction_memory[160]  <= 8'h07;

        instruction_memory[167]  <= 8'hc8;
        instruction_memory[166]  <= 8'h00;
        instruction_memory[165]  <= 8'h00;
        instruction_memory[164]  <= 8'hac;

        instruction_memory[171]  <= 8'h76;
        instruction_memory[170]  <= 8'h81;
        instruction_memory[169]  <= 8'h80;
        instruction_memory[168]  <= 8'h00;

        instruction_memory[175]  <= 8'h76;
        instruction_memory[174]  <= 8'h82;
        instruction_memory[173]  <= 8'h00;
        instruction_memory[172]  <= 8'h00;

        instruction_memory[179]  <= 8'h2f;
        instruction_memory[178]  <= 8'h08;
        instruction_memory[177]  <= 8'h00;
        instruction_memory[176]  <= 8'h00;

        instruction_memory[183]  <= 8'hc8;
        instruction_memory[182]  <= 8'h00;
        instruction_memory[181]  <= 8'h00;
        instruction_memory[180]  <= 8'hbc;

        instruction_memory[187]  <= 8'h76;
        instruction_memory[186]  <= 8'h82;
        instruction_memory[185]  <= 8'h80;
        instruction_memory[184]  <= 8'h00;

        instruction_memory[191]  <= 8'h76;
        instruction_memory[190]  <= 8'h83;
        instruction_memory[189]  <= 8'h00;
        instruction_memory[188]  <= 8'h00;

        instruction_memory[195]  <= 8'h2f;
        instruction_memory[194]  <= 8'h08;
        instruction_memory[193]  <= 8'h00;
        instruction_memory[192]  <= 8'h03;

        instruction_memory[199]  <= 8'hc8;
        instruction_memory[198]  <= 8'h00;
        instruction_memory[197]  <= 8'h00;
        instruction_memory[196]  <= 8'hcc;

        instruction_memory[203]  <= 8'h76;
        instruction_memory[202]  <= 8'h83;
        instruction_memory[201]  <= 8'h80;
        instruction_memory[200]  <= 8'h00;

        instruction_memory[207]  <= 8'h76;
        instruction_memory[206]  <= 8'h84;
        instruction_memory[205]  <= 8'h80;
        instruction_memory[204]  <= 8'h00;

        instruction_memory[211]  <= 8'h2f;
        instruction_memory[210]  <= 8'h28;
        instruction_memory[209]  <= 8'h00;
        instruction_memory[208]  <= 8'h07;

        instruction_memory[215]  <= 8'h86;
        instruction_memory[214]  <= 8'h80;
        instruction_memory[213]  <= 8'h80;
        instruction_memory[212]  <= 8'h00;

        instruction_memory[219]  <= 8'h2f;
        instruction_memory[218]  <= 8'h08;
        instruction_memory[217]  <= 8'h00;
        instruction_memory[216]  <= 8'h00;

        instruction_memory[223]  <= 8'h86;
        instruction_memory[222]  <= 8'h81;
        instruction_memory[221]  <= 8'h00;
        instruction_memory[220]  <= 8'h00;

        instruction_memory[227]  <= 8'h2f;
        instruction_memory[226]  <= 8'h08;
        instruction_memory[225]  <= 8'h00;
        instruction_memory[224]  <= 8'h03;

        instruction_memory[231]  <= 8'h86;
        instruction_memory[230]  <= 8'h81;
        instruction_memory[229]  <= 8'h80;
        instruction_memory[228]  <= 8'h00;

        instruction_memory[235]  <= 8'h2f;
        instruction_memory[234]  <= 8'h28;
        instruction_memory[233]  <= 8'h00;
        instruction_memory[232]  <= 8'h07;

        instruction_memory[239]  <= 8'h96;
        instruction_memory[238]  <= 8'h80;
        instruction_memory[237]  <= 8'h80;
        instruction_memory[236]  <= 8'h00;

        instruction_memory[243]  <= 8'h2f;
        instruction_memory[242]  <= 8'h08;
        instruction_memory[241]  <= 8'h00;
        instruction_memory[240]  <= 8'h00;

        instruction_memory[247]  <= 8'h96;
        instruction_memory[246]  <= 8'h81;
        instruction_memory[245]  <= 8'h00;
        instruction_memory[244]  <= 8'h00;

        instruction_memory[251]  <= 8'h2f;
        instruction_memory[250]  <= 8'h08;
        instruction_memory[249]  <= 8'h00;
        instruction_memory[248]  <= 8'h03;

        instruction_memory[255]  <= 8'h96;
        instruction_memory[254]  <= 8'h81;
        instruction_memory[253]  <= 8'h80;
        instruction_memory[252]  <= 8'h00;

        instruction_memory[259]  <= 8'h2f;
        instruction_memory[258]  <= 8'h28;
        instruction_memory[257]  <= 8'h00;
        instruction_memory[256]  <= 8'h07;

        instruction_memory[263]  <= 8'ha6;
        instruction_memory[262]  <= 8'h80;
        instruction_memory[261]  <= 8'h80;
        instruction_memory[260]  <= 8'h00;

        instruction_memory[267]  <= 8'h2f;
        instruction_memory[266]  <= 8'h08;
        instruction_memory[265]  <= 8'h00;
        instruction_memory[264]  <= 8'h00;

        instruction_memory[271]  <= 8'ha6;
        instruction_memory[270]  <= 8'h81;
        instruction_memory[269]  <= 8'h00;
        instruction_memory[268]  <= 8'h00;

        instruction_memory[275]  <= 8'h2f;
        instruction_memory[274]  <= 8'h08;
        instruction_memory[273]  <= 8'h00;
        instruction_memory[272]  <= 8'h03;

        instruction_memory[279]  <= 8'ha6;
        instruction_memory[278]  <= 8'h81;
        instruction_memory[277]  <= 8'h80;
        instruction_memory[276]  <= 8'h00;

        instruction_memory[283]  <= 8'h2f;
        instruction_memory[282]  <= 8'h28;
        instruction_memory[281]  <= 8'h00;
        instruction_memory[280]  <= 8'h07;

        instruction_memory[287]  <= 8'h8e;
        instruction_memory[286]  <= 8'h80;
        instruction_memory[285]  <= 8'h00;
        instruction_memory[284]  <= 8'h03;

        instruction_memory[291]  <= 8'h2f;
        instruction_memory[290]  <= 8'h08;
        instruction_memory[289]  <= 8'h00;
        instruction_memory[288]  <= 8'h00;

        instruction_memory[295]  <= 8'h8e;
        instruction_memory[294]  <= 8'h80;
        instruction_memory[293]  <= 8'h00;
        instruction_memory[292]  <= 8'h12;

        instruction_memory[299]  <= 8'h2f;
        instruction_memory[298]  <= 8'h08;
        instruction_memory[297]  <= 8'h00;
        instruction_memory[296]  <= 8'h03;

        instruction_memory[303]  <= 8'h8e;
        instruction_memory[302]  <= 8'h80;
        instruction_memory[301]  <= 8'h00;
        instruction_memory[300]  <= 8'h15;

        instruction_memory[307]  <= 8'h2f;
        instruction_memory[306]  <= 8'h28;
        instruction_memory[305]  <= 8'h00;
        instruction_memory[304]  <= 8'h07;

        instruction_memory[311]  <= 8'h9e;
        instruction_memory[310]  <= 8'h80;
        instruction_memory[309]  <= 8'h00;
        instruction_memory[308]  <= 8'h03;

        instruction_memory[315]  <= 8'h2f;
        instruction_memory[314]  <= 8'h08;
        instruction_memory[313]  <= 8'h00;
        instruction_memory[312]  <= 8'h00;

        instruction_memory[319]  <= 8'h9e;
        instruction_memory[318]  <= 8'h80;
        instruction_memory[317]  <= 8'h00;
        instruction_memory[316]  <= 8'h12;

        instruction_memory[323]  <= 8'h2f;
        instruction_memory[322]  <= 8'h08;
        instruction_memory[321]  <= 8'h00;
        instruction_memory[320]  <= 8'h03;

        instruction_memory[327]  <= 8'h9e;
        instruction_memory[326]  <= 8'h80;
        instruction_memory[325]  <= 8'h00;
        instruction_memory[324]  <= 8'h15;

        instruction_memory[331]  <= 8'h2f;
        instruction_memory[330]  <= 8'h28;
        instruction_memory[329]  <= 8'h00;
        instruction_memory[328]  <= 8'h07;

        instruction_memory[335]  <= 8'hae;
        instruction_memory[334]  <= 8'h80;
        instruction_memory[333]  <= 8'h00;
        instruction_memory[332]  <= 8'h03;

        instruction_memory[339]  <= 8'h2f;
        instruction_memory[338]  <= 8'h08;
        instruction_memory[337]  <= 8'h00;
        instruction_memory[336]  <= 8'h00;

        instruction_memory[343]  <= 8'hae;
        instruction_memory[342]  <= 8'h80;
        instruction_memory[341]  <= 8'h00;
        instruction_memory[340]  <= 8'h12;

        instruction_memory[347]  <= 8'h2f;
        instruction_memory[346]  <= 8'h08;
        instruction_memory[345]  <= 8'h00;
        instruction_memory[344]  <= 8'h03;

        instruction_memory[351]  <= 8'hae;
        instruction_memory[350]  <= 8'h80;
        instruction_memory[349]  <= 8'h00;
        instruction_memory[348]  <= 8'h15;

        instruction_memory[355]  <= 8'hb8;
        instruction_memory[354]  <= 8'h0c;
        instruction_memory[353]  <= 8'h80;
        instruction_memory[352]  <= 8'h01;

        instruction_memory[359]  <= 8'hb7;
        instruction_memory[358]  <= 8'h88;
        instruction_memory[357]  <= 8'h00;
        instruction_memory[356]  <= 8'h01;

        instruction_memory[363]  <= 8'h77;
        instruction_memory[362]  <= 8'h87;
        instruction_memory[361]  <= 8'h80;
        instruction_memory[360]  <= 8'h00;

    end

endmodule

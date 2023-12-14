`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2020 05:42:59 PM
// Design Name: 
// Module Name: synthesizer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module synthesizer(
input clk,
input ena_sampleRatex64,
input ena,
input [9:0]key,
input [4:0] pitchshift_in,
input [7:0] volume_in,
input [7:0] modulation_in,
output reg [31:0] data, // [15:0]为左声道
output reg i2s_ena = 0
    );
    
    reg [7:0] volume, volumea, volumeb;
    reg [7:0] modulation;
    reg [15:0] volumea_256, volumeb_256;
    reg [4:0] pitchshift;
    
    reg working = 0;
    reg init = 0;
    reg [5:0] cnt;
    reg [15:0] data_synla, data_synra, data_synlb, data_synrb;
    reg [15:0] data_plusla, data_plusra, data_pluslb, data_plusrb;
    reg [15:0] pitch0a, pitch1a, pitch2a, pitch3a, pitch4a, pitch5a, pitch6a, pitch7a, pitch8a, pitch9a;
    reg [15:0] pitch0b, pitch1b, pitch2b, pitch3b, pitch4b, pitch5b, pitch6b, pitch7b, pitch8b, pitch9b;
    reg playing0 = 0, playing1 = 0, playing2 = 0, playing3 = 0, playing4 = 0, playing5 = 0, playing6 = 0, playing7 = 0, playing8 = 0, playing9 = 0;
    
    reg [7:0] sampleIndex0 = 0, sampleIndex1 = 0, sampleIndex2 = 0, sampleIndex3 = 0, sampleIndex4 = 0, sampleIndex5 = 0, sampleIndex6 = 0, sampleIndex7 = 0, sampleIndex8 = 0, sampleIndex9 = 0;
    reg [11:0] sampleCnt0 = 1, sampleCnt1 = 1, sampleCnt2 = 1, sampleCnt3 = 1, sampleCnt4 = 1, sampleCnt5 = 1, sampleCnt6 = 1, sampleCnt7 = 1, sampleCnt8 = 1, sampleCnt9 = 1; // 各音采样点间距计数
    reg [11:0] tps0 = 1776, tps1 = 1582, tps2 = 1493, tps3 = 1330, tps4 = 1185, tps5 = 1119, tps6 = 996, tps7 = 888, tps8 = 791, tps9 = 747;
    
    reg [7:0] aa, ab;
    wire [15:0] spoa, spob;
    
    dist_mem_gen_0 rom_samplea (
      .a(aa),      // input wire [7 : 0] a
      .spo(spoa)  // output wire [15 : 0] spo
    );
    dist_mem_gen_1 rom_sampleb (
      .a(ab),      // input wire [7 : 0] a
      .spo(spob)  // output wire [15 : 0] spo
    );
    
    always @ (posedge clk) begin
        if (~working && ~init) // 启动
            if (ena) begin
                init <= 1'b1;
                cnt <= 6'b111111;
                i2s_ena <= 0;
            end
            
        if (init) begin // 初始化，载入采样
            pitchshift <= 7;
            tps0 <= 1776; tps1 <= 1582; tps2 <= 1493; tps3 <= 1330; tps4 <= 1185; tps5 <= 1119; tps6 <= 996; tps7 <= 888; tps8 <= 791; tps9 <= 747;
            init <= 0;
            working <= 1;
        end
        
        if (working) begin // 工作
            if (ena_sampleRatex64) begin // 输出与采样
                cnt <= cnt == 6'b111111 ? 0 : cnt + 6'b1;
                
                if (~ena) begin // 关闭
                    working <= 0;
                    i2s_ena <= 0;
                end
                
                if (cnt == 6'b000001) pitchshift <= pitchshift_in;
                
                if (cnt == 6'b000010) begin // 移调
                    case (pitchshift) // ticks per sample 采样点间距 390625/频率
                        0: begin tps0 <= 2660; tps1 <= 2370; tps2 <= 2237; tps3 <= 1993; tps4 <= 1776; tps5 <= 1676; tps6 <= 1493; tps7 <= 1330; tps8 <= 1185; tps9 <= 1119; end
                        1: begin tps0 <= 2511; tps1 <= 2237; tps2 <= 2111; tps3 <= 1881; tps4 <= 1676; tps5 <= 1582; tps6 <= 1409; tps7 <= 1256; tps8 <= 1119; tps9 <= 1056; end
                        2: begin tps0 <= 2370; tps1 <= 2111; tps2 <= 1993; tps3 <= 1776; tps4 <= 1582; tps5 <= 1493; tps6 <= 1330; tps7 <= 1185; tps8 <= 1056; tps9 <= 996; end
                        3: begin tps0 <= 2237; tps1 <= 1993; tps2 <= 1881; tps3 <= 1676; tps4 <= 1493; tps5 <= 1409; tps6 <= 1256; tps7 <= 1119; tps8 <= 996; tps9 <= 941; end
                        4: begin tps0 <= 2111; tps1 <= 1881; tps2 <= 1776; tps3 <= 1582; tps4 <= 1409; tps5 <= 1330; tps6 <= 1185; tps7 <= 1056; tps8 <= 941; tps9 <= 888; end
                        5: begin tps0 <= 1993; tps1 <= 1776; tps2 <= 1676; tps3 <= 1493; tps4 <= 1330; tps5 <= 1256; tps6 <= 1119; tps7 <= 996; tps8 <= 888; tps9 <= 838; end
                        6: begin tps0 <= 1881; tps1 <= 1676; tps2 <= 1582; tps3 <= 1409; tps4 <= 1256; tps5 <= 1185; tps6 <= 1056; tps7 <= 941; tps8 <= 838; tps9 <= 791; end
                        7: begin tps0 <= 1776; tps1 <= 1582; tps2 <= 1493; tps3 <= 1330; tps4 <= 1185; tps5 <= 1119; tps6 <= 996; tps7 <= 888; tps8 <= 791; tps9 <= 747; end
                        8: begin tps0 <= 1676; tps1 <= 1493; tps2 <= 1409; tps3 <= 1256; tps4 <= 1119; tps5 <= 1056; tps6 <= 941; tps7 <= 838; tps8 <= 747; tps9 <= 705; end
                        9: begin tps0 <= 1582; tps1 <= 1409; tps2 <= 1330; tps3 <= 1185; tps4 <= 1056; tps5 <= 996; tps6 <= 888; tps7 <= 791; tps8 <= 705; tps9 <= 665; end
                        10: begin tps0 <= 1493; tps1 <= 1330; tps2 <= 1256; tps3 <= 1119; tps4 <= 996; tps5 <= 941; tps6 <= 838; tps7 <= 747; tps8 <= 665; tps9 <= 628; end
                        11: begin tps0 <= 1409; tps1 <= 1256; tps2 <= 1185; tps3 <= 1056; tps4 <= 941; tps5 <= 888; tps6 <= 791; tps7 <= 705; tps8 <= 628; tps9 <= 593; end
                        12: begin tps0 <= 1330; tps1 <= 1185; tps2 <= 1119; tps3 <= 996; tps4 <= 888; tps5 <= 838; tps6 <= 747; tps7 <= 665; tps8 <= 593; tps9 <= 559; end
                        13: begin tps0 <= 1256; tps1 <= 1119; tps2 <= 1056; tps3 <= 941; tps4 <= 838; tps5 <= 791; tps6 <= 705; tps7 <= 628; tps8 <= 559; tps9 <= 528; end
                        14: begin tps0 <= 1185; tps1 <= 1056; tps2 <= 996; tps3 <= 888; tps4 <= 791; tps5 <= 747; tps6 <= 665; tps7 <= 593; tps8 <= 528; tps9 <= 498; end
                        15: begin tps0 <= 1119; tps1 <= 996; tps2 <= 941; tps3 <= 838; tps4 <= 747; tps5 <= 705; tps6 <= 628; tps7 <= 559; tps8 <= 498; tps9 <= 470; end
                        16: begin tps0 <= 1056; tps1 <= 941; tps2 <= 888; tps3 <= 791; tps4 <= 705; tps5 <= 665; tps6 <= 593; tps7 <= 528; tps8 <= 470; tps9 <= 444; end
                        17: begin tps0 <= 996; tps1 <= 888; tps2 <= 838; tps3 <= 747; tps4 <= 665; tps5 <= 628; tps6 <= 559; tps7 <= 498; tps8 <= 444; tps9 <= 419; end
                        18: begin tps0 <= 941; tps1 <= 838; tps2 <= 791; tps3 <= 705; tps4 <= 628; tps5 <= 593; tps6 <= 528; tps7 <= 470; tps8 <= 419; tps9 <= 395; end
                        19: begin tps0 <= 888; tps1 <= 791; tps2 <= 747; tps3 <= 665; tps4 <= 593; tps5 <= 559; tps6 <= 498; tps7 <= 444; tps8 <= 395; tps9 <= 373; end
                    endcase
                end
                
                if (cnt == 6'b010000) begin if (playing0) begin aa <= sampleIndex0; ab <= sampleIndex0; end end
                if (cnt == 6'b010001) begin if (playing0) begin pitch0a <= spoa; pitch0b <= spob; end else begin pitch0a <= 0; pitch0b <= 0;end end // 波形读取
                if (cnt == 6'b010010) begin if (playing1) begin aa <= sampleIndex1; ab <= sampleIndex1; end end
                if (cnt == 6'b010011) begin if (playing1) begin pitch1a <= spoa; pitch1b <= spob; end else begin pitch1a <= 0; pitch1b <= 0;end end // 波形读取
                if (cnt == 6'b010100) begin if (playing2) begin aa <= sampleIndex2; ab <= sampleIndex2; end end
                if (cnt == 6'b010101) begin if (playing2) begin pitch2a <= spoa; pitch2b <= spob; end else begin pitch2a <= 0; pitch2b <= 0;end end // 波形读取
                if (cnt == 6'b010110) begin if (playing3) begin aa <= sampleIndex3; ab <= sampleIndex3; end end
                if (cnt == 6'b010111) begin if (playing3) begin pitch3a <= spoa; pitch3b <= spob; end else begin pitch3a <= 0; pitch3b <= 0;end end // 波形读取
                if (cnt == 6'b011000) begin if (playing4) begin aa <= sampleIndex4; ab <= sampleIndex4; end end
                if (cnt == 6'b011001) begin if (playing4) begin pitch4a <= spoa; pitch4b <= spob; end else begin pitch4a <= 0; pitch4b <= 0;end end // 波形读取
                if (cnt == 6'b011010) begin if (playing5) begin aa <= sampleIndex5; ab <= sampleIndex5; end end
                if (cnt == 6'b011011) begin if (playing5) begin pitch5a <= spoa; pitch5b <= spob; end else begin pitch5a <= 0; pitch5b <= 0;end end // 波形读取
                if (cnt == 6'b011100) begin if (playing6) begin aa <= sampleIndex6; ab <= sampleIndex6; end end
                if (cnt == 6'b011101) begin if (playing6) begin pitch6a <= spoa; pitch6b <= spob; end else begin pitch6a <= 0; pitch6b <= 0;end end // 波形读取
                if (cnt == 6'b011110) begin if (playing7) begin aa <= sampleIndex7; ab <= sampleIndex7; end end
                if (cnt == 6'b011111) begin if (playing7) begin pitch7a <= spoa; pitch7b <= spob; end else begin pitch7a <= 0; pitch7b <= 0;end end // 波形读取
                if (cnt == 6'b100000) begin if (playing8) begin aa <= sampleIndex8; ab <= sampleIndex8; end end
                if (cnt == 6'b100001) begin if (playing8) begin pitch8a <= spoa; pitch8b <= spob; end else begin pitch8a <= 0; pitch8b <= 0;end end // 波形读取
                if (cnt == 6'b100010) begin if (playing9) begin aa <= sampleIndex9; ab <= sampleIndex9; end end
                if (cnt == 6'b100011) begin if (playing9) begin pitch9a <= spoa; pitch9b <= spob; end else begin pitch9a <= 0; pitch9b <= 0;end end // 波形读取
                
                if (cnt == 6'b101010) begin
                    data_plusla <= pitch0a + pitch1a + pitch2a + pitch3a + pitch4a + pitch5a + pitch6a + pitch7a + pitch8a + pitch9a;
                    data_plusra <= pitch0a + pitch1a + pitch2a + pitch3a + pitch4a + pitch5a + pitch6a + pitch7a + pitch8a + pitch9a;
                    data_pluslb <= pitch0b + pitch1b + pitch2b + pitch3b + pitch4b + pitch5b + pitch6b + pitch7b + pitch8b + pitch9b;
                    data_plusrb <= pitch0b + pitch1b + pitch2b + pitch3b + pitch4b + pitch5b + pitch6b + pitch7b + pitch8b + pitch9b;
                    volume <= volume_in;
                    modulation <= modulation_in;
                end
                
                if (cnt == 6'b101011) begin
                    volumea_256 <= volume * (8'hff - modulation);
                    volumeb_256 <= volume * modulation;
                end
                
                if (cnt == 6'b101100) begin
                    volumea <= volumea_256[15:8];
                    volumeb <= volumeb_256[15:8];
                end
                
                if (cnt == 6'b111100) begin
                    if (data_plusla[15] == 1'b0)
                        if (volumea < 8'b00111111) data_synla <= data_plusla - ((8'b01000000 - volumea) * (data_plusla >> 6));
                        else data_synla <= data_plusla + ((volumea - 8'b01000000) * (data_plusla >> 6));
                    else
                        if (volumea < 8'b00111111) data_synla <= ~((~data_plusla + 16'b1) - ((8'b01000000 - volumea) * ((~data_plusla + 16'b1) >> 6))) + 16'b1;
                        else data_synla <= ~((~data_plusla + 16'b1) + ((volumea - 8'b01000000) * ((~data_plusla + 16'b1) >> 6))) + 16'b1; 
                    data_synra = data_synla;
                    if (data_pluslb[15] == 1'b0)
                        if (volumeb < 8'b00111111) data_synlb <= data_pluslb - ((8'b01000000 - volumeb) * (data_pluslb >> 6));
                        else data_synlb <= data_pluslb + ((volumeb - 8'b01000000) * (data_pluslb >> 6));
                    else
                        if (volumeb < 8'b00111111) data_synlb <= ~((~data_pluslb + 16'b1) - ((8'b01000000 - volumeb) * ((~data_pluslb + 16'b1) >> 6))) + 16'b1;
                        else data_synlb <= ~((~data_pluslb + 16'b1) + ((volumeb - 8'b01000000) * ((~data_pluslb + 16'b1) >> 6))) + 16'b1; 
                    data_synrb = data_synlb;
                end
                
                if (cnt == 6'b111111) begin // 采样输出
                    data <= {data_synra + data_synrb, data_synla + data_synlb}; // 降低了音量
                    i2s_ena <= 1;
                end
                
            end
            
            sampleCnt0 <= sampleCnt0 >= tps0 ? 11'b1 : sampleCnt0 + 1;
            sampleCnt1 <= sampleCnt1 >= tps1 ? 11'b1 : sampleCnt1 + 1;
            sampleCnt2 <= sampleCnt2 >= tps2 ? 11'b1 : sampleCnt2 + 1;
            sampleCnt3 <= sampleCnt3 >= tps3 ? 11'b1 : sampleCnt3 + 1;
            sampleCnt4 <= sampleCnt4 >= tps4 ? 11'b1 : sampleCnt4 + 1;
            sampleCnt5 <= sampleCnt5 >= tps5 ? 11'b1 : sampleCnt5 + 1;
            sampleCnt6 <= sampleCnt6 >= tps6 ? 11'b1 : sampleCnt6 + 1;
            sampleCnt7 <= sampleCnt7 >= tps7 ? 11'b1 : sampleCnt7 + 1;
            sampleCnt8 <= sampleCnt8 >= tps8 ? 11'b1 : sampleCnt8 + 1;
            sampleCnt9 <= sampleCnt9 >= tps9 ? 11'b1 : sampleCnt9 + 1;
            sampleIndex0 <= sampleCnt0 == tps0 ? (sampleIndex0 == 8'hff ? 0 : sampleIndex0 + 1) : sampleIndex0; // 进入下一采样点
            sampleIndex1 <= sampleCnt1 == tps1 ? (sampleIndex1 == 8'hff ? 0 : sampleIndex1 + 1) : sampleIndex1;
            sampleIndex2 <= sampleCnt2 == tps2 ? (sampleIndex2 == 8'hff ? 0 : sampleIndex2 + 1) : sampleIndex2;
            sampleIndex3 <= sampleCnt3 == tps3 ? (sampleIndex3 == 8'hff ? 0 : sampleIndex3 + 1) : sampleIndex3;
            sampleIndex4 <= sampleCnt4 == tps4 ? (sampleIndex4 == 8'hff ? 0 : sampleIndex4 + 1) : sampleIndex4;
            sampleIndex5 <= sampleCnt5 == tps5 ? (sampleIndex5 == 8'hff ? 0 : sampleIndex5 + 1) : sampleIndex5;
            sampleIndex6 <= sampleCnt6 == tps6 ? (sampleIndex6 == 8'hff ? 0 : sampleIndex6 + 1) : sampleIndex6;
            sampleIndex7 <= sampleCnt7 == tps7 ? (sampleIndex7 == 8'hff ? 0 : sampleIndex7 + 1) : sampleIndex7;
            sampleIndex8 <= sampleCnt8 == tps8 ? (sampleIndex8 == 8'hff ? 0 : sampleIndex8 + 1) : sampleIndex8;
            sampleIndex9 <= sampleCnt9 == tps9 ? (sampleIndex9 == 8'hff ? 0 : sampleIndex9 + 1) : sampleIndex9;
            
            playing0 <= sampleIndex0 == 8'hff ? (key[0] ? 1 : 0) : playing0;
            playing1 <= sampleIndex1 == 8'hff ? (key[1] ? 1 : 0) : playing1;
            playing2 <= sampleIndex2 == 8'hff ? (key[2] ? 1 : 0) : playing2;
            playing3 <= sampleIndex3 == 8'hff ? (key[3] ? 1 : 0) : playing3;
            playing4 <= sampleIndex4 == 8'hff ? (key[4] ? 1 : 0) : playing4;
            playing5 <= sampleIndex5 == 8'hff ? (key[5] ? 1 : 0) : playing5;
            playing6 <= sampleIndex6 == 8'hff ? (key[6] ? 1 : 0) : playing6;
            playing7 <= sampleIndex7 == 8'hff ? (key[7] ? 1 : 0) : playing7;
            playing8 <= sampleIndex8 == 8'hff ? (key[8] ? 1 : 0) : playing8;
            playing9 <= sampleIndex9 == 8'hff ? (key[9] ? 1 : 0) : playing9;
            
        end
    end
    
endmodule

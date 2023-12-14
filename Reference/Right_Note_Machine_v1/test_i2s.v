`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2020 07:06:19 PM
// Design Name: 
// Module Name: test_i2s
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


module test_i2s(
    input [9:0] key,
    input [7:0] volume,
    input [7:0] modulation,
    input [4:0] pitchshift,
    input clk,
    input ena,
    output dout,
    output bclk,
    output sclk,
    output lrclk
    ); 
    wire i2s_ena, ena_sampleRatex64, ena_sampleRatex512;
    wire [31:0] data;
    wire rst;
    
    assign rst = 0;
    
    synthesizer U1 (.clk(clk), .ena_sampleRatex64(ena_sampleRatex64), .ena(ena), .data(data), .i2s_ena(i2s_ena), .volume_in(volume), .modulation_in(modulation), .pitchshift_in(pitchshift), .key(key));
    i2s_encoder U2 (.clk(clk), .ena_sampleRatex64(ena_sampleRatex64), .ena_sampleRatex512(ena_sampleRatex512), .ena(i2s_ena), .data(data), .bclk(bclk), .sclk(sclk), .lrclk(lrclk), .dout(dout));
    ENA_64xSampleRate U3 (.CLK_100M(clk), .RST(rst), .ENA(ena_sampleRatex64), .ENA_512x(ena_sampleRatex512)); 
endmodule

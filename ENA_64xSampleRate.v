`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2020 01:25:43 PM
// Design Name: 
// Module Name: ENA_64xSampleRate
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


module ENA_64xSampleRate( // 在RST后下一个时钟上升沿输出1脉冲
    input CLK_100M,
    input RST,
    output ENA,
    output ENA_512x
    );
    parameter sampleRate = 48000;
    parameter ticks = 4; //100000000/(512*sampleRate)
    reg [5:0] cnt = 0;
    reg [7:0] cnt2 = 0;
    always @ (posedge CLK_100M) begin
        if (RST) begin
            cnt <= 0;
            cnt2 <= 0;
        end
        else begin
            cnt <= cnt == ticks * 8 - 1 ? 0 : cnt + 1;
            cnt2 <= cnt2 == ticks - 1 ? 0 : cnt2 + 1;
        end
    end
    assign ENA = cnt == 1;
    assign ENA_512x = cnt2 == 1;
endmodule

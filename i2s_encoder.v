`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2020 02:49:37 PM
// Design Name: 
// Module Name: i2s_encoder
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


module i2s_encoder(
input clk,
input ena_sampleRatex64,
input ena_sampleRatex512,
input ena,
input [31:0] data,
output reg bclk = 0,
output reg sclk = 0,
output reg lrclk = 0,
output reg dout
    );
    
    reg [3:0] bitCnt = 15;
    reg [15:0] data_reg;
    reg working = 0;
    
    always @ (posedge clk) begin
        if (ena_sampleRatex512)
            sclk <= ~sclk;
        
        if (ena_sampleRatex64) begin
            if (~working) begin
                if (ena) begin
                    bitCnt <= 15;
                    working <= 1'b1;
                    bclk <= 0;
                    lrclk <= 0;
                    data_reg <= data[15:0];
                end
            end
            else begin
                bclk <= ~bclk;
                if (bclk) begin
                    bitCnt <= bitCnt == 0 ? 4'b1111 :bitCnt - 4'b1;
                    lrclk <= bitCnt == 0 ? ~lrclk : lrclk;
                    if (bitCnt == 0)
                        data_reg <= lrclk ? data[15:0] : data[31:16];
                    dout <= data_reg[bitCnt];
                end
                
                if (~ena) begin
                    working <= 0;
                    bitCnt <= 0;
                    bclk <= 1'b1;
                    lrclk <= 1'b1;
                    data_reg <= 0;
                end
            end
        end
    end
    
endmodule

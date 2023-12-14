`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:
// Design Name: 
// Module Name: pitchshifter
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

//This file was barely modified from the original
module pitchshifter(
input clk,
input btnl,
input btnr,
input rst,
output reg [4:0] pitchshift = 7
    );
    
    always @ (posedge clk) begin
        if (rst) pitchshift <= 7;
        else if (btnl) pitchshift <= pitchshift == 0 ? 0 : pitchshift - 1;
        else if (btnr) pitchshift <= pitchshift == 19 ? 19 : pitchshift + 1;
        else pitchshift <= pitchshift;
    end
    
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2020 09:44:57 AM
// Design Name: 
// Module Name: btn_dbc
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


module btn_dbc(
input clk,
input btn_in,
input rst,
input ena,
output btn
    );
    reg [1:0] debounce;
    
    always @ (posedge clk) begin
        if (rst) begin
            debounce <= 0;
        end
        begin
            case (debounce)
                0: debounce <= ena && btn_in;
                1: debounce <= ~ena ? 1 : (btn_in ? 2:0);
                2: debounce <= 3;
                3: debounce <= (ena &&~btn_in) ? 0:3;
                default: debounce <= 0;
            endcase
        end
    end
    assign btn = debounce == 2;
    
endmodule

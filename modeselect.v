`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/31 12:23:31
// Design Name: 
// Module Name: modeselect
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

module modeselect(
    input clk,
    input rst,
    input[9:0] note,
    input [4:0]pitchshift,
    input mode,
    output reg [9:0] Note,
    output reg [4:0] Pitchshift,
    input autospeed,
    input [2:0]songselect,
    input cycle,
    input pulse2,
    input pulse3
    );
    reg pulse;
    wire [9:0]romnote;
    wire [4:0] rompit;
    wire [9:0] maxlength;
    wire[3:0]beat;
    reg[9:0]i;// Status of the song playing
    Rom M2(.A(i),.romnote(romnote),.rompit(rompit),.beat(beat),.songselect(songselect),.ml(maxlength));
    always@(*) begin
    if(~mode||(i>= maxlength&&~cycle)) begin
        Note = note; Pitchshift = pitchshift;
     end
     
    else begin
        Note = romnote|note;Pitchshift= rompit;
        if(autospeed)
        pulse = pulse3;
        else
        pulse = pulse2;
        end
     end   

    
    reg[3:0] cnt;
    always@(negedge clk) begin
    if(rst) begin
        i<=0;cnt<=0;
    end
    else if(pulse) begin
        if( cnt== beat-1) begin
            cnt <= 0;
            i <= i+1;
            if( i>=maxlength)begin
            if(cycle)
            i <=0;
            else
            i <= maxlength+1'b1;
            end
        end
        else begin
            cnt <= cnt+1;i<=i;end
    end
    end
endmodule

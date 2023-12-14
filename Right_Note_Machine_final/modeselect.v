`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:
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


//This file has been modified from the original code
// This file basically acts like a sophisticated mask with storage. It will either let the input
// go back to the top file (interface) or loads a pre-recorded note from the memory
module modeselect(
    input clk,
    input rst,
    input recMode,
    input[9:0] note,
    input [4:0]pitchshift,
    input mode,
    input autospeed,
    input [2:0]songselect,
    input cycle,
    input pulse2,
    input pulse3,
    output reg [9:0] Note, //capital N note. Will either let lower case n note through or upload rom note through
    output reg [4:0] Pitchshift
    );
    
    reg pulse;
    wire [9:0]romnote;
    wire [4:0] rompit;
    wire [9:0] maxlength;
    wire [3:0]beat;
    reg [9:0]i;// Status of the song playing
    
    mem m2(recMode, pitchshift, note, i, songselect, maxlength, romnote, rompit, beat);
    
    always@(*) begin
        if(~mode||(i>= maxlength&&~cycle)) begin //assume this line is correct even though i have suspicions 0-0 ~Jon
            Note = note; 
            Pitchshift = pitchshift;
        end else begin
            Note = romnote|note;
            Pitchshift= rompit;
            if(autospeed) pulse = pulse3;
            else pulse = pulse2;
        end
     end   
   
    reg[3:0] cnt; //counter works with beats
    always@(negedge clk) begin
        if(rst) begin
            i<=0;
            cnt<=0;
        end
        else if(pulse) begin
            if(cnt == beat-1) begin
                cnt <= 0;
                i <= i+1;
                if(i >= maxlength) begin
                    if(cycle) i <=0;
                    else i <= maxlength+1'b1;
                end
            end else begin
                cnt <= cnt+1;
                i<=i;
            end
        end
    end
endmodule
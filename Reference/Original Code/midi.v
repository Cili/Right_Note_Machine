`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2020 07:50:29 PM
// Design Name: 
// Module Name: midi_test
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


module midi(
input clk,
input [9:0] key,
input ena,
input [7:0] volume,
input [6:0] program,
input [4:0] pitchshift,
output tx
    );
    
    wire tready, tstart, mready, mstart;
    wire [7:0] data;
    wire [7:0] tbus;
    
    message_encoder U3 (.clk(clk), .ena(ena), .key(key), .pitchshift(pitchshift), .program(program), .mstart(mstart), .mready(mready), .data(data));
    
    midi_encoder U2 (.volume_in(volume), .tbus(tbus), .tready(tready), .tstart(tstart), .data(data), .mstart(mstart), .mready(mready), .clk(clk));
    
    uart_tx U1 (.clk(clk), .start(tstart), .tbus(tbus), .tx(tx), .ready(tready));
endmodule

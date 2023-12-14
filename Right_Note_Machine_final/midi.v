`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:
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

// This module was slightly modified from the original. ~Jon
module midi(
    input clk,
    input [9:0] key,
    input ena,
    input [6:0] program,
    input [4:0] pitchshift,
    output tx
    );
    
    wire tready, tstart, mready, mstart;
    wire [7:0] data;
    wire [7:0] tbus;
    
    message_encoder U1(key, program, pitchshift, clk, mready, ena, data, mstart);
    midi_encoder U2(data, mstart, mready, clk, tbus, tready, start);
    uart_tx U3(clk, tbus, tstart, tx, tready);
endmodule
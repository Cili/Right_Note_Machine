`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:
// Design Name: 
// Module Name: message_encoder
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

// This module wslightly modified from the original. ~Jon
module message_encoder(
    input [9:0] key,
    input [6:0] program,
    input [4:0] pitchshift,
    input clk,
    input mready,
    input ena,
    output reg [7:0] data,
    output reg mstart = 0
    );
    
    reg [9:0] key_reg = 0;
    reg [9:0] difference;
    reg [4:0] pitchshift_reg = 7; //hard-coded start value
    reg [6:0] program_reg = 0;
    reg swifting = 0; //taylor's version
    
    always @ (posedge clk) begin
        difference <= key ^ key_reg; //you can mass xor bits like this? 
        if (~ena) begin 
            data <= 0; 
            key_reg <= 0; 
        end else begin
            if (mready) begin
                if (pitchshift_reg != pitchshift) begin // innitializing the pitch shifter
                    if (key_reg[0]) begin key_reg[0] <= 0; mstart <= 1; data <= {6'd0 + pitchshift_reg, 2'b0}; end
                    else if (key_reg[1]) begin key_reg[1] <= 0; mstart <= 1; data <= {6'd2 + pitchshift_reg, 2'b0}; end
                    else if (key_reg[2]) begin key_reg[2] <= 0; mstart <= 1; data <= {6'd3 + pitchshift_reg, 2'b0}; end
                    else if (key_reg[3]) begin key_reg[3] <= 0; mstart <= 1; data <= {6'd5 + pitchshift_reg, 2'b0}; end
                    else if (key_reg[4]) begin key_reg[4] <= 0; mstart <= 1; data <= {6'd7 + pitchshift_reg, 2'b0}; end
                    else if (key_reg[5]) begin key_reg[5] <= 0; mstart <= 1; data <= {6'd8 + pitchshift_reg, 2'b0}; end
                    else if (key_reg[6]) begin key_reg[6] <= 0; mstart <= 1; data <= {6'd10 + pitchshift_reg, 2'b0}; end
                    else if (key_reg[7]) begin key_reg[7] <= 0; mstart <= 1; data <= {6'd12 + pitchshift_reg, 2'b0}; end
                    else if (key_reg[8]) begin key_reg[8] <= 0; mstart <= 1; data <= {6'd14 + pitchshift_reg, 2'b0}; end
                    else if (key_reg[9]) begin key_reg[9] <= 0; mstart <= 1; data <= {6'd15 + pitchshift_reg, 2'b0}; end
                end else if (difference[0]) begin key_reg[0] <= key[0]; mstart <= 1; data <= key[0] ? {6'd0 + pitchshift_reg, 2'b10}:{6'd0 + pitchshift_reg, 2'b00}; end
                else if (difference[1]) begin key_reg[1] <= key[1]; mstart <= 1; data <= key[1] ? {6'd2 + pitchshift_reg, 2'b10}:{6'd2 + pitchshift_reg, 2'b00}; end
                else if (difference[2]) begin key_reg[2] <= key[2]; mstart <= 1; data <= key[2] ? {6'd3 + pitchshift_reg, 2'b10}:{6'd3 + pitchshift_reg, 2'b00}; end
                else if (difference[3]) begin key_reg[3] <= key[3]; mstart <= 1; data <= key[3] ? {6'd5 + pitchshift_reg, 2'b10}:{6'd5 + pitchshift_reg, 2'b00}; end
                else if (difference[4]) begin key_reg[4] <= key[4]; mstart <= 1; data <= key[4] ? {6'd7 + pitchshift_reg, 2'b10}:{6'd7 + pitchshift_reg, 2'b00}; end
                else if (difference[5]) begin key_reg[5] <= key[5]; mstart <= 1; data <= key[5] ? {6'd8 + pitchshift_reg, 2'b10}:{6'd8 + pitchshift_reg, 2'b00}; end
                else if (difference[6]) begin key_reg[6] <= key[6]; mstart <= 1; data <= key[6] ? {6'd10+ pitchshift_reg, 2'b10}:{6'd10 + pitchshift_reg, 2'b00}; end
                else if (difference[7]) begin key_reg[7] <= key[7]; mstart <= 1; data <= key[7] ? {6'd12+ pitchshift_reg, 2'b10}:{6'd12 + pitchshift_reg, 2'b00}; end
                else if (difference[8]) begin key_reg[8] <= key[8]; mstart <= 1; data <= key[8] ? {6'd14+ pitchshift_reg, 2'b10}:{6'd14 + pitchshift_reg, 2'b00}; end
                else if (difference[9]) begin key_reg[9] <= key[9]; mstart <= 1; data <= key[9] ? {6'd15+ pitchshift_reg, 2'b10}:{6'd15 + pitchshift_reg, 2'b00}; end
                else if (program_reg != program) begin program_reg <= program; mstart <= 1; data <= {program, 1'b1}; end
                else data <= 8'h00;
                pitchshift_reg <= pitchshift; //I moved this statement out of the one of the for loops above. I think this should always happen
            end else mstart <= 0;
        end
    end 
endmodule
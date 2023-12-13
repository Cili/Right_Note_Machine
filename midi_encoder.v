`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 
// Design Name: 
// Module Name: midi_encoder
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

// This module was simplified and altered from the original. ~Jon
module midi_encoder(
    input [7:0] data,
    input mstart,
    input mready,
    input clk,
    output reg [7:0] tbus,
    output tready,
    output reg tstart
    );
    
    reg working = 0;
    reg [1:0] datasel = 0;
    reg [7:0] data_reg;
    reg [23:0] midi;
    reg [7:0] volume = 64; //hard-coded volume
    
    assign mready = ~working;
    
    always @ (posedge clk) begin
        if (mstart && ~working) begin
            working <= 1'b1;
            datasel <= 'b0;
            data_reg <= data;
        end else begin
            tstart <= 'b0;
            if (working) begin
                if (tready) begin
                    tstart <= 1'b1;
                    case (datasel)
                        0: tbus <= midi[23:16];
                        1: tbus <= midi[15:8];
                        2: tbus <= midi[7:0];
                        3: tbus <= 'b0;
                    endcase
                    datasel <= datasel + 2'b01;
                end
                else begin
                    if (~tready) tstart <= 'b0;
                    if (datasel == 2'b11) begin
                        working <= 1'b0;
                        datasel <= 1'b0;
                    end
                end
            end
        end
    end
    
    always @ (*) begin
        if (data_reg[0]) begin
            midi[23:16] = 8'hc0;
            midi[15:8] = data_reg[7:1];
            midi[7:0] = data_reg[7:1];
        end else begin
                case (data_reg[1])
                    0: midi[23:16] = 8'h80;
                    1: midi[23:16] = 8'h90;
                endcase
                midi[15:8] = 8'h32 + data_reg[7:2];
                midi[7:0] = {1'b0, volume[7:1]};
        end   
    end 
endmodule